// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, unrelated_type_equality_checks, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/models/create_user_model.dart';
import 'package:social/models/message_model.dart';
import 'package:social/shared/cubit/app_cubit/cubit.dart';
import 'package:social/shared/cubit/app_cubit/states.dart';
import 'package:social/shared/styles/colors.dart';
import 'package:social/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel? userModel;
  var now = DateTime.now();
  var messageController = TextEditingController();
  ChatDetailsScreen({this.userModel});
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context)
            .getMessages(receiverId: userModel!.uId.toString());
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
            if (state is SendMessageSuccessState) {
              messageController.text = '';
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(IconBroken.Arrow___Left_2),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        '${userModel!.image}',
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      '${userModel!.name}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          MessageModel message =
                              AppCubit.get(context).messages[index];
                          if (AppCubit.get(context).model!.uId ==
                              AppCubit.get(context).messages[index].senderId) {
                            return buildMyMessage(message);
                          } else {
                            return buildMessageItem(message);
                          }
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10.0),
                        itemCount: AppCubit.get(context).messages.length,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 0.0),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.grey[200],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Write your message here ...',
                              ),
                            ),
                          ),
                          IconButton(
                            alignment: AlignmentDirectional.centerEnd,
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              AppCubit.get(context).sendMessage(
                                text: messageController.text,
                                dateTime: now.toString(),
                                receiverId: userModel!.uId.toString(),
                              );
                            },
                            icon: Icon(
                              IconBroken.Send,
                              size: 22.0,
                              color: kDefaultColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessageItem(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(15.0),
              topEnd: Radius.circular(15.0),
              bottomEnd: Radius.circular(15.0),
            ),
          ),
          child: Text('${model.text}'),
        ),
      );
  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade100,
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(15.0),
              topEnd: Radius.circular(15.0),
              bottomStart: Radius.circular(15.0),
            ),
          ),
          child: Text('${model.text}'),
        ),
      );
}
