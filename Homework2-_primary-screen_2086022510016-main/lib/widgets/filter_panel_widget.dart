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
    final subOptions = <String, List<String>>{
      'Location': ['All', 'Makassar', 'Jakarta', 'Bandung', 'Yogyakarta', 'Bali', 'Solo'],
      'Transaction Methods': ['All', 'M-Banking', 'Tunai'],
      'Promo': ['All', 'Ada Promo', 'Tidak Promo'],
      'Rating': ['All', 'Rating 5.0', 'Rating 4.0+', 'Rating 3.0+', 'Rating 2.0+'],
    };
    final categories = subOptions.keys.toList();

    return Card(
      color: theme.colorScheme.surfaceContainerLow,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tombol Action Menggunakan Wrap Agar Tidak Overflow di 320dp
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.icon(
                  onPressed: onApplyFilter,
                  icon: const Icon(Icons.check, size: 16),
                  label: const Text('Apply Filter'),
                ),
                OutlinedButton(
                  onPressed: onClearFilter,
                  child: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '1. Select Category:',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Wrap menjaga chip turun ke bawah dengan aman jika layar 320dp
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: categories.map((cat) {
                return ChoiceChip(
                  label: Text(
                    cat,
                    style: theme.textTheme.bodySmall,
                  ),
                  selected: selectedCategory == cat,
                  onSelected: (_) => onCategorySelected(cat),
                );
              }).toList(),
            ),
            if (selectedCategory != 'All' && subOptions.containsKey(selectedCategory)) ...[
              const SizedBox(height: 12),
              Text(
                '2. Select $selectedCategory:',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: subOptions[selectedCategory]!.map((sub) {
                  return FilterChip(
                    label: Text(
                      sub,
                      style: theme.textTheme.bodySmall,
                    ),
                    selected: selectedSubFilter == sub,
                    onSelected: (_) => onSubFilterSelected(sub),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}