import 'package:flutter/material.dart';

class FilterPanelWidget extends StatelessWidget {
  final String selectedCategory;
  final String selectedSubFilter;
  final ValueChanged<String> onCategorySelected;
  final ValueChanged<String> onSubFilterSelected;
  final VoidCallback onApplyFilter;
  final VoidCallback onClearFilter;

  const FilterPanelWidget({
    Key? key,
    required this.selectedCategory,
    required this.selectedSubFilter,
    required this.onCategorySelected,
    required this.onSubFilterSelected,
    required this.onApplyFilter,
    required this.onClearFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subOptions = <String, List<String>>{
      'Location': ['All', 'Makassar', 'Jakarta', 'Bandung', 'Yogyakarta', 'Bali', 'Solo'],
      'Transaction Methods': ['All', 'Transfer M-Banking', 'Tunai'],
      'Promo': ['All', 'Ada Promo', 'Tanpa Promo'],
      'Rating': ['All', 'Rating 5.0', 'Rating 4.0+', 'Rating 3.0+', 'Rating 2.0+'],
    };
    final categories = subOptions.keys.toList();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: onApplyFilter,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text('Apply filter', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: onClearFilter,
                child: const Text('Clear'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('1. Pilih Kategori Filter:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            children: categories.map((cat) {
              final isCatSelected = selectedCategory == cat;
              return ChoiceChip(
                label: Text(cat, style: const TextStyle(fontSize: 11)),
                selected: isCatSelected,
                selectedColor: Colors.orange[200],
                backgroundColor: Colors.white,
                onSelected: (_) => onCategorySelected(cat),
              );
            }).toList(),
          ),
          if (selectedCategory != 'All' && subOptions.containsKey(selectedCategory)) ...[
            const SizedBox(height: 10),
            Text('2. Pilih Detail $selectedCategory:', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              children: subOptions[selectedCategory]!.map((sub) {
                final isSubSelected = selectedSubFilter == sub;
                return ChoiceChip(
                  label: Text(
                    sub,
                    style: TextStyle(
                      fontSize: 11,
                      color: isSubSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  selected: isSubSelected,
                  selectedColor: Colors.red,
                  backgroundColor: Colors.white,
                  onSelected: (_) => onSubFilterSelected(sub),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}