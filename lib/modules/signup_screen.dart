import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:social_app/bloc/cubitAuthentication/authentication_cubit.dart';
import 'package:social_app/modules/layout/layout_screen.dart';
import 'package:social_app/network/remote/cache_helper.dart';
import 'package:social_app/shared/component/constants.dart';
import 'package:social_app/shared/component/shared_component.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    const IconData mail_outline = IconData(0xe3c4);
    var confirmPasswordController = TextEditingController();
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        var cubit = context.read<AuthenticationCubit>();
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 350,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      BuildBackground(text: 'background.png'),
                      Positioned(
                          bottom: 60,
                          child: BuildLogo(
                              text: 'logo.png', width: 176, height: 65)),
                    ],
                  ),
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      children: [
                        BuildTextFormField(
                            prefixIcon: IconlyBroken.profile,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'name must be found';
                              }
                              return null;
                            },
                            hintText: 'Name',
                            controller: nameController),
                        SizedBox(
                          height: 15,
                        ),
                        BuildTextFormField(
                            prefixIcon: Icons.email_outlined,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Email must be found';}
                              return null;
                            },
                            hintText: 'Email Address',
                            controller: emailController),
                        SizedBox(
                          height: 15,
                        ),
                        BuildTextFormField(
                            prefixIcon:  IconlyBroken.lock,
                            password: cubit.password,
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
                          height: 15,
                        ),
                        BuildTextFormField(
                            prefixIcon: IconlyBroken.call,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Phone must be found';
                              }
                              return null;
                            },
                            hintText: 'Phone',
                            controller: phoneController),
                        SizedBox(
                          height: 40,
                        ),
                        state is! LoadingSignupState
                            ? BuildButtom(
                                elevation: 10,
                                textcolor: Colors.white,
                                text: 'SignUp',
                                onpress: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.UserSignUp(
                                        phone: phoneController.text,
                                        name: nameController.text,
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
                          height: 40,
                        ),
                        BuildLineRow(),
                        SizedBox(
                          height: 25,
                        ),
                        BuildButtom(
                            elevation: 0,
                            textcolor: Colors.black,
                            background: Colors.white,
                            text: 'Log in',
                            onpress: () {
                              Navigator.pop(context);
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
        if (state is SuccessCreateState) {
          CacheHelper.SaveData(key: 'uId', value: state.uId);
          PushAndFinish(widget: LayoutScreen(), context: context);
        }
        if (state is FailedSignupState) {
          ShowToast(message: state.error, state: ToastState.ERROR);
        }
      },
    );
  }
}
