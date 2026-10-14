import 'package:flutter/material.dart';

class NewsBannerWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> updates;
  final String activeFilter;

  const NewsBannerWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.updates,
    required this.activeFilter,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: theme.colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.newspaper, color: theme.colorScheme.onSecondaryContainer, size: 20),
                const SizedBox(width: 8),
                Text(
                  'News & Order Updates',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSecondaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (activeFilter != 'All')
                  Chip(
                    labelStyle: theme.textTheme.labelSmall,
                    padding: EdgeInsets.zero,
                    label: Text('Filter: $activeFilter'),
                  ),
              ],
            ),
            const Divider(),
            ...updates.map(
              (update) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text(
                  update,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}