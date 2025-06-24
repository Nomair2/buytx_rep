import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:buytx/core/common/widgets/custom_primary_button.dart';
import 'package:buytx/core/configs/assets/app_image.dart';
import 'package:buytx/core/error/show_error.dart';
import 'package:buytx/core/services/route/router.dart';
import 'package:buytx/src/auth/domain/entity/userRequest.dart';
import 'package:buytx/src/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:buytx/src/auth/presentation/bloc/auth/auth_event.dart';
import 'package:buytx/src/auth/presentation/bloc/auth/auth_state.dart';
import 'package:go_router/go_router.dart';
// import 'package:country_picker/country_picker.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class PhonePage extends StatefulWidget {
  PhonePage(this.user, {super.key});
  UserRequestEnity user;

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  String countryName = 'Syria';
  late GlobalKey<FormState> _keyPhone;
  int countryNumberLenght = 10;
  late TextEditingController phone;
  late TextEditingController countryField;
  @override
  void initState() {
    // TODO: implement initState
    _keyPhone = GlobalKey<FormState>();
    phone = TextEditingController();
    countryField = TextEditingController();
  }

  @override
  void dispose() {
    phone.clear();
    countryField.clear();
    // TODO: implement dispose
    super.dispose();
  }

  final OutlineInputBorder _inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(color: Colors.white, width: 2),
  );

  void _pickCountry(BuildContext context) {
    // showCountryPicker(
    //   context: context,
    //   countryListTheme: CountryListThemeData(
    //     bottomSheetHeight: MediaQuery.of(context).size.height * 0.4,
    //     searchTextStyle: const TextStyle(color: Colors.white),
    //     inputDecoration: InputDecoration(
    //       iconColor: Colors.white,
    //       border: _inputBorder,
    //       contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    //       focusedBorder: _inputBorder,
    //     ),
    //   ),
    //   showPhoneCode: true,
    //   moveAlongWithKeyboard: true,
    //   onSelect: (Country country) {
    //     countryField.text = country.displayName;
    //     print(country.flagEmoji);
    //     print(country.countryCode);
    //     // setState(() {
    //     //   selectedCountry = country;
    //     // });
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42.81),
          child: Form(
            key: _keyPhone,
            child: Column(
              children: [
                SizedBox(height: size.height * 0.1),
                _buildTitle(context),
                SizedBox(height: size.height * 0.01),
                _buildImage(),
                SizedBox(height: size.height * 0.05),
                IntlPhoneField(
                  controller: phone,
                  dropdownIcon: const Icon(
                    size: 30,
                    Icons.keyboard_arrow_down_outlined,
                    color: Color(0xff72B745),
                  ),
                  validator: (p0) {
                    // print("form validator");
                    // print(p0!.number.length);
                    // print(p0.completeNumber.length);
                    // print(countryNumberLenght);
                    if (p0!.number == "") {
                      return "Mobile Number is required";
                    }
                    //  else if (p0.completeNumber.length !=
                    //     countryNumberLenght) {
                    //   return "Invalid Mobile Number";
                    // }
                  },
                  onCountryChanged: (value) {
                    countryName = value.nameTranslations['en']!;
                    countryNumberLenght = value.maxLength;
                    setState(() {});
                  },
                  dropdownTextStyle: const TextStyle(color: Colors.grey),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  cursorColor: Theme.of(context).colorScheme.onBackground,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.onBackground,
                    counterStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),

                      // border: Border.all(color: Color(0xff72B745), width: 1),
                      // borderSide: BorderSide(color: Color(0xff72B745), width: 1),
                    ),
                  ),
                  initialCountryCode: 'SY',
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                ),
                SizedBox(height: size.height * 0.1),
                BlocConsumer<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    }
                    return CustomPrimaryButton(
                      ontap: () {
                        // setState(() {});
                        if (_keyPhone.currentState!.validate()) {
                          print("1");
                          context.read<AuthBloc>().add(
                            AuthSignupEvent(
                              username: widget.user.username!,
                              password: widget.user.password!,
                              email: widget.user.email!,
                              authprovider: widget.user.authProvider!,
                              fullname: widget.user.fullName!,
                              phone: phone.text,
                            ),
                          );
                        }
                      },
                      color: Theme.of(context).primaryColor,
                      height: 39.23431396484375,
                      width: size.width,
                      text: 'إنشاء حساب',
                    );
                  },
                  listener: (context, state) {
                    if (state is AuthError) {
                      showError(state.message);
                      context.read<AuthBloc>().add(AuthInitEvent());
                    }
                    if (state is AuthSuccess) {
                      context.pushNamed(
                        'verify-otp',
                        extra: VerifyOtpParameter(widget.user.email!, false),
                      );
                    }
                  },
                ),
                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildTitle(context) {
    return Text(
      'إدخل رقم هاتفك ',
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  _buildImage() {
    return Image.asset(AppImage.phoneImage);
  }
}
