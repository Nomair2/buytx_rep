import 'package:flutter/material.dart';
import 'package:buytx/core/configs/theme/app_colors.dart';
import 'package:buytx/core/common/widgets/custom_primary_button.dart';

class SearchPopup extends StatefulWidget {
  const SearchPopup({super.key});

  @override
  State<SearchPopup> createState() => _SearchPopupState();
}

class _SearchPopupState extends State<SearchPopup> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  // Recent searches (mock data - in real app this would come from storage)
  final List<String> _recentSearches = [
    'iPhone 14',
    'سيارة مستعملة',
    'شقة للإيجار',
    'لابتوب Dell',
    'أثاث مكتبي',
  ];

  // Popular searches (mock data)
  final List<String> _popularSearches = [
    'عقارات الرياض',
    'سيارات للبيع',
    'إلكترونيات',
    'أثاث منزلي',
    'ملابس رجالية',
    'هواتف ذكية',
    'شقق للإيجار',
    'مكيفات',
  ];

  @override
  void initState() {
    super.initState();
    // Auto focus on search field when popup opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: 0.5),
      body: SafeArea(
        child: Column(
          children: [
            // Search Header
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Back button
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),

                  // Search field
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black87,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        hintText: 'ابحث هنا...',
                        hintStyle: TextStyle(
                          color:
                              isDarkMode ? Colors.grey[400] : Colors.grey[600],
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {}); // Rebuild to show/hide clear button
                      },
                      onSubmitted: (value) {
                        if (value.trim().isNotEmpty) {
                          _performSearch(value.trim());
                        }
                      },
                    ),
                  ),

                  // Search/Clear button
                  if (_searchController.text.isNotEmpty)
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                        });
                      },
                      icon: Icon(
                        Icons.clear,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      ),
                    )
                  else
                    IconButton(
                      onPressed: () {
                        final searchText = _searchController.text.trim();
                        if (searchText.isNotEmpty) {
                          _performSearch(searchText);
                        }
                      },
                      icon: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                ],
              ),
            ),

            // Search Results/Suggestions
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child:
                    _searchController.text.isEmpty
                        ? _buildSearchSuggestions()
                        : _buildSearchResults(),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSuggestions() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent Searches
          if (_recentSearches.isNotEmpty) ...[
            _buildSectionTitle('البحث الأخير'),
            const SizedBox(height: 12),
            ..._recentSearches.map(
              (search) => _buildSearchItem(
                text: search,
                icon: Icons.history,
                onTap: () => _performSearch(search),
                onDelete: () => _removeRecentSearch(search),
                showDelete: true,
              ),
            ),
            const SizedBox(height: 24),
          ],

          // Popular Searches
          _buildSectionTitle('البحث الشائع'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                _popularSearches.map((search) {
                  return GestureDetector(
                    onTap: () => _performSearch(search),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundCategories.withValues(
                          alpha: 0.3,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.backgroundCategories,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        search,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    // This would show actual search results
    // For now, showing a simple message
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'جاري البحث عن "${_searchController.text}"...',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildSearchItem({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
    VoidCallback? onDelete,
    bool showDelete = false,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color:
                isDarkMode ? const Color(0xFF2A2A2A) : const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              if (showDelete && onDelete != null)
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(
                    Icons.close,
                    size: 18,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: CustomPrimaryButton(
        width: double.infinity,
        height: 48,
        color: Theme.of(context).primaryColor,
        text: 'بحث',
        ontap: () {
          final searchText = _searchController.text.trim();
          if (searchText.isNotEmpty) {
            _performSearch(searchText);
          }
        },
      ),
    );
  }

  void _performSearch(String searchText) {
    // Add to recent searches if not already present
    if (!_recentSearches.contains(searchText)) {
      setState(() {
        _recentSearches.insert(0, searchText);
        // Keep only last 5 recent searches
        if (_recentSearches.length > 5) {
          _recentSearches.removeLast();
        }
      });
    }

    // TODO: Implement actual search functionality
    // This could involve calling a search API, updating a bloc, etc.
    print('Searching for: $searchText');

    // Close the popup and return the search term
    Navigator.of(context).pop(searchText);
  }

  void _removeRecentSearch(String searchText) {
    setState(() {
      _recentSearches.remove(searchText);
    });
  }

  // Static method to show the popup
  static Future<String?> show(BuildContext context) {
    return showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (context) => const SearchPopup(),
    );
  }
}
