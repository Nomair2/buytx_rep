import 'package:buytx/src/auth/presentation/widgets/auth_text_field.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerificationReqPage extends StatefulWidget {
  static String name = 'verificationReqPage';
  const VerificationReqPage({super.key});

  @override
  State<VerificationReqPage> createState() => _VerificationReqPageState();
}

class _VerificationReqPageState extends State<VerificationReqPage> {
  TextEditingController typeAccount = TextEditingController(
    text: 'حساب فردي (شخصي)',
  );

  int _currentStep = 0;

  // Stage 1
  String? _accountType = 'حساب فردي (شخصي)';
  final List<String> _accountTypes = ['حساب فردي (شخصي)', 'حساب شركة'];

  // Stage 2
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  DateTime? _birthDate;

  // Stage 3
  List<ImageProvider?> _images = [null, null, null];

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() => _currentStep++);
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  void _pickDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime(selectedYear, selectedMonth, selectedDay),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        return Row(
          children: [
            i == 0
                ? Container(width: 40, height: 3, color: Colors.grey[300])
                : SizedBox(),
            CircleAvatar(
              radius: 18,
              backgroundColor:
                  i <= _currentStep
                      ? const Color(0xFF8BC34A)
                      : Colors.grey[300],
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    color:
                        i <= _currentStep
                            ? const Color.fromARGB(255, 0, 0, 0)
                            : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (i < 2)
              Container(
                width: 40,
                height: 3,
                color:
                    i < _currentStep
                        ? const Color(0xFF8BC34A)
                        : Colors.grey[300],
              ),

            i == 2
                ? Container(width: 40, height: 3, color: Colors.grey[300])
                : SizedBox(),
          ],
        );
      }),
    );
  }

  _border() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: BorderSide(color: Colors.black),
  );

  Widget _buildStage1(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        Text(
          'حدد نوع الحساب',
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: size.height * 0.04),
        TextFormField(
          textAlign: TextAlign.end,
          style: TextStyle(color: Colors.black),
          cursorColor: Theme.of(context).colorScheme.onSecondary,
          readOnly: true,
          controller: typeAccount,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            focusedBorder: _border(),
            disabledBorder: _border(),
            border: _border(),
            enabledBorder: _border(),
            prefixIcon: DropdownButton(
              alignment: AlignmentDirectional.center,
              hint: null,
              selectedItemBuilder: (context) => [SizedBox()],
              padding: EdgeInsets.only(left: 20),
              value: _accountType,
              menuWidth: 200,
              icon: Icon(Icons.keyboard_arrow_down_outlined),
              underline: SizedBox.shrink(),
              items:
                  _accountTypes
                      .map(
                        (type) => DropdownMenuItem(
                          alignment: AlignmentDirectional.center,
                          value: type,
                          child: Text(type, style: TextStyle(fontSize: 14)),
                        ),
                      )
                      .toList(),
              onChanged: (val) => setState(() => typeAccount.text = val!),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        const SizedBox(height: 30),
        Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            text: 'توضيح:',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 14,
            ),
            children: [
              TextSpan(
                text:
                    typeAccount.text == _accountTypes[0]
                        ? "الحساب الذي يتم فتحه فقط لمرة واحدة"
                        : " هذا الحساب الذي يخص عمل تجاري مسجل مثل شركة أو محل تجاري",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: size.height * 0.28),
        _buildNextButton('التالي'),
      ],
    );
  }

  Widget _buildStage2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        Text(
          'أدخل المعلومات التالية',
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),

        TextField(
          controller: _nameController,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: 'الاسم الكامل',
            hintStyle: TextStyle(color: Colors.black),
            border: _border(),
            enabledBorder: _border(),
            disabledBorder: _border(),
            suffixIcon: Icon(
              Icons.person,
              color: Theme.of(context).primaryColor,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          readOnly: true,
          controller: _nameController,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            // hintText: 'الاسم الكامل',
            hintStyle: TextStyle(color: Colors.black),
            border: _border(),
            enabledBorder: _border(),
            disabledBorder: _border(),
            prefixIcon: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // MM
                Row(
                  children: [
                    Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.black,
                    ),
                    Text(
                      "MM: $selectedMonth",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                // DD
                Row(
                  children: [
                    Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.black,
                    ),
                    Text(
                      "DD: $selectedDay",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                // YYYY
                Row(
                  children: [
                    Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.black,
                    ),
                    Text(
                      "YYYY: $selectedYear",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            suffixIcon: Icon(
              Icons.date_range,
              color: Theme.of(context).primaryColor,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        Container(
          // padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(25),
            color: Colors.grey.shade100,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // MM
              Row(
                children: [
                  Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black),
                  Text(
                    "MM: $selectedMonth",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              // DD
              Row(
                children: [
                  Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black),
                  Text(
                    "DD: $selectedDay",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              // YYYY
              Row(
                children: [
                  Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black),
                  Text(
                    "YYYY: $selectedYear",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              // Date Picker Button
              IconButton(
                onPressed: _pickDate,
                icon: const Icon(Icons.date_range, color: Colors.red),
                tooltip: "Pick Date",
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),
        TextField(
          controller: _idController,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: 'الاسم الكامل',
            hintStyle: TextStyle(color: Colors.black),
            border: _border(),
            enabledBorder: _border(),
            disabledBorder: _border(),
            suffixIcon: Icon(
              Icons.account_box_rounded,
              color: Theme.of(context).primaryColor,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        _buildNextButton('التالي'),
      ],
    );
  }

  Widget _buildStage3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        const Text(
          'رفع الصور',
          style: TextStyle(
            fontSize: 20,
            color: Color(0xFF8BC34A),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (i) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () {
                  // TODO: Implement image picker
                },
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                          i == 2
                              ? const Color(0xFF8BC34A)
                              : Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child:
                      _images[i] != null
                          ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image(image: _images[i]!, fit: BoxFit.cover),
                          )
                          : i == 2
                          ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.add_photo_alternate,
                                color: Color(0xFF8BC34A),
                                size: 32,
                              ),
                              Text(
                                'إضافة صور',
                                style: TextStyle(
                                  color: Color(0xFF8BC34A),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          )
                          : const Icon(
                            Icons.image,
                            color: Colors.grey,
                            size: 32,
                          ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 16),
        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'توضيح: يجب رفع\n'
            'صورة من الهوية (الوجه الأمامي)\n'
            'صورة من الهوية (الوجه الخلفي)\n'
            'صورة شخصية لك تحمل الهوية الشخصية',
            style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.6),
            textAlign: TextAlign.right,
          ),
        ),
        _buildNextButton('إرسال', isLast: true),
      ],
    );
  }

  Widget _buildNextButton(String label, {bool isLast = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24, top: 16),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed:
              isLast
                  ? () {
                    // TODO: Submit logic
                  }
                  : _nextStep,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        elevation: 0,
        leading: SizedBox(),
        actions: [
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            onPressed: _prevStep,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 15),
                Text(
                  'طلب توثيق حساب',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50),
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      width: size.width,
                      height: 3,
                      color: Colors.grey[300],
                    ),
                    Row(
                      children: List.generate(3, (i) {
                        return Row(
                          children: [
                            MediaQuery.of(context).orientation ==
                                    Orientation.landscape
                                ? SizedBox(width: size.width * 0.2)
                                : SizedBox(width: size.width * 0.15),
                            CircleAvatar(
                              radius: 18,
                              backgroundColor:
                                  i <= _currentStep
                                      ? const Color(0xFF8BC34A)
                                      : Colors.grey[300],
                              child: Center(
                                child: Text(
                                  '${i + 1}',
                                  style: TextStyle(
                                    color:
                                        i <= _currentStep
                                            ? const Color.fromARGB(255, 0, 0, 0)
                                            : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),

                      // [
                      //   SizedBox(width: size.width * 0.25),
                      //   CircleAvatar(
                      //     radius: 18,
                      //     backgroundColor:
                      //         // i <= _currentStep
                      //         //     ? const Color(0xFF8BC34A)
                      //         //     :
                      //         Colors.grey[300],
                      //     child: Center(
                      //       child: Text(
                      //         '${1}',
                      //         style: TextStyle(
                      //           color:
                      //               // i <= _currentStep
                      //               //     ? const Color.fromARGB(255, 0, 0, 0)
                      //               //     :
                      //               Colors.black,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ],
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.05),
                // _buildStepIndicator(),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child:
                      _currentStep == 0
                          ? _buildStage1(size)
                          : _currentStep == 1
                          ? _buildStage2()
                          : _buildStage3(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
