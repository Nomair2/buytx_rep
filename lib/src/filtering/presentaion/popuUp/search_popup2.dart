import 'package:flutter/material.dart';

class SearchPopup2 extends StatefulWidget {
  final List<String> allLocation;
  final String label;
  const SearchPopup2({
    super.key,
    required this.allLocation,
    required this.label,
  });

  @override
  State<SearchPopup2> createState() => _SearchPopup2State();
}

class _SearchPopup2State extends State<SearchPopup2> {
  // final List<String> allLocation = [
  //   'الكل',
  //   'حمص',
  //   'حلب',
  //   'دمشق',
  //   'إدلب',
  //   'دير الزور',
  //   'الرقة',
  //   'طرطوس',
  //   'اللاذقية',
  // ];

  late List<String> _filteredLocations;
  final Map<String, bool> _selectedLocations = {};
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredLocations = widget.allLocation;
    for (int i = 0; i < widget.allLocation.length; i++) {
      if (i == 1 || i == 2) {
        _selectedLocations[widget.allLocation[i]] = true;
      } else {
        _selectedLocations[widget.allLocation[i]] = false;
      }
    }
    // for (var location in widget.allLocation) {
    //   _selectedLocations[location] = false;
    // }
    // Set initial selections based on the image
    // _selectedLocations['حمص'] = true;
    // _selectedLocations['حلب'] = true;

    _searchController.addListener(_filterLocations);
  }

  void _filterLocations() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredLocations =
          widget.allLocation
              .where((location) => location.toLowerCase().contains(query))
              .toList();
    });
  }

  void _clearSelections() {
    setState(() {
      for (var key in _selectedLocations.keys) {
        _selectedLocations[key] = false;
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildSearchBar(),
            const SizedBox(height: 10),
            _buildLocationsList(),
            const SizedBox(height: 20),
            _buildApplyButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        Text(
          widget.label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: _clearSelections,
          child: Text(
            'مسح الكل',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      textAlign: TextAlign.right,
      controller: _searchController,
      style: const TextStyle(color: Colors.black),
      cursorColor: Theme.of(context).colorScheme.onSecondary,
      decoration: InputDecoration(
        hintText: 'بحث',
        hintTextDirection: TextDirection.rtl,
        hintStyle: TextStyle(color: Colors.black),
        suffixIcon: Icon(Icons.search, color: Colors.black),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
      ),
    );
  }

  Widget _buildLocationsList() {
    return Flexible(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _filteredLocations.length,
        itemBuilder: (context, index) {
          final location = _filteredLocations[index];
          return _buildLocationCheckbox(location);
        },
      ),
    );
  }

  Widget _buildLocationCheckbox(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(
            color:
                _selectedLocations[title]!
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).colorScheme.onSecondary,
            fontSize: 18,
          ),
        ),
        const SizedBox(width: 10),
        Checkbox(
          value: _selectedLocations[title],
          onChanged: (bool? value) {
            setState(() {
              if (title == 'الكل') {
                for (var key in _selectedLocations.keys) {
                  _selectedLocations[key] = value ?? false;
                }
              } else {
                _selectedLocations[title] = value ?? false;
                if (_selectedLocations.values.where((v) => v == true).length ==
                    widget.allLocation.length - 1) {
                  _selectedLocations['الكل'] = true;
                } else {
                  _selectedLocations['الكل'] = false;
                }
              }
            });
          },
          activeColor: Theme.of(context).primaryColor,
          checkColor: Colors.white,
          side: BorderSide(
            color: Theme.of(context).colorScheme.onSecondary,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ],
    );
  }

  Widget _buildApplyButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Apply filter logic here
          Navigator.of(context).pop();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text(
          'تطبيق',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
