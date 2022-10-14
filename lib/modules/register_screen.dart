// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/home_layout.dart';
import 'package:social/modules/login_screen.dart';
import 'package:social/shared/components/componenets.dart';
import 'package:social/shared/cubit/login_cubit/login_states.dart';
import 'package:social/shared/cubit/register_cubit/register_cubit.dart';
import 'package:social/shared/cubit/register_cubit/register_states.dart';
import 'package:social/shared/network/local/cache_helper.dart';
import '../shared/styles/colors.dart';

class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            navigateAndFinish(context: context, widget: HomeLayout());
            CacheHelper.saveData(key: 'uId', value: state.uId);
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
                          'REGISTER',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Container(
                          height: 6.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                              color: kDefaultColor,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        SizedBox(height: 20.0),
                        defualtFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'User Name must not be empty';
                            }
                            return null;
                          },
                          controller: nameController,
                          prefixIcon: Icons.person,
                          labelText: 'User name',
                          textInputType: TextInputType.name,
                        ),
                        SizedBox(height: 15.0),
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
                        SizedBox(height: 15.0),
                        defualtFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password must not be empty';
                            }
                            return null;
                          },
                          obsucreText: RegisterCubit.get(context).isPassword,
                          controller: passwordController,
                          prefixIcon: Icons.lock,
                          labelText: 'Password',
                          suffixIcon: RegisterCubit.get(context).isPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          textInputType: TextInputType.visiblePassword,
                          onPressed: () {
                            RegisterCubit.get(context).changePassword();
                          },
                        ),
                        SizedBox(height: 15.0),
                        defualtFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone must not be empty';
                            }
                            return null;
                          },
                          controller: phoneController,
                          prefixIcon: Icons.phone,
                          labelText: 'Phone',
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.phone,
                        ),
                        SizedBox(height: 15.0),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => myButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).registerUser(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'REGISTER',
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Do you have an account ?',
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
                                    context: context, widget: LoginScreen());
                              },
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
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
