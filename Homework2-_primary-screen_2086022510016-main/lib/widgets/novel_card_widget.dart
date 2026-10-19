import 'dart:convert';
import 'package:flutter/material.dart';

class NovelCardWidget extends StatelessWidget {
  final String titleEnglish;
  final String titleOriginal;
  final String author;
  final String status;
  final int currentChapter;
  final double rating;
  final String imagePlaceholder;
  final String imageUrl;
  final bool isSaved;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onSave;
  final VoidCallback onDelete;

  const NovelCardWidget({
    super.key,
    required this.titleEnglish,
    required this.titleOriginal,
    required this.author,
    required this.status,
    required this.currentChapter,
    required this.rating,
    required this.imagePlaceholder,
    this.imageUrl = '',
    required this.isSaved,
    required this.onTap,
    required this.onEdit,
    required this.onSave,
    required this.onDelete,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Reading': return Colors.green;
      case 'Completed': return Colors.blue;
      case 'Plan to Read': return Colors.orange;
      case 'Dropped': return Colors.red;
      default: return Colors.grey;
    }
  }

  Widget _buildImageContainer(ThemeData theme) {
    // 1. Cek jika gambar dari lokal laptop (Base64 data URL)
    if (imageUrl.startsWith('data:image')) {
      try {
        final base64Str = imageUrl.split(',').last;
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.memory(
            base64Decode(base64Str),
            height: 72,
            width: 72,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _fallbackBox(theme),
          ),
        );
      } catch (_) {
        return _fallbackBox(theme);
      }
    }

    // 2. Cek jika gambar dari Tautan Web / URL biasa
    if (imageUrl.isNotEmpty && Uri.tryParse(imageUrl)?.hasAbsolutePath == true) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          height: 72,
          width: 72,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _fallbackBox(theme),
        ),
      );
    }

    // 3. Jika tidak ada gambar, tampilkan kotak inisial (LotM/NVL)
    return _fallbackBox(theme);
  }

  Widget _fallbackBox(ThemeData theme) {
    return Container(
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
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

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
                  _buildImageContainer(theme),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$titleEnglish ($titleOriginal)',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text('Penulis: $author', maxLines: 1, style: theme.textTheme.bodySmall),
                        Text('Terakhir Dibaca: Ch. $currentChapter', style: theme.textTheme.bodySmall),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            Text(' $rating', style: theme.textTheme.bodyMedium),
                            const Spacer(),
                            Chip(
                              label: Text(status, style: const TextStyle(color: Colors.white, fontSize: 10)),
                              backgroundColor: _getStatusColor(status),
                              visualDensity: VisualDensity.compact,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 20),
                    tooltip: 'Edit Log',
                    onPressed: onEdit,
                  ),
                  TextButton.icon(
                    onPressed: onDelete,
                    icon: Icon(Icons.delete_outline, size: 18, color: theme.colorScheme.error),
                    label: Text('Hapus', style: TextStyle(color: theme.colorScheme.error)),
                  ),
                  IconButton.outlined(
                    isSelected: isSaved,
                    icon: const Icon(Icons.bookmark_border),
                    selectedIcon: Icon(Icons.bookmark, color: theme.colorScheme.primary),
                    onPressed: onSave,
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