// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/models/post_model.dart';
import 'package:social/shared/components/componenets.dart';
import 'package:social/shared/cubit/app_cubit/cubit.dart';
import 'package:social/shared/cubit/app_cubit/states.dart';
import 'package:social/shared/styles/icon_broken.dart';

var scaffoldKey = GlobalKey<ScaffoldState>();
var commentController = TextEditingController();

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Card(
                elevation: 5.0,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.all(10.0),
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Image(
                      width: double.infinity,
                      height: 250.0,
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://img.freepik.com/free-photo/close-up-portrait-young-beautiful-woman-isolated_273609-34722.jpg?w=996&t=st=1664515490~exp=1664516090~hmac=32dd462c476892a65e5d79ed384b548fe84008f2210da5c0c2ec1aaa640ca804'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Communicate with friends',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ConditionalBuilder(
                condition: AppCubit.get(context).posts.isNotEmpty &&
                    AppCubit.get(context).model != null,
                builder: (context) => ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => buildPostItem(
                      AppCubit.get(context).posts[index], context, index),
                  separatorBuilder: (context, index) => SizedBox(height: 10.0),
                  itemCount: AppCubit.get(context).posts.length,
                ),
                fallback: (context) => Center(
                  child: Text(
                    'No posts yet! follow friends to see \nnew posts',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 18.0),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget buildPostItem(PostModel model, context, index) => Card(
      margin: EdgeInsets.all(10.0),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    '${model.image}',
                  ),
                ),
                SizedBox(width: 5.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('${model.name}'),
                          SizedBox(width: 3.0),
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 16.0,
                          )
                        ],
                      ),
                      Text(
                        '${model.dateTime}',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              height: 1.3,
                              color: Colors.grey,
                              fontSize: 13.0,
                            ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(IconBroken.More_Circle),
                  onPressed: () {},
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                height: .6,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ),
            Text(
              '${model.text}',
              style: Theme.of(context).textTheme.caption,
            ),
            // Wrap(
            //   children: [
            //     Container(
            //       padding: EdgeInsetsDirectional.only(end: 5.0),
            //       height: 30.0,
            //       child: MaterialButton(
            //         minWidth: 30.0,
            //         padding: EdgeInsets.zero,
            //         onPressed: () {},
            //         child: Text(
            //           '#software',
            //           style: Theme.of(context).textTheme.caption!.copyWith(
            //                 color: Colors.blue,
            //               ),
            //         ),
            //       ),
            //     ),
            //     Container(
            //       padding: EdgeInsetsDirectional.only(end: 5.0),
            //       height: 30.0,
            //       child: MaterialButton(
            //         minWidth: 30.0,
            //         padding: EdgeInsets.zero,
            //         onPressed: () {},
            //         child: Text(
            //           '#engineering',
            //           style: Theme.of(context).textTheme.caption!.copyWith(
            //                 color: Colors.blue,
            //               ),
            //         ),
            //       ),
            //     ),
            //     Container(
            //       padding: EdgeInsetsDirectional.only(end: 5.0),
            //       height: 30.0,
            //       child: MaterialButton(
            //         minWidth: 30.0,
            //         padding: EdgeInsets.zero,
            //         onPressed: () {},
            //         child: Text(
            //           '#programming',
            //           style: Theme.of(context).textTheme.caption!.copyWith(
            //                 color: Colors.blue,
            //               ),
            //         ),
            //       ),
            //     ),
            //     Container(
            //       padding: EdgeInsetsDirectional.only(end: 5.0),
            //       height: 30.0,
            //       child: MaterialButton(
            //         minWidth: 30.0,
            //         padding: EdgeInsets.zero,
            //         onPressed: () {},
            //         child: Text(
            //           '#software_development',
            //           style: Theme.of(context).textTheme.caption!.copyWith(
            //                 color: Colors.blue,
            //               ),
            //         ),
            //       ),
            //     ),
            //     Container(
            //       padding: EdgeInsetsDirectional.only(end: 5.0),
            //       height: 30.0,
            //       child: MaterialButton(
            //         minWidth: 30.0,
            //         padding: EdgeInsets.zero,
            //         onPressed: () {},
            //         child: Text(
            //           '#coding',
            //           style: Theme.of(context).textTheme.caption!.copyWith(
            //                 color: Colors.blue,
            //               ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Column(
                children: [
                  if (model.postImage != '')
                    Container(
                      height: 200.0,
                      width: double.infinity,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage('${model.postImage}'),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        top: 10.0, bottom: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              height: 20.0,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Icon(
                                    IconBroken.Heart,
                                    color: Colors.red,
                                    size: 20.0,
                                  ),
                                  SizedBox(width: 5.0),
                                  Text(
                                    '${AppCubit.get(context).likes[index]}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                          fontSize: 14.0,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w100,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              height: 20.0,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    IconBroken.Chat,
                                    color: Colors.amber,
                                    size: 20.0,
                                  ),
                                  SizedBox(width: 5.0),
                                  Text(
                                    '${AppCubit.get(context).comments[index]} comments',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                          fontSize: 14.0,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w100,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            showBottomSheet(
                              backgroundColor: Colors.transparent,
                              elevation: 100,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              context: context,
                              builder: (context) => Container(
                                height: 223,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadiusDirectional.only(
                                    topEnd: Radius.circular(20),
                                    topStart: Radius.circular(30),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Write a comment ...',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                      SizedBox(height: 5.0),
                                      defualtFormField(
                                        controller: commentController,
                                        prefixIcon: IconBroken.Send,
                                        labelText: '',
                                        validator: (value) {},
                                      ),
                                      SizedBox(height: 20.0),
                                      myButton(
                                        onPressed: () {
                                          AppCubit.get(context).postComments(
                                              postId: AppCubit.get(context)
                                                  .postsId[index],
                                              comment: commentController.text);
                                        },
                                        text: 'Publish',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  '${AppCubit.get(context).model!.image}',
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                'Write a comment ...',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          AppCubit.get(context).postLikes(
                              postId: AppCubit.get(context).postsId[index]);
                        },
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              color: Colors.red,
                              size: 20.0,
                            ),
                            SizedBox(width: 3.0),
                            Text(
                              'Like',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.0),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Send,
                              color: Colors.green,
                              size: 20.0,
                            ),
                            SizedBox(width: 3.0),
                            Text(
                              'Share',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
