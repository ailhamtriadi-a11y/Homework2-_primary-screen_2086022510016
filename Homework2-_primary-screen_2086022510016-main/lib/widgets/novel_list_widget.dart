import 'package:flutter/material.dart';
import 'novel_card_widget.dart';

class NovelListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> novels;
  final bool isScrollable;
  final Function(Map<String, dynamic>) onTap;
  final Function(Map<String, dynamic>) onEdit;
  final Function(Map<String, dynamic>) onSave;
  final Function(Map<String, dynamic>) onDelete;

  const NovelListWidget({
    super.key,
    required this.novels,
    required this.isScrollable,
    required this.onTap,
    required this.onEdit,
    required this.onSave,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: !isScrollable,
      physics: isScrollable ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(),
      itemCount: novels.length,
      itemBuilder: (context, index) {
        final item = novels[index];
        return NovelCardWidget(
          titleEnglish: item['titleEnglish'] as String,
          titleOriginal: item['titleOriginal'] as String,
          author: item['author'] as String,
          status: item['status'] as String,
          currentChapter: item['currentChapter'] as int,
          rating: (item['ratingValue'] as num).toDouble(),
          imagePlaceholder: item['imagePlaceholder'] as String,
          isSaved: item['isSaved'] as bool,
          onTap: () => onTap(item),
          onEdit: () => onEdit(item),
          onSave: () => onSave(item),
          onDelete: () => onDelete(item),
        );
      },
    );
  }
}