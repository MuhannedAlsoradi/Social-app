// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/models/create_user_model.dart';
import 'package:social/modules/chat_details_screen.dart';
import 'package:social/shared/components/componenets.dart';
import 'package:social/shared/cubit/app_cubit/cubit.dart';
import 'package:social/shared/cubit/app_cubit/states.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildChatItem(context, AppCubit.get(context).users[index]),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Container(
                height: .6,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ),
            itemCount: AppCubit.get(context).users.length,
          );
        });
  }

  Widget buildChatItem(context, UserModel model) => InkWell(
        onTap: () {
          navigateTo(
              context: context, widget: ChatDetailsScreen(userModel: model));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 21.0,
                backgroundImage: NetworkImage(
                  '${model.image}',
                ),
              ),
              SizedBox(width: 5.0),
              Text(
                '${model.name}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 16.0),
              ),
            ],
          ),
        ),
      );
}
