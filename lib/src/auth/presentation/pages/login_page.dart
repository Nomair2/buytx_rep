import 'package:animate_do/animate_do.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:buytx/core/services/route/router.dart';
import 'package:buytx/src/auth/domain/usercase/validator/signup_validator.dart';
import 'package:buytx/src/auth/presentation/bloc/auth/password_cubit.dart';
import 'package:buytx/core/common/widgets/custom_primary_button.dart';
import 'package:buytx/core/common/widgets/custom_second_button.dart';
import 'package:buytx/core/configs/assets/app_image.dart';
import 'package:buytx/core/configs/theme/app_text.dart';
import 'package:buytx/core/configs/theme/app_theme.dart';
import 'package:buytx/core/error/show_error.dart';
import 'package:buytx/src/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:buytx/src/auth/presentation/bloc/auth/auth_event.dart';
import 'package:buytx/src/auth/presentation/bloc/auth/auth_state.dart';
import 'package:buytx/src/auth/presentation/widgets/auth_text_field.dart';
import 'package:buytx/src/home/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  static String path = '/login';

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _keyLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => PasswordVisibilityCubit(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 42.81),
            child: Form(
              key: _keyLogin,
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.1),
                  _buildTitle(context),
                  SizedBox(height: size.height * 0.01),
                  _buildImage(),
                  SizedBox(height: size.height * 0.04),
                  FadeInLeft(
                    duration: Duration(milliseconds: 500),
                    child: AuthTextField(
                      controller: email,
                      validtor: (value) => SignupValidator.validateEmail(value),
                      hintStyle: TextStyle(
                        color: Color(0xff919296),
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                      text: ' البريد الإلكتروني أو اسم المستخدم أو رقم الهاتف',
                      sufIcon: Icon(
                        Icons.email,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.015),
                  FadeInLeft(
                    duration: Duration(milliseconds: 800),
                    child: BlocBuilder<PasswordVisibilityCubit, bool>(
                      builder: (context, state) {
                        return AuthTextField(
                          controller: password,
                          text: 'كلمة المرور',
                          validtor:
                              (value) =>
                                  SignupValidator.validatePassword(value),
                          scure: state,
                          preIcon: IconButton(
                            onPressed:
                                () =>
                                    context
                                        .read<PasswordVisibilityCubit>()
                                        .toggleVisibility(),
                            icon: Icon(
                              state
                                  ? CupertinoIcons.eye_slash_fill
                                  : CupertinoIcons.eye_fill,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          sufIcon: Icon(
                            FluentIcons.key_16_filled,
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: size.height * 0.025),
                  _forgetText(context),
                  SizedBox(height: size.height * 0.05),
                  FadeInRight(
                    duration: Duration(milliseconds: 1200),
                    child: BlocConsumer<AuthBloc, AuthState>(
                      builder: (context, state) {
                        print("we started ");
                        if (state is AuthLoading) {
                          print("we loading ");
                          return Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          );
                          // return CustomPrimaryButton(
                          //   ontap: () {},
                          //   color: Theme.of(context).primaryColor,
                          //   height: 45,
                          //   width: size.width,
                          //   text: '',
                          // );
                        }
                        return CustomPrimaryButton(
                          ontap: () {
                            if (_keyLogin.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                AuthLoginEvent(
                                  password: password.text,
                                  username: email.text,
                                ),
                              );
                            }
                          },
                          color: Theme.of(context).primaryColor,
                          height: 45,
                          width: size.width,
                          text: 'تسجيل الدخول',
                        );
                      },
                      listener: (context, state) {
                        if (state is AuthError) {
                          if (state.message.toLowerCase().contains(
                            'غير مفعل'.toLowerCase(),
                          )) {
                            showSnak(
                              context,
                              'الحساب غير مفعل ,',
                              'هل تريد تفعيله ؟',
                              () {
                                context.read<AuthBloc>().add(
                                  AuthReVerifyAccountEvent(email.text),
                                );
                                ScaffoldMessenger.of(
                                  context,
                                ).hideCurrentSnackBar();
                                context.pushNamed(
                                  "verify-otp",
                                  extra: VerifyOtpParameter(email.text, false),
                                );
                              },
                            );
                          } else {
                            showError(state.message);
                            context.read<AuthBloc>().add(AuthInitEvent());
                          }
                        }
                        if (state is AuthSuccess) {
                          context.goNamed(HomePage.name);
                        }
                      },
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  _haveAccount(context),
                  SizedBox(height: size.height * 0.04),
                  _googleLogin(context),
                  SizedBox(height: size.height * 0.02),
                  CustomSecondButton(
                    ontap: () {},
                    color: Theme.of(context).colorScheme.primaryContainer,
                    width: 226,
                    height: 40,
                    text: 'Google تسجيل باستخدام ',
                  ),
                  SizedBox(height: size.height * 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildTitle(context) {
    return Text(
      'سجل دخولك الأن',
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  _buildImage() {
    return Image.asset(AppImage.loginImage);
  }

  Widget _forgetText(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Text.rich(
        //     TextSpan(
        //       text: 'هل نسيت كلمة المرور ؟',
        //       recognizer: GestureRecognizerFactory..,
        //       style: TextStyle(
        //         color: Theme.of(context).primaryColor,
        //         fontSize: 14,
        //         fontWeight: FontWeight.w600)
        //     ),
        //     textAlign:TextAlign.left ,
        // ),
        GestureDetector(
          onTap: () => GoRouter.of(context).push('/auth/forgot-password'),
          child: Text(
            'هل نسيت كلمة المرور ؟',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _haveAccount(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/auth/signup'),
      child: Text(
        'ليس لديك حساب؟',
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _googleLogin(context) {
    return Text(
      'تسجيل الدخول باستخدام',
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
