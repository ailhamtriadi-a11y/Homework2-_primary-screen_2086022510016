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
    final theme = Theme.of(context);
    
    return SearchBar(
      hintText: 'Search artwork or artist...',
      leading: IconButton(
        icon: Icon(
          Icons.filter_list,
          color: isFilterVisible 
              ? theme.colorScheme.primary 
              : theme.colorScheme.onSurfaceVariant,
        ),
        tooltip: 'Toggle Filters',
        onPressed: onStarPressed,
      ),
      onChanged: onSearchChanged,
      elevation: WidgetStateProperty.all(1.0),
    );
  }
}