import 'package:animate_do/animate_do.dart';
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
import 'package:buytx/src/auth/presentation/widgets/auth_text_field.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  late TextEditingController email;

  GlobalKey<FormState> _keyPassword = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = TextEditingController();
  }

  @override
  void dispose() {
    email.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42.81),
          child: Form(
            key: _keyPassword,
            child: Column(
              children: [
                SizedBox(height: size.height * 0.1),
                _buildTitle(context),
                SizedBox(height: size.height * 0.01),
                _buildImage(),
                // SizedBox(height: size.height * 0.04),
                // _emailField(size, context),
                SizedBox(height: size.height * 0.015),
                _interEmail(context, 'أدخل البريد الإلكتروني'),
                SizedBox(height: size.height * 0.04),
                FadeInLeft(
                  duration: Duration(milliseconds: 500),
                  child: AuthTextField(
                    controller: email,
                    text: 'البريد الإلكتروني',
                    validtor: (value) => SignupValidator.validateEmail(value),
                    sufIcon: Icon(
                      Icons.email,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.025),
                _text(context, 'العودة إلى تسجيل الدخول'),
                SizedBox(height: size.height * 0.05),
                FadeInRight(
                  duration: Duration(milliseconds: 800),
                  child: BlocConsumer<AuthBloc, AuthState>(
                    buildWhen: (prev, curr) => prev != curr,
                    builder: (context, state) {
                      print(state.runtimeType);
                      print("we started ");
                      print("1 ${state.runtimeType}");
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
                          if (_keyPassword.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              AuthVerifyAccountEvent(email.text),
                            );
                          }
                        },
                        color: Theme.of(context).primaryColor,
                        height: 45,
                        width: size.width,
                        text: 'التالي',
                      );
                    },
                    listener: (context, state) {
                      if (state is AuthInitial) {
                      } else if (state is AuthError) {
                        context.read<AuthBloc>().add(AuthInitEvent());
                        Future.delayed(Duration(seconds: 2));
                        showError(state.message);
                        print(state.runtimeType);
                      } else if (state is AuthSuccess) {
                        context.pushNamed(
                          'verify-otp',
                          extra: VerifyOtpParameter(email.text, true),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                _haveAccount(context),
                SizedBox(height: size.height * 0.04),
                SizedBox(height: size.height * 0.02),
                SizedBox(height: size.height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildTitle(context) {
    return Text(
      'نسيت كلمة المرور',
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  _buildImage() {
    return Image.asset(AppImage.forgetPasswordImage);
  }

  Widget _interEmail(context, text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _text(context, text) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).go('/auth/login'),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _haveAccount(context) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).go('/auth/signup'),
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
}
