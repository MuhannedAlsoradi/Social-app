import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/models/create_user_model.dart';
import 'package:social/shared/cubit/register_cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;

  void registerUser({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.uid);
      print(value.user!.email);
      createUser(email: email, uId: value.user!.uid, name: name, phone: phone);
    }).catchError((error) {
      print(error);
      emit(RegisterErrorState(error));
    });
  }

  void createUser({
    required String email,
    required String uId,
    required String name,
    required String phone,
  }) {
    UserModel userModel = UserModel(
      uId: uId,
      name: name,
      email: email,
      phone: phone,
      isEmailVerified: false,
      image:
          'https://img.freepik.com/free-photo/close-up-portrait-young-beautiful-woman-isolated_273609-34722.jpg?w=996&t=st=1664515490~exp=1664516090~hmac=32dd462c476892a65e5d79ed384b548fe84008f2210da5c0c2ec1aaa640ca804',
      cover:
          'https://img.freepik.com/free-photo/close-up-portrait-young-beautiful-woman-isolated_273609-34722.jpg?w=996&t=st=1664515490~exp=1664516090~hmac=32dd462c476892a65e5d79ed384b548fe84008f2210da5c0c2ec1aaa640ca804',
      bio: 'Write a bio ...',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(CreateUserSuccessState(userModel.uId.toString()));
    }).catchError((error) {
      print(error.toString());
      emit(CreateUserErrorState(error));
    });
  }

  void changePassword() {
    isPassword = !isPassword;
    emit(RegisterChangePasswordState());
  }
}
