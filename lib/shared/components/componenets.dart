// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../styles/colors.dart';
import '../styles/icon_broken.dart';

Widget defualtFormField({
  required TextEditingController controller,
  required IconData prefixIcon,
  IconData? suffixIcon,
  required String labelText,
  TextInputAction textInputAction = TextInputAction.next,
  TextInputType? textInputType,
  bool obsucreText = false,
  void Function()? onPressed,
  required String? Function(String?) validator,
}) =>
    TextFormField(
      validator: validator,
      obscureText: obsucreText,
      textInputAction: textInputAction,
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(width: 0.3),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.0, color: kDefaultColor),
          borderRadius: BorderRadius.circular(10.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: labelText,
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: Icon(
            suffixIcon,
          ),
        ),
      ),
    );
Widget myButton({
  required void Function()? onPressed,
  required String text,
  Color color = Colors.white,
  double width = double.infinity,
}) =>
    Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: kDefaultColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      height: 55.0,
      width: width,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 16.0,
          ),
        ),
      ),
    );
void navigateAndFinish({
  required context,
  required Widget widget,
}) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

enum ToastStates {
  WARNING,
  SUCCESS,
  ERROR,
}

void showToast({
  required ToastStates state,
  required String message,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    backgroundColor: toastColor(state),
    timeInSecForIosWeb: 3,
    fontSize: 14.0,
    gravity: ToastGravity.BOTTOM,
  );
}

Color toastColor(ToastStates state) {
  late Color color;
  switch (state) {
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    default:
      color = Colors.transparent;
  }
  return color;
}

PreferredSizeWidget myAppBar({
  required List<Widget> actions,
  required BuildContext context,
  required String title,
}) =>
    AppBar(
      title: Text(title),
      titleSpacing: 0.0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          IconBroken.Arrow___Left_2,
        ),
      ),
      actions: actions,
    );
void navigateTo({
  required context,
  required Widget widget,
}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
