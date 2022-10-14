// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/shared/components/componenets.dart';
import 'package:social/shared/cubit/app_cubit/states.dart';
import 'package:social/shared/styles/colors.dart';
import 'package:social/shared/styles/icon_broken.dart';
import '../shared/cubit/app_cubit/cubit.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();
  var now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is CreatePostSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: myAppBar(
            actions: [
              TextButton(
                onPressed: () {
                  if (AppCubit.get(context).postImage == null) {
                    AppCubit.get(context).createPost(
                        dateTime: now.toString(),
                        text: textController.text,
                        postImage: '');
                  } else {
                    AppCubit.get(context).uploadPostImage(
                        dateTime: now.toString(), text: textController.text);
                  }
                },
                child: Text(
                  'Post',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
            context: context,
            title: 'Create post',
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is CreatePostLoadingState ||
                    state is UploadPostImageLoadingState)
                  LinearProgressIndicator(),
                SizedBox(height: 5),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        '${AppCubit.get(context).model!.image}',
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Expanded(
                      child: Text(
                        '${AppCubit.get(context).model!.name}',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'What is on your mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (AppCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 220,
                        child: Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Container(
                            height: 200.0,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    FileImage(AppCubit.get(context).postImage!),
                              ),
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 18,
                        child: IconButton(
                          icon: Icon(IconBroken.Delete, size: 20.0),
                          onPressed: () {
                            AppCubit.get(context).removePostImage();
                          },
                        ),
                      )
                    ],
                  ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          AppCubit.get(context).pickPostImage();
                        },
                        child: Row(
                          children: [
                            Icon(IconBroken.Image),
                            SizedBox(width: 5.0),
                            Text('Add photos'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text('# tags'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
