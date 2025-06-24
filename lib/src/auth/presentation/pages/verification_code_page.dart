import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:buytx/core/common/widgets/custom_primary_button.dart';
import 'package:buytx/core/configs/assets/app_image.dart';
import 'package:buytx/core/error/show_error.dart';
import 'package:buytx/core/services/route/router.dart';
import 'package:buytx/src/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:buytx/src/auth/presentation/bloc/auth/auth_event.dart';
import 'package:buytx/src/auth/presentation/bloc/auth/auth_state.dart';
import 'package:buytx/src/auth/presentation/bloc/otp/timer.dart';
import 'package:buytx/src/home/widgets/customCircularButton.dart';
import 'package:pinput/pinput.dart';

class VerificationCodePage extends StatelessWidget {
  VerificationCodePage({super.key, required this.parameter});
  // final String email;
  // final bool isForgetPassword;
  final VerifyOtpParameter parameter;
  // String? otp;

  TextEditingController otp = TextEditingController();
  GlobalKey<FormState> _keyOtp = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider<TimerCubit>(
      create: (context) => TimerCubit()..startTimer(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 42.81),
            child: Form(
              key: _keyOtp,
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.1),
                  _buildTitle(context),
                  SizedBox(height: size.height * 0.01),
                  _text(context),
                  SizedBox(height: size.height * 0.015),
                  _text2(context),
                  SizedBox(height: size.height * 0.04),
                  otpp(context),
                  SizedBox(height: size.height * 0.015),
                  BlocBuilder<TimerCubit, int>(
                    builder: (context, state) {
                      final minutes = (state ~/ 60).toString().padLeft(2, '0');
                      final seconds = (state % 60).toString().padLeft(2, '0');
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "$minutes:$seconds  أعد الإرسال بعد",
                            textAlign: TextAlign.end,
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall!.copyWith(fontSize: 13),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: size.height * 0.05),
                  FadeInRight(
                    duration: Duration(milliseconds: 800),
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
                          //   width: size.width * 0.8,
                          //   text: '',
                          // );
                        }
                        return CustomPrimaryButton(
                          ontap: () {
                            print(parameter.email);
                            print(otp == null);
                            print(parameter.email == null);
                            print(otp);
                            print("1");
                            if (_keyOtp.currentState!.validate()) {
                              print("2");
                              context.read<AuthBloc>().add(
                                AuthVerifyOtpEvent(
                                  otp: otp.text,
                                  email: parameter.email,
                                ),
                              );
                            }
                            print("3");
                            // context.go('/auth/new-password');
                          },
                          color: Theme.of(context).primaryColor,
                          height: 45,
                          width: size.width * 0.8,
                          text: 'تحقق',
                        );
                      },
                      listener: (context, state) {
                        if (state is AuthError) {
                          context.read<AuthBloc>().add(AuthInitEvent());
                          showError(state.message);
                        } else if (state is AuthSuccess) {
                          parameter.isForgetPassword
                              ? context.goNamed('new-password')
                              : context.goNamed('login');
                        }
                      },
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  haveCode(context),
                  SizedBox(height: size.height * 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget otpp(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 49,
      height: 49,
      textStyle: TextStyle(
        fontSize: 20,
        color: Theme.of(context).colorScheme.onSecondary,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.inversePrimary),
        borderRadius: BorderRadius.circular(6.53),
      ),
    );
    final submittedPinTheme = PinTheme(
      width: 49,
      height: 49,
      textStyle: TextStyle(
        fontSize: 20,
        color: Theme.of(context).colorScheme.onSecondary,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(6.53),
      ),
    );
    final errorPinTheme = PinTheme(
      width: 49,
      height: 49,
      textStyle: TextStyle(
        fontSize: 20,
        color: Theme.of(context).colorScheme.onSecondary,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(6.53),
      ),
    );
    return FadeInLeft(
      duration: Duration(milliseconds: 500),
      child: Pinput(
        length: 5,
        defaultPinTheme: defaultPinTheme,
        // autovalidateMode: AutovalidateMode.disabled,
        errorPinTheme: errorPinTheme,
        // focusedPinTheme: focusedPinTheme,
        submittedPinTheme: submittedPinTheme,
        // keyboardAppearance: Brightness.dark,
        controller: otp,
        // key: _keyOtp,
        closeKeyboardWhenCompleted: true,
        disabledPinTheme: errorPinTheme,
        validator: (s) {
          print(s!.length);
          if (s!.length == 5) {
            return null;
          } else {
            return '';
          }
          // return s == '22222' ? null : 'Pin is incorrect';
        },
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        showCursor: true,
        onCompleted: (pin) => print(pin),
      ),
    );
  }

  _buildTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomSmallButton(
          icons: Icons.arrow_back_ios_new,
          onPressed: () {
            context.pop();
          },
          colors: Colors.white,
          radius: 12,
          colorIcon: Colors.black,
          size: 20,
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.2),
        Text('التحقق', style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }

  _buildImage() {
    return Image.asset(AppImage.forgetPasswordImage);
  }

  Widget _text(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "التحقق من كلمة المرور",
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 24),
        ),
      ],
    );
  }

  Widget _text2(context) {
    return Text(
      'أدخل رمز التحقق الذي أرسلناه إلى بريدك الإلكتروني',
      textAlign: TextAlign.right,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }

  Widget haveCode(BuildContext context) {
    return BlocBuilder<TimerCubit, int>(
      builder: (context, state) {
        final isWaiting = state > 0;
        return Text.rich(
          TextSpan(
            text: 'لم تستلم الرمز؟ ',
            children: [
              TextSpan(
                text: ' أعد الإرسال ',
                recognizer:
                    TapGestureRecognizer()
                      ..onTap =
                          isWaiting
                              ? null
                              : () async {
                                // Trigger resend OTP logic here
                                print("OTP resent");
                                String? response = await context
                                    .read<TimerCubit>()
                                    .resetTimer(parameter.email);
                                if (response != null) {
                                  showError(response);
                                }
                              },
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 13),
        );
      },
    );
  }
}
