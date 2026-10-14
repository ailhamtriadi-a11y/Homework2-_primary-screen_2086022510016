import 'package:flutter/material.dart';

class ProductCardWidget extends StatelessWidget {
  final String title;
  final String artist;
  final String price;
  final double rating;
  final String? location;
  final String imagePlaceholder;
  final int buyCount;
  final bool isSaved;
  final VoidCallback onTap;
  final VoidCallback onBuy;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const ProductCardWidget({
    super.key,
    required this.title,
    required this.artist,
    required this.price,
    required this.rating,
    this.location,
    required this.imagePlaceholder,
    required this.buyCount,
    required this.isSaved,
    required this.onTap,
    required this.onBuy,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 72,
                    width: 72,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        imagePlaceholder,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Dominant Element: Title with Title Medium Hierarchy
                        Text(
                          title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'By: $artist',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        if (location != null)
                          Text(
                            '📍 $location',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            Text(' $rating', style: theme.textTheme.bodyMedium),
                            const Spacer(),
                            // Dominant Element: Price tag with Primary color role
                            Text(
                              price,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onCancel,
                    child: Text(
                      'Batalkan',
                      style: TextStyle(color: theme.colorScheme.error),
                    ),
                  ),
                  IconButton.outlined(
                    isSelected: isSaved,
                    icon: const Icon(Icons.favorite_border),
                    selectedIcon: Icon(Icons.favorite, color: theme.colorScheme.primary),
                    onPressed: onSave,
                  ),
                  const SizedBox(width: 8),
                  Badge(
                    label: Text('${buyCount}x'),
                    isLabelVisible: buyCount > 0,
                    child: FilledButton(
                      onPressed: onBuy,
                      child: const Text('Beli'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}