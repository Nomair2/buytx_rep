import 'package:animate_do/animate_do.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:buytx/core/common/widgets/custom_primary_button.dart';
import 'package:buytx/core/common/widgets/custom_second_button.dart';
import 'package:buytx/core/configs/assets/app_image.dart';
import 'package:buytx/core/error/show_error.dart';
import 'package:buytx/core/services/route/router.dart';
import 'package:buytx/src/auth/domain/usercase/validator/signup_validator.dart';
import 'package:buytx/src/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:buytx/src/auth/presentation/bloc/auth/auth_event.dart';
import 'package:buytx/src/auth/presentation/bloc/auth/auth_state.dart';
import 'package:buytx/src/auth/presentation/bloc/auth/password_cubit.dart';
import 'package:buytx/src/auth/presentation/widgets/auth_text_field.dart';

class NewPasswordPage extends StatefulWidget {
  NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  late TextEditingController password;

  late TextEditingController confirmPassword;

  GlobalKey<FormState> _keyNewPassword = GlobalKey<FormState>();

  @override
  void initState() {
    password = TextEditingController();
    confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
    password.clear();
    confirmPassword.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PasswordVisibilityCubit()),
        BlocProvider(create: (context) => ConfirmPasswordVisibilityCubit()),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 42.81),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.1),
                _buildTitle(context),
                SizedBox(height: size.height * 0.04),
                _buildImage(),
                SizedBox(height: size.height * 0.07),
                FadeInLeft(
                  duration: Duration(milliseconds: 500),
                  child: BlocBuilder<PasswordVisibilityCubit, bool>(
                    builder: (context, state) {
                      return AuthTextField(
                        controller: password,
                        validtor:
                            (value) => SignupValidator.validatePassword(value),
                        text: 'كلمة المرور',
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
                FadeInLeft(
                  duration: Duration(milliseconds: 800),
                  child: BlocBuilder<ConfirmPasswordVisibilityCubit, bool>(
                    builder: (context, state2) {
                      return AuthTextField(
                        validtor:
                            (value) => SignupValidator.validateConfirmPassword(
                              value,
                              password.text,
                            ),
                        controller: confirmPassword,
                        scure: state2,
                        text: 'تأكيد كلمة المرور',
                        preIcon: IconButton(
                          onPressed:
                              () =>
                                  context
                                      .read<ConfirmPasswordVisibilityCubit>()
                                      .toggleVisibility(),
                          icon: Icon(
                            state2
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
                FadeInRight(
                  duration: Duration(milliseconds: 1100),
                  child: BlocConsumer<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (AuthState is AuthInitial) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                        // return CustomPrimaryButton(
                        //   ontap: () {
                        //     if (_keyNewPassword.currentState!.validate()) {
                        //       context.go('/auth/signup');
                        //     }
                        //   },
                        //   color: Theme.of(context).primaryColor,
                        //   height: 45,
                        //   width: size.width,
                        //   text: '',
                        // );
                      }
                      return CustomPrimaryButton(
                        ontap: () {
                          if (_keyNewPassword.currentState!.validate()) {
                            context.go('/auth/signup');
                          }
                        },
                        color: Theme.of(context).primaryColor,
                        height: 45,
                        width: size.width,
                        text: 'التالي',
                      );
                    },
                    listener: (context, state) {
                      if (state is AuthError) {
                        showError(state.message);
                        context.read<AuthBloc>().add(AuthInitEvent());
                      } else if (state is AuthSuccess) {
                        context.goNamed('login');
                      }
                    },
                  ),
                ),
                // CustomPrimaryButton(
                //   ontap: () {
                //     if (key.currentState!.validate()) {
                //       context.go('/auth/signup');
                //     }
                //   },
                //   color: Theme.of(context).primaryColor,
                //   height: 45,
                //   width: size.width,
                //   text: 'التالي',
                // ),
                SizedBox(height: size.height * 0.02),
                SizedBox(height: size.height * 0.04),
                SizedBox(height: size.height * 0.02),
                // CustomPrimaryButton(
                //   color: Theme.of(context).colorScheme.primaryContainer,
                //   width: 226,
                //   height: 40,
                //   text: 'Google تسجيل باستخدام ',
                // ),
                SizedBox(height: size.height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildTitle(context) {
    return Text('كلمة سر جديدة', style: Theme.of(context).textTheme.titleLarge);
  }

  _buildImage() {
    return Image.asset(AppImage.newPasswordImage);
  }
}
