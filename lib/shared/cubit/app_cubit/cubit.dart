// ignore_for_file: prefer_const_constructors, argument_type_not_assignable_to_error_handler, unnecessary_null_in_if_null_operators, avoid_function_literals_in_foreach_calls

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social/models/create_user_model.dart';
import 'package:social/models/message_model.dart';
import 'package:social/models/post_model.dart';
import 'package:social/modules/chats_screen.dart';
import 'package:social/modules/feeds_screen.dart';
import 'package:social/modules/new_post.dart';
import 'package:social/modules/settings_screen.dart';
import 'package:social/modules/users_screen.dart';
import 'package:social/shared/components/constants.dart';
import 'package:social/shared/cubit/app_cubit/states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../styles/icon_broken.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  UserModel? model;
  // get user data ...
  void getUserData() {
    emit(AppGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model = UserModel.fromJson(value.data());
      emit(AppGetUserSuccessState());
    }).catchError((error) {
      print('error is ${error.toString()}');
      emit(AppGetUserErrorsState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> titels = [
    'Home',
    'Chats',
    'New post',
    'Users',
    'Settings',
  ];
  List<BottomNavigationBarItem> bottomNavBarItems = [
    BottomNavigationBarItem(icon: Icon(IconBroken.Home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(IconBroken.Chat), label: 'Chats'),
    BottomNavigationBarItem(icon: Icon(IconBroken.Paper_Upload), label: 'Post'),
    BottomNavigationBarItem(icon: Icon(IconBroken.Location), label: 'Users'),
    BottomNavigationBarItem(icon: Icon(IconBroken.Setting), label: 'Settings'),
  ];
// change bottom navigation bar state ...
  void changeBottomNavBarState(int index) {
    if (index == 2) {
      emit(AppNewPostState());
    }
    if (index == 1) {
      getAllUsers();
      currentIndex = index;
      emit(AppChangeBottomNavBarState());
    } else if (index == 4) {
      getUserData();
      currentIndex = index;
      emit(AppChangeBottomNavBarState());
    } else {
      currentIndex = index;
      emit(AppChangeBottomNavBarState());
    }
  }

// pick profile image ...
  ImagePicker picker = ImagePicker();
  File? profileImage;
  Future<void> getProfileImage() async {
    final XFile? pickedProfileImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedProfileImage != null) {
      profileImage = File(pickedProfileImage.path);
      emit(ProfileImageSuccessState());
    } else {
      emit(ProfileImageErrorState());
    }
  }

// pick cover image ...
  File? coverImage;
  Future<void> getCoverImage() async {
    final XFile? pickedCoverImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedCoverImage != null) {
      coverImage = File(pickedCoverImage.path);
      emit(CoverImageSuccessState());
    } else {
      emit(CoverImageErrorState());
    }
  }

// upload profile image to Fire storage ...
  String profileUrl = '';
  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      emit(UploadProfileImageSuccessState());
      value.ref.getDownloadURL().then((value) {
        profileUrl = value.toString();
        updateUserData(
          name: name,
          phone: phone,
          bio: bio,
          image: profileUrl == '' ? model!.image : value.toString(),
          cover: model!.cover,
        );
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

// upload cover image to fire storage ...
  String coverUrl = '';
  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      emit(UploadCoverImageSuccessState());
      value.ref.getDownloadURL().then((value) {
        coverUrl = value.toString();
        updateUserData(
          name: name,
          phone: phone,
          bio: bio,
          cover: coverUrl == '' ? model!.cover : value.toString(),
          image: model!.image,
        );
      }).catchError((error) {
        emit(UploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(UploadCoverImageErrorState());
    });
  }

  // void uploadUserImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null && coverImage != null) {
  //     uploadProfileImage();
  //     uploadCoverImage();
  //   } else {
  //     updateUser(name: name, phone: phone, bio: bio);
  //   }
  // }

// update user data ...
  void updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    UserModel user = UserModel(
      uId: model!.uId,
      name: name,
      email: model!.email,
      phone: phone,
      isEmailVerified: false,
      image: profileImage == null ? model!.image : profileUrl,
      cover: coverImage == null ? model!.cover : coverUrl,
      bio: bio,
    );
    emit(AppUpdateUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(user.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(AppUpdateUserErrorsState(error));
    });
  }

  // pick postImage ...
  File? postImage;
  Future<void> pickPostImage() async {
    XFile? pickedPostImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedPostImage != null) {
      postImage = File(pickedPostImage.path);
      emit(PostImagePickSuccessState());
    } else {
      emit(PostImagePickErrorState());
    }
  }

  // remove Post Image ...
  void removePostImage() {
    postImage = null;
    emit(RemovePostImageSuccessState());
  }

  void uploadPostImage({required String dateTime, required String text}) {
    emit(UploadPostImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      // emit(UploadPostImageSuccessState());
      value.ref.getDownloadURL().then((value) {
        createPost(dateTime: dateTime, text: text, postImage: value);
      }).catchError(() {
        emit(UploadPostImageErrorState());
      });
    }).catchError((error) {
      emit(UploadPostImageErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    required String postImage,
  }) {
    emit(CreatePostLoadingState());
    PostModel postModel = PostModel(
      uId: model!.uId,
      image: model!.image,
      name: model!.name,
      dateTime: dateTime,
      text: text,
      postImage: postImage,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      getPosts();
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];
  void getPosts() {
    posts = [];
    if (posts.isEmpty) {
      FirebaseFirestore.instance.collection('posts').get().then((value) {
        value.docs.forEach((element) {
          element.reference.collection('likes').get().then((value) {
            likes.add(value.docs.length);
            element.reference.collection('comments').get().then((value) {
              comments.add(value.docs.length);
              posts.add(PostModel.fromJson(element.data()));
              postsId.add(element.id);
            });
          }).catchError((error) {});

          emit(AppGetPostsSuccessState());
        });
      }).catchError((error) {
        emit(AppGetPostsErrorsState(error));
      });
    }
  }

// post likes ...
  void postLikes({required String postId}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set({'isLike': true}).then((value) {
      emit(LikePostSuccessState());
    }).catchError(() {
      emit(LikePostErrorState());
    });
  }

// post comments ...
  void postComments({required String postId, required String comment}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add({'comment': comment}).then((value) {
      emit(CommentPostSuccessState());
    }).catchError((error) {
      emit(CommentPostErrorState());
    });
  }

  List<UserModel> users = [];
  void getAllUsers() {
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != uId) {
            users.add(UserModel.fromJson(element.data()));
            emit(AppGetAllUserSuccessState());
          }
        });
      }).catchError((error) {
        emit(AppGetAllUserErrorsState(error));
      });
    }
  }

  void sendMessage({
    required String text,
    required String dateTime,
    required String receiverId,
  }) {
    MessageModel messageModel = MessageModel(
      text: text,
      receiverId: receiverId,
      senderId: model!.uId,
      dateTime: dateTime,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError(() {
      emit(SendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError(() {
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];
  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetAllMessagesSuccessState());
    });
  }
}
