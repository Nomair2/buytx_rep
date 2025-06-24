import 'package:buytx/src/filtering/presentaion/popuUp/search_popup2.dart';
import 'package:flutter/material.dart';

class Popup2 extends StatefulWidget {
  const Popup2({super.key});

  @override
  State<Popup2> createState() => _Popup2State();
}

class _Popup2State extends State<Popup2> {
  RangeValues _sypRangeValues = const RangeValues(0, 2000000);
  RangeValues _usdRangeValues = const RangeValues(0, 200);
  bool _showMoreDetails = false;
  int _selectedStatus = 1; // 0: All, 1: Used, 2: New

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.onSurface,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildPriceSection(),
                const SizedBox(height: 24),
                const SizedBox(height: 16),
                _buildDetailButton("الموقع", () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => SearchPopup2(
                          allLocation: [
                            'الكل',
                            'دمشق',
                            'ريف دمشق',
                            'درعا',
                            'السويداء',
                            'حمص',
                            'حماة',
                            'طرطوس',
                            'اللاذقية',
                            'إدلب',
                            'حلب',
                            'الرقة',
                            'دير الزور',
                            'الحسكة',
                            'القنيطرة',
                          ],

                          label: 'الموقع',
                        ),
                  );
                }),
                const SizedBox(height: 16),
                _buildMoreDetailsToggle(),
                if (_showMoreDetails) ...[
                  const SizedBox(height: 12),
                  _buildDetailButton("المدن الرئيسية", () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => SearchPopup2(
                            allLocation: [
                              'الكل',
                              'الإنشاءات',
                              'اعزاز ',
                              'جرابلس ',
                              'جبل سمعان',
                              'عين العرب',
                              'منبج ',
                              'المحطة',
                              'الغوطة',
                            ],

                            label: "المدن الرئيسية",
                          ),
                    );
                  }),
                  const SizedBox(height: 12),
                  _buildDetailButton("الصنف", () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => SearchPopup2(
                            allLocation: [
                              'الكل',
                              'هواتف',
                              'لابتوبات',
                              'عقارات',
                              'ملابس',
                              'سيارات',
                              'كتب',
                              'ألعاب إلكترونية',
                              'أثاث',
                            ],

                            label: "الصنف",
                          ),
                    );
                  }),
                ],
                const SizedBox(height: 24),
                _buildProductStatusSection(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            // Apply filter logic
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          ),
          child: const Text(
            'تطبيق',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Row(
          children: [
            Text(
              'فلترة',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_forward,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  _sypRangeValues = const RangeValues(0, 2000000);
                  _usdRangeValues = const RangeValues(0, 200);
                });
              },
              child: const Text(
                'إعادة تعيين',
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ),
            Text(
              'السعر',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildPriceSlider(
          currency: 'SYP',
          values: _sypRangeValues,
          max: 2000000,
          onChanged: (values) {
            setState(() {
              _sypRangeValues = values;
            });
          },
        ),
        const SizedBox(height: 16),
        _buildPriceSlider(
          currency: '\$',
          values: _usdRangeValues,
          max: 200,
          onChanged: (values) {
            setState(() {
              _usdRangeValues = values;
            });
          },
        ),
      ],
    );
  }

  Widget _buildPriceSlider({
    required String currency,
    required RangeValues values,
    required double max,
    required ValueChanged<RangeValues> onChanged,
  }) {
    return Row(
      children: [
        Text(
          currency,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            values.start.round().toStringAsFixed(0),
            style: const TextStyle(color: Colors.black),
          ),
        ),

        Expanded(
          child: RangeSlider(
            values: values,
            min: 0,
            max: max,
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Colors.white,
            onChanged: onChanged,
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            values.end.round().toStringAsFixed(0),
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _buildMoreDetailsToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'هل ترغب بتحديد تفاصيل أكثر للفلترة',
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: _showMoreDetails,
            onChanged: (value) {
              setState(() {
                _showMoreDetails = value ?? false;
              });
            },
            activeColor: Theme.of(context).primaryColor,
            checkColor: Colors.white,
            side: WidgetStateBorderSide.resolveWith(
              (states) =>
                  BorderSide(width: 2.0, color: Theme.of(context).primaryColor),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailButton(String label, void Function()? ontap) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: ontap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.arrow_back, color: Colors.black),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedStatus = 1; // Reset to "Used"
                });
              },
              child: const Text(
                'إعادة تعيين',
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ),
            Text(
              'حالة المنتج',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStatusButton('جديد', 2),
              const SizedBox(width: 12),
              _buildStatusButton('مستعمل', 1),
              const SizedBox(width: 12),
              _buildStatusButton('الكل', 0),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusButton(String label, int index) {
    bool isSelected = _selectedStatus == index;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedStatus = index;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? Theme.of(context).primaryColor : Colors.grey[300],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }
}
