import 'package:flutter/material.dart';

class ControlPanelWidget extends StatelessWidget {
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final bool isFilterVisible;
  final VoidCallback onToggleFilter;
  final String selectedCategory;
  final String selectedSubFilter;
  final ValueChanged<String> onCategorySelected;
  final ValueChanged<String> onSubFilterSelected;
  final VoidCallback onApplyFilter;
  final VoidCallback onClearFilter;
  final List<String> newsUpdates;
  final String activeFilter;

  const ControlPanelWidget({
    super.key,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.isFilterVisible,
    required this.onToggleFilter,
    required this.selectedCategory,
    required this.selectedSubFilter,
    required this.onCategorySelected,
    required this.onSubFilterSelected,
    required this.onApplyFilter,
    required this.onClearFilter,
    required this.newsUpdates,
    required this.activeFilter,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subFilters = selectedCategory == 'Status'
        ? ['Reading', 'Completed', 'Plan to Read', 'Dropped']
        : selectedCategory == 'Rating'
            ? ['5 Stars', '4.5+ Stars', '4 Stars', '3+ Stars']
            : <String>[];

    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: TextEditingController(text: searchQuery)
                ..selection = TextSelection.fromPosition(
                  TextPosition(offset: searchQuery.length),
                ),
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Cari judul/penulis...',
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () => onSearchChanged(''),
                      )
                    : IconButton(
                        icon: Icon(
                          isFilterVisible
                              ? Icons.filter_list_off
                              : Icons.filter_list,
                          size: 20,
                        ),
                        onPressed: onToggleFilter,
                      ),
                border: const OutlineInputBorder(),
                isDense: true,
              ),
            ),
            if (isFilterVisible) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: ['Status', 'Rating'].map((cat) {
                  return ChoiceChip(
                    label: Text(cat, style: const TextStyle(fontSize: 11)),
                    selected: selectedCategory == cat,
                    onSelected: (_) => onCategorySelected(
                      selectedCategory == cat ? 'All' : cat,
                    ),
                  );
                }).toList(),
              ),
              if (subFilters.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: subFilters.map((sub) {
                    return ChoiceChip(
                      label: Text(sub, style: const TextStyle(fontSize: 11)),
                      selected: selectedSubFilter == sub,
                      onSelected: (_) => onSubFilterSelected(sub),
                    );
                  }).toList(),
                ),
              ],
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onClearFilter,
                    child: const Text('Reset', style: TextStyle(fontSize: 12)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: onApplyFilter,
                    child: const Text('Terapkan', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ],
            if (newsUpdates.isNotEmpty) ...[
              const Divider(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 140),
                child: Scrollbar(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: newsUpdates.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.campaign_outlined, size: 15),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                newsUpdates[index],
                                style: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}