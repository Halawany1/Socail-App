import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:social_app/bloc/cubitAuthentication/authentication_cubit.dart';
import 'package:social_app/bloc/cubitLayout/layout_cubit.dart';
import 'package:social_app/modules/layout/layout_screen.dart';
import 'package:social_app/modules/signup_screen.dart';
import 'package:social_app/shared/component/constants.dart';
import 'package:social_app/shared/component/shared_component.dart';

import '../network/remote/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        var cubit = context.read<AuthenticationCubit>();
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    BuildBackground(text: 'background.png'),
                    Positioned(
                        bottom: 60,
                        child: BuildLogo(
                            text: 'logo.png', width: 176, height: 65)),
                  ],
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      children: [
                        BuildTextFormField(
                          prefixIcon: Icons.email_outlined,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Email must be found';
                              }
                              return null;
                            },
                            hintText: 'Email Address',
                            controller: emailController),
                        SizedBox(
                          height: 15,
                        ),
                        BuildTextFormField(
                            password: cubit.password,
                            prefixIcon:IconlyBroken.lock,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Password must be found';
                              }
                              return null;
                            },
                            ontap: () {
                              cubit.ChangeVisiablePassword();
                            },
                            pass: true,
                            hintText: 'Password',
                            controller: passwordController),
                        SizedBox(
                          height: 50,
                        ),
                        state is! LoadingLoginState
                            ? BuildButtom(
                                elevation: 10,
                                textcolor: Colors.white,
                                text: 'Log in',
                                onpress: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.UserLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                width: 300,
                                height: 40)
                            : CircularProgressIndicator(
                                color: color,
                              ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Forgot Password?',
                          style: GoogleFonts.dmSans(
                              fontSize: 14,
                              color: color,
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        BuildLineRow(),
                        SizedBox(
                          height: 40,
                        ),
                        BuildButtom(
                            elevation: 0,
                            textcolor: Colors.black,
                            background: Colors.white,
                            text: 'Create new account',
                            onpress: () {
                              Push(widget: SignUpScreen(), context: context);
                            },
                            width: 200,
                            height: 33),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if(state is SuccessLoginState){
          CacheHelper.SaveData(key: 'uId', value: state.uId);
          PushAndFinish(widget: LayoutScreen(), context: context);
        }
        if (state is FailedLoginState) {
          ShowToast(message: state.error, state: ToastState.ERROR);
        }
      },
    );
  }
}
