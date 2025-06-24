import 'package:animate_do/animate_do.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buytx/core/utils/rive_utils.dart';
import 'package:buytx/src/auth/presentation/bloc/auth/password_cubit.dart';
import 'package:buytx/core/common/widgets/custom_primary_button.dart';
import 'package:buytx/core/common/widgets/custom_second_button.dart';
import 'package:buytx/core/configs/assets/app_image.dart';
import 'package:buytx/src/auth/domain/entity/userRequest.dart';
import 'package:buytx/src/auth/domain/usercase/validator/signup_validator.dart';
import 'package:buytx/src/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:buytx/src/auth/presentation/bloc/auth/auth_state.dart';
import 'package:buytx/src/auth/presentation/bloc/auth/police_cubit.dart';
import 'package:buytx/src/auth/presentation/widgets/auth_text_field.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late TextEditingController email;

  late TextEditingController userName;

  late TextEditingController fullName;

  late TextEditingController password;

  late TextEditingController confirmPassword;

  bool checkAccepte = true;
  bool accepted = false;

  final GlobalKey<FormState> _keySignup = GlobalKey<FormState>();

  @override
  void initState() {
    email = TextEditingController();
    userName = TextEditingController();
    fullName = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
    email.clear();
    userName.clear();
    fullName.clear();
    password.clear();
    confirmPassword.clear();
  }

  OutlineInputBorder _inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(color: Colors.green, width: 2),
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
        BlocProvider<PolicyCubit>(create: (context) => PolicyCubit()),
        BlocProvider(create: (context) => ConfirmPasswordVisibilityCubit()),
        BlocProvider(create: (context) => PasswordVisibilityCubit()),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 42.81),
            child: Form(
              key: _keySignup,
              child: FadeInLeft(
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
                        validtor:
                            (value) => SignupValidator.validateEmail(value),
                        text: 'البريد الإلكتروني',
                        sufIcon: Icon(
                          Icons.email,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),
                    FadeInLeft(
                      duration: Duration(milliseconds: 700),
                      child: AuthTextField(
                        controller: userName,
                        text: 'اسم المستخدم',
                        validtor:
                            (value) => SignupValidator.validateUsername(value),
                        sufIcon: Icon(
                          Icons.person,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),
                    FadeInLeft(
                      duration: Duration(milliseconds: 900),
                      child: AuthTextField(
                        controller: fullName,
                        text: 'الاسم الكامل',
                        validtor:
                            (value) => SignupValidator.validateFullName(value),
                        sufIcon: Icon(
                          Icons.person,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),
                    FadeInLeft(
                      duration: Duration(milliseconds: 1100),
                      child: BlocBuilder<PasswordVisibilityCubit, bool>(
                        builder: (context, state) {
                          return AuthTextField(
                            scure: state,
                            controller: password,
                            validtor:
                                (value) =>
                                    SignupValidator.validatePassword(value),
                            text: 'كلمة السر',
                            preIcon: IconButton(
                              onPressed:
                                  () =>
                                      context
                                          .read<PasswordVisibilityCubit>()
                                          .toggleVisibility(),
                              icon: AnimatedSwitcher(
                                duration: const Duration(microseconds: 300),
                                transitionBuilder: (child, animation) {
                                  // you can choose FadeTransition, ScaleTransition, RotationTransition, etc.
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                                child: Icon(
                                  state
                                      ? CupertinoIcons.eye_slash_fill
                                      : CupertinoIcons.eye_fill,
                                  key: ValueKey<bool>(state),
                                  color: Theme.of(context).primaryColor,
                                ),
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
                    SizedBox(height: size.height * 0.015),
                    FadeInLeft(
                      duration: Duration(milliseconds: 1300),
                      child: BlocBuilder<ConfirmPasswordVisibilityCubit, bool>(
                        builder: (context, state2) {
                          return AuthTextField(
                            controller: confirmPassword,
                            scure: state2,
                            text: 'تأكيد كلمة السر',
                            validtor:
                                (value) =>
                                    SignupValidator.validateConfirmPassword(
                                      value,
                                      password.text,
                                    ),
                            preIcon: IconButton(
                              onPressed:
                                  () =>
                                      context
                                          .read<
                                            ConfirmPasswordVisibilityCubit
                                          >()
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
                    SizedBox(height: size.height * 0.01),
                    _agreePolicy(context),
                    SizedBox(height: size.height * 0.01),
                    FadeInRight(
                      duration: Duration(milliseconds: 1500),
                      child: BlocBuilder<PolicyCubit, PolicyState>(
                        builder: (context, state) {
                          return CustomPrimaryButton(
                            ontap: () {
                              if (_keySignup.currentState!.validate()) {
                                if (!accepted) {
                                  context.read<PolicyCubit>().notAccept();
                                } else {
                                  print('2');
                                  context.pushNamed(
                                    'phone',
                                    extra: UserRequestEnity(
                                      email: email.text,
                                      password: password.text,
                                      username: userName.text,
                                      fullName: fullName.text,
                                      phone: '',
                                      authProvider: ['local'],
                                    ),
                                  );
                                }
                              }
                            },
                            color: Theme.of(context).primaryColor,
                            height: 45,
                            width: size.width,
                            text: 'التالي',
                          );
                        },
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    _haveAccount(context),
                    SizedBox(height: size.height * 0.04),
                    _googleLogin(context),
                    SizedBox(height: size.height * 0.02),
                    CustomSecondButton(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      width: 226,
                      height: 40,
                      text: 'Google إنشاء باستخدام ',
                    ),
                    SizedBox(height: size.height * 0.03),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildTitle(context) {
    return Text(
      'أنشئ حسابك الأن',
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  _buildImage() {
    return Image.asset(AppImage.signupImage);
  }

  Widget _agreePolicy(BuildContext context) {
    return BlocBuilder<PolicyCubit, PolicyState>(
      builder: (context, state) {
        print(state.runtimeType);
        if (state is AcceptePolicyState || state is InilPolicyState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'الموافقة على سياسة الخصوصية',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onBackground,
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 4,
                  ),
                ),
                child: Checkbox(
                  shape: const RoundedRectangleBorder(
                    // borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.black, width: 2),
                  ),
                  fillColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.onBackground,
                  ),
                  value: accepted,
                  onChanged: (value) {
                    accepted = value!;
                    setState(() {});
                    value ? context.read<PolicyCubit>().accept() : null;
                  },
                  checkColor: Colors.black,
                ),
              ),
            ],
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              'الموافقة على سياسة الخصوصية',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onBackground,
                border: Border.all(color: Colors.red, width: 4),
              ),
              child: Checkbox(
                shape: const RoundedRectangleBorder(
                  // borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: Colors.black, width: 2),
                ),
                fillColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.onBackground,
                ),
                value: accepted,
                onChanged: (value) {
                  accepted = value!;
                  setState(() {});
                  value ? context.read<PolicyCubit>().accept() : null;
                },
                checkColor: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _haveAccount(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/auth/login'),
      child: Text(
        ' لديك حساب؟',
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
      ' إنشاء حساب باستخدام',
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
