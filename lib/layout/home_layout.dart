// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/modules/new_post.dart';
import 'package:social/shared/cubit/app_cubit/cubit.dart';
import 'package:social/shared/cubit/app_cubit/states.dart';
import 'package:social/shared/styles/icon_broken.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppNewPostState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewPostScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppCubit.get(context).titels[AppCubit.get(context).currentIndex],
            ),
            actions: [
              IconButton(
                icon: Icon(IconBroken.Notification),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(IconBroken.Search),
                onPressed: () {},
              ),
            ],
          ),
          body:
              AppCubit.get(context).screens[AppCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: AppCubit.get(context).currentIndex,
            onTap: (index) {
              AppCubit.get(context).changeBottomNavBarState(index);
            },
            items: AppCubit.get(context).bottomNavBarItems,
          ),
        );
      },
    );
  }
}
