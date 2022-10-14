// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/shared/components/componenets.dart';
import 'package:social/shared/cubit/app_cubit/states.dart';
import 'package:social/shared/styles/icon_broken.dart';

import '../shared/cubit/app_cubit/cubit.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        nameController.text = AppCubit.get(context).model!.name!;
        bioController.text = AppCubit.get(context).model!.bio!;
        phoneController.text = AppCubit.get(context).model!.phone!;
        return Scaffold(
          appBar: myAppBar(
            title: 'Edit Profile',
            context: context,
            actions: [
              TextButton(
                onPressed: () {
                  AppCubit.get(context).updateUserData(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  );
                },
                child: Text('UPDATE'),
              ),
              SizedBox(width: 10.0),
            ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is AppUpdateUserLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(height: 5.0),
                  Container(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                height: 150.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10.0),
                                    topLeft: Radius.circular(10.0),
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AppCubit.get(context).coverImage == null
                                            ? NetworkImage(
                                                '${AppCubit.get(context).model!.cover}',
                                              )
                                            : FileImage(AppCubit.get(context)
                                                    .coverImage!)
                                                as ImageProvider<Object>,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 18.0,
                                  ),
                                ),
                                onPressed: () {
                                  AppCubit.get(context).getCoverImage();
                                },
                              )
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 61.0,
                                backgroundImage:
                                    AppCubit.get(context).profileImage == null
                                        ? NetworkImage(
                                            '${AppCubit.get(context).model!.cover}',
                                          )
                                        : FileImage(
                                            AppCubit.get(context).profileImage!,
                                          ) as ImageProvider<Object>,
                              ),
                            ),
                            IconButton(
                              icon: CircleAvatar(
                                radius: 20.0,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 18.0,
                                ),
                              ),
                              onPressed: () {
                                AppCubit.get(context).getProfileImage();
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (AppCubit.get(context).coverImage != null ||
                      AppCubit.get(context).profileImage != null)
                    SizedBox(height: 20.0),
                  if (AppCubit.get(context).coverImage != null ||
                      AppCubit.get(context).profileImage != null)
                    Row(
                      children: [
                        if (AppCubit.get(context).coverImage != null)
                          Expanded(
                            child: myButton(
                                onPressed: () {
                                  AppCubit.get(context).uploadCoverImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text,
                                  );
                                },
                                text: 'UPLOAD COVER'),
                          ),
                        SizedBox(width: 10.0),
                        if (AppCubit.get(context).profileImage != null)
                          Expanded(
                            child: myButton(
                                onPressed: () {
                                  AppCubit.get(context).uploadProfileImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text,
                                  );
                                },
                                text: 'UPLOAD IMAGE'),
                          ),
                      ],
                    ),
                  SizedBox(height: 20.0),
                  defualtFormField(
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                    controller: nameController,
                    prefixIcon: IconBroken.User,
                    labelText: 'Name',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name must not be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  defualtFormField(
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    controller: bioController,
                    prefixIcon: IconBroken.Info_Circle,
                    labelText: 'Bio',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Bio must not be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  defualtFormField(
                    textInputType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    controller: phoneController,
                    prefixIcon: IconBroken.Call,
                    labelText: 'Phone',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone must not be empty';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
