import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onStarPressed;
  final bool isFilterVisible;

const SearchBarWidget({
  super.key,
  required this.searchQuery,
  required this.onSearchChanged,
  required this.onStarPressed,
  required this.isFilterVisible,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          // Bintang Merah sebagai Tombol Toggle Filter
          IconButton(
            icon: Icon(
              Icons.star,
              color: isFilterVisible ? Colors.red : Colors.red[300],
              size: 26,
            ),
            tooltip: 'Tampilkan / Sembunyikan Filter Choice',
            onPressed: onStarPressed,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: TextField(
              onChanged: onSearchChanged,
              decoration: const InputDecoration(
                hintText: 'Search artwork or artist...',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}