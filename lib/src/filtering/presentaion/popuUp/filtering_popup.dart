import 'package:buytx/src/filtering/presentaion/popuUp/search_popup.dart';
import 'package:flutter/material.dart';
import 'package:buytx/core/configs/theme/app_colors.dart';
import 'package:buytx/core/common/widgets/custom_primary_button.dart';
import 'package:buytx/core/common/widgets/custom_second_button.dart';

class FilteringPopup extends StatefulWidget {
  const FilteringPopup({super.key});

  @override
  State<FilteringPopup> createState() => _FilteringPopupState();
}

class _FilteringPopupState extends State<FilteringPopup> {
  // Filter state variables
  String selectedCategory = '';
  String selectedLocation = '';
  RangeValues priceRange = const RangeValues(0, 1000000);
  String selectedCondition = '';
  String selectedType = '';

  // Filter options
  final List<String> categories = [
    'عقارات',
    'سيارات',
    'إلكترونيات',
    'أثاث',
    'ملابس',
    'أخرى',
  ];

  final List<String> locations = [
    'الرياض',
    'جدة',
    'الدمام',
    'مكة المكرمة',
    'المدينة المنورة',
    'الطائف',
  ];

  final List<String> conditions = [
    'جديد',
    'مستعمل - ممتاز',
    'مستعمل - جيد',
    'مستعمل - مقبول',
  ];

  final List<String> types = ['للبيع', 'للإيجار', 'مطلوب'];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
          maxWidth: MediaQuery.of(context).size.width * 0.9,
        ),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDarkMode ? 0.5 : 0.15),
              blurRadius: 20,
              offset: const Offset(0, 8),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            _buildHeader(context),

            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Filter
                    _buildFilterSection(
                      title: 'الفئة',
                      child: _buildCategoryGrid(),
                    ),

                    const SizedBox(height: 20),

                    // Location and Type in Row
                    Row(
                      children: [
                        Expanded(
                          child: _buildFilterSection(
                            title: 'الموقع',
                            child: _buildLocationDropdown(),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildFilterSection(
                            title: 'النوع',
                            child: _buildTypeChips(),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Price Range Filter
                    _buildFilterSection(
                      title: 'نطاق السعر',
                      child: _buildPriceRangeSlider(),
                    ),

                    const SizedBox(height: 20),

                    // Condition Filter
                    _buildFilterSection(
                      title: 'الحالة',
                      child: _buildConditionChips(),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Action Buttons
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF2A2A2A) : const Color(0xFFF8F9FA),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        border: Border(
          bottom: BorderSide(
            color:
                isDarkMode ? const Color(0xFF3A3A3A) : const Color(0xFFE5E5E5),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color:
                  isDarkMode
                      ? const Color(0xFF3A3A3A)
                      : const Color(0xFFE5E5E5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.close,
                color: isDarkMode ? Colors.white : Colors.black87,
                size: 20,
              ),
            ),
          ),
          Text(
            'الفلترة',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black87,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'Hacen Tunisia',
            ),
          ),
          const SizedBox(width: 40), // Balance the close button
        ],
      ),
    );
  }

  Widget _buildFilterSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            showDialog(context: context, builder: (context) => SearchPopup());
          },
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  Widget _buildCategoryGrid() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          categories.map((category) {
            final isSelected = selectedCategory == category;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = isSelected ? '' : category;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? Theme.of(context).primaryColor
                          : AppColors.backgroundCategories,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color:
                        isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                    width: 1,
                  ),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildLocationDropdown() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.backgroundCategories.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.backgroundCategories),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedLocation.isEmpty ? null : selectedLocation,
          hint: Text(
            'اختر الموقع',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodySmall?.color,
              fontSize: 16,
            ),
          ),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          items:
              locations.map((location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(location, style: const TextStyle(fontSize: 16)),
                );
              }).toList(),
          onChanged: (value) {
            setState(() {
              selectedLocation = value ?? '';
            });
          },
        ),
      ),
    );
  }

  Widget _buildPriceRangeSlider() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${priceRange.start.round()} ريال',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${priceRange.end.round()} ريال',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Theme.of(context).primaryColor,
            inactiveTrackColor: AppColors.backgroundCategories,
            thumbColor: Theme.of(context).primaryColor,
            overlayColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
          ),
          child: RangeSlider(
            values: priceRange,
            min: 0,
            max: 1000000,
            divisions: 100,
            onChanged: (values) {
              setState(() {
                priceRange = values;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildConditionChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          conditions.map((condition) {
            final isSelected = selectedCondition == condition;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCondition = isSelected ? '' : condition;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? Theme.of(context).primaryColor
                          : AppColors.backgroundCategories,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color:
                        isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                    width: 1,
                  ),
                ),
                child: Text(
                  condition,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildTypeChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          types.map((type) {
            final isSelected = selectedType == type;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedType = isSelected ? '' : type;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? Theme.of(context).primaryColor
                          : AppColors.backgroundCategories,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color:
                        isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                    width: 1,
                  ),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomSecondButton(
              width: double.infinity,
              height: 48,
              color: Colors.transparent,
              text: 'إعادة تعيين',
              ontap: () {
                setState(() {
                  selectedCategory = '';
                  selectedLocation = '';
                  priceRange = const RangeValues(0, 1000000);
                  selectedCondition = '';
                  selectedType = '';
                });
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: CustomPrimaryButton(
              width: double.infinity,
              height: 48,
              color: Theme.of(context).primaryColor,
              text: 'تطبيق الفلتر',
              ontap: () {
                // Apply filters and close popup
                _applyFilters();
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _applyFilters() {
    // Create filter object with selected values
    final filters = {
      'category': selectedCategory,
      'location': selectedLocation,
      'priceMin': priceRange.start,
      'priceMax': priceRange.end,
      'condition': selectedCondition,
      'type': selectedType,
    };

    // TODO: Apply filters to your data source or bloc
    print('Applied filters: $filters');
  }

  // Static method to show the popup
  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const FilteringPopup(),
    );
  }
}
