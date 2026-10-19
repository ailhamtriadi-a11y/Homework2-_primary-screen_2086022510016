import 'package:flutter/material.dart';

class FilterPanelWidget extends StatelessWidget {
  final String selectedCategory;
  final String selectedSubFilter;
  final ValueChanged<String> onCategorySelected;
  final ValueChanged<String> onSubFilterSelected;
  final VoidCallback onApplyFilter;
  final VoidCallback onClearFilter;

  const FilterPanelWidget({
    super.key,
    required this.selectedCategory,
    required this.selectedSubFilter,
    required this.onCategorySelected,
    required this.onSubFilterSelected,
    required this.onApplyFilter,
    required this.onClearFilter,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<String> categories = ['All', 'Status', 'Rating'];
    List<String> subFilters = ['All'];

    if (selectedCategory == 'Status') {
      subFilters = ['All', 'Reading', 'Completed', 'Plan to Read', 'Dropped'];
    } else if (selectedCategory == 'Rating') {
      subFilters = ['All', '5.0 Stars', '4.9 Stars', '4.8+ Stars', '4.7 Stars', '4.6 Stars', '4.5+ Stars', '4.4 Stars', '4.3 Stars', '4.2 Stars',
      '4.1 Stars', '4.0+ Stars', '3.5+ Stars', '3.0+ Stars', '2.5+ Stars', '2.0+ Stars', '1.5+ Stars', '1.0+ Stars'];
    }

    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Category', style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: categories.map((cat) {
                return ChoiceChip(
                  label: Text(cat),
                  selected: selectedCategory == cat,
                  onSelected: (_) => onCategorySelected(cat),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            Text('Filter Value', style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: subFilters.map((sub) {
                return FilterChip(
                  label: Text(sub),
                  selected: selectedSubFilter == sub,
                  onSelected: (_) => onSubFilterSelected(sub),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: onClearFilter, child: const Text('Reset')),
                const SizedBox(width: 8),
                FilledButton(onPressed: onApplyFilter, child: const Text('Apply')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}