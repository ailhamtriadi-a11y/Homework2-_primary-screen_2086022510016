import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final VoidCallback onReset;

  const EmptyStateWidget({super.key, required this.onReset});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off_rounded, size: 64, color: theme.colorScheme.secondary),
            const SizedBox(height: 12),
            Text('Novel tidak ditemukan', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text('Coba ubah kata kunci pencarian atau bersihkan filter.', textAlign: TextAlign.center, style: theme.textTheme.bodySmall),
            const SizedBox(height: 16),
            FilledButton.icon(onPressed: onReset, icon: const Icon(Icons.refresh, size: 16), label: const Text('Reset Filter')),
          ],
        ),
      ),
    );
  }
}