// ignore_for_file: prefer_const_constructors, must_be_immutable, avoid_print
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/home_layout.dart';
import 'package:social/modules/battery_level_screen.dart';
import 'package:social/modules/login_screen.dart';
import 'package:social/shared/components/componenets.dart';
import 'package:social/shared/components/constants.dart';
import 'package:social/shared/cubit/app_cubit/cubit.dart';
import 'package:social/shared/cubit/bloc_observer.dart';
import 'package:social/shared/network/local/cache_helper.dart';
import 'package:social/shared/styles/themes.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data);
  showToast(state: ToastStates.SUCCESS, message: 'onMessage OpenedApp');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print(token);
  // foreground fcm
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data);
    showToast(state: ToastStates.SUCCESS, message: 'onMessage');
  });
  // onTapped fcm
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data);
    showToast(state: ToastStates.SUCCESS, message: 'onMessage OpenedApp');
  });
  // background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await Firebase.initializeApp();
  uId = CacheHelper.getString(key: 'uId');
  late Widget startWidget;

  if (uId != '') {
    startWidget = HomeLayout();
  } else {
    startWidget = LoginScreen();
  }
  runApp(MyApp(startWidget: startWidget));
}

class MyApp extends StatelessWidget {
  Widget startWidget;
  MyApp({super.key, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()
            ..getUserData()
            ..getPosts()
            ..getAllUsers(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BatteryLevelScreen(),
        theme: ligtTheme,
      ),
    );
  }
}
