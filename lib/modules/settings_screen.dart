// ignore_for_file: prefer_const_constructors

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:social/modules/edit_profile_screen.dart';
import 'package:social/shared/components/componenets.dart';
import 'package:social/shared/cubit/app_cubit/cubit.dart';
import 'package:social/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 190,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Container(
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
                        image: NetworkImage(
                          '${AppCubit.get(context).model!.cover}',
                        ),
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 64.0,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: CircleAvatar(
                    radius: 61.0,
                    backgroundImage: NetworkImage(
                      '${AppCubit.get(context).model!.image}',
                    ),
                  ),
                )
              ],
            ),
          ),
          Text(
            '${AppCubit.get(context).model!.name}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Expanded(
            flex: 0,
            child: Text(
              '${AppCubit.get(context).model!.bio}',
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: Colors.grey),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Text(
                        '265',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontSize: 16.0),
                      ),
                      Text(
                        'post',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Text(
                        '100',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontSize: 16.0),
                      ),
                      Text(
                        'photos',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Text(
                        '10k',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontSize: 16.0),
                      ),
                      Text(
                        'Followers',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Text(
                        '100',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontSize: 16.0),
                      ),
                      Text(
                        'Following',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text('Add photos'),
                ),
              ),
              SizedBox(width: 10.0),
              OutlinedButton(
                onPressed: () {
                  navigateTo(context: context, widget: EditProfileScreen());
                },
                child: Icon(IconBroken.Edit),
              ),
            ],
          ),
          Row(
            children: [
              OutlinedButton(
                  onPressed: () {
                    FirebaseMessaging.instance.subscribeToTopic('announcement');
                  },
                  child: Text('Subscribe')),
              OutlinedButton(
                  onPressed: () {
                    FirebaseMessaging.instance
                        .unsubscribeFromTopic('announcement');
                  },
                  child: Text('Unsubscribe')),
            ],
          )
        ],
      ),
    );
  }
}
