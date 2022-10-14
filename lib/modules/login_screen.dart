// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/home_layout.dart';
import 'package:social/modules/register_screen.dart';
import 'package:social/shared/components/componenets.dart';
import 'package:social/shared/cubit/login_cubit/login_cubit.dart';
import 'package:social/shared/cubit/login_cubit/login_states.dart';
import 'package:social/shared/network/local/cache_helper.dart';
import 'package:social/shared/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showToast(
                state: ToastStates.ERROR, message: state.error.toString());
          }
          if (state is LoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId);
            navigateAndFinish(context: context, widget: HomeLayout());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Container(
                          height: 6.0,
                          width: 75.0,
                          decoration: BoxDecoration(
                              color: kDefaultColor,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        SizedBox(height: 20.0),
                        defualtFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email must not be empty';
                            }
                            return null;
                          },
                          controller: emailController,
                          prefixIcon: Icons.email_outlined,
                          labelText: 'Email address',
                          textInputType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 20.0),
                        defualtFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password must not be empty';
                            }
                            return null;
                          },
                          obsucreText: LoginCubit.get(context).isPassword,
                          controller: passwordController,
                          prefixIcon: Icons.lock,
                          labelText: 'Enter Password',
                          suffixIcon: LoginCubit.get(context).isPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.visiblePassword,
                          onPressed: () {
                            LoginCubit.get(context).changePassword();
                          },
                        ),
                        SizedBox(height: 15.0),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => myButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).LoginUser(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'LOGIN',
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'You don\'t have an account ?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateAndFinish(
                                  context: context,
                                  widget: RegisterScreen(),
                                );
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
