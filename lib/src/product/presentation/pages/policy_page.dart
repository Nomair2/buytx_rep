import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PolicyPage extends StatefulWidget {
  const PolicyPage({super.key});

  @override
  State<PolicyPage> createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
  bool checked1 = false;
  bool checked2 = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final double width = MediaQuery.of(context).size.width;
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: width * 0.9,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            color: theme.onSurface,
            borderRadius: BorderRadius.circular(28),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 28), // for symmetry
                    Text(
                      "إتفاقية الرسوم",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      color: theme.onSecondary,
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Divider(color: theme.inversePrimary, thickness: 2),
                const SizedBox(height: 12),
                // Quranic text
                Text(
                  'بِسْمِ اللَّـهِ الرَّحْمَـٰنِ الرَّحِيمِ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: theme.onSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  ': قال الله تعالى',

                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: theme.onSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'وَأَوْفُوا بِعَهْدِ اللَّهِ إِذَا عَاهَدتُّمْ وَلَا تَنقُضُوا الْأَيْمَانَ بَعْدَ تَوْكِيدِهَا وَقَدْ جَعَلْتُمُ اللَّهَ عَلَيْكُمْ كَفِيلًا ۚ إِنَّ اللَّهَ يَعْلَمُ مَا تَفْعَلُونَ.',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: theme.onSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Divider(color: theme.inversePrimary, thickness: 2),
                const SizedBox(height: 8),
                // Checkbox 1
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: checked1,
                      onChanged: (val) {
                        setState(() => checked1 = val ?? false);
                      },
                      activeColor: Theme.of(context).primaryColor,
                    ),
                    Expanded(
                      child: Text(
                        'أتعهد وأقسم بالله أنا الضمان أني أدفع رسوم الموقع والتي تكون بنسبة 1% من قيمة البيع سواء تم البيع عبر الموقع أو بسببه.',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: theme.inversePrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Checkbox 2
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: checked2,
                      onChanged: (val) {
                        setState(() => checked2 = val ?? false);
                      },
                      activeColor: Theme.of(context).primaryColor,
                    ),
                    Expanded(
                      child: Text(
                        'كما أتعهد بدفع الرسوم خلال 10 أيام من استلام المبلغ الكامل للمبايعة.',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: theme.inversePrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Note
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'ملاحظة بشأن الرسوم\nرسوم الموقع تكون على المعلن ولا تُبرأ ذمة المعلن من الرسوم إلا بعد دفعها',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(height: 12),
                // Next button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onPressed:
                        checked1 && checked2
                            ? () {
                              context.pop();
                              // context.pushNamed('productDetail1');
                            }
                            : null,
                    child: Text(
                      'التالي',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
