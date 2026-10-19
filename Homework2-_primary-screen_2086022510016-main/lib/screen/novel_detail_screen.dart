import 'package:flutter/material.dart';

class NovelDetailScreen extends StatelessWidget {
  final Map<String, dynamic> novel;

  const NovelDetailScreen({super.key, required this.novel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mc = novel['mcCharacteristics'] as Map<String, dynamic>? ?? {};
    final loreList = novel['worldLoreHistory'] as List<dynamic>? ?? [];
    final latestLore = loreList.isNotEmpty ? loreList.last as Map<String, dynamic> : {};

    final titleEng = novel['titleEnglish'] ?? 'Untitled';
    final titleOrig = novel['titleOriginal'] ?? '';
    final author = novel['author'] ?? 'Unknown';
    final status = novel['status'] ?? 'Reading';
    final chapter = novel['currentChapter'] ?? 1;
    final rating = novel['ratingValue'] ?? 0.0;
    final imageUrl = (novel['imageUrl'] as String?) ?? '';
    final placeholder = (novel['imagePlaceholder'] as String?) ?? 'NVL';

    return Scaffold(
      appBar: AppBar(
        title: Text(titleEng, overflow: TextOverflow.ellipsis),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl.isNotEmpty) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, err, stack) => _buildPlaceholderHeader(theme, placeholder, titleEng, titleOrig),
                ),
              ),
              const SizedBox(height: 16),
            ] else
              _buildPlaceholderHeader(theme, placeholder, titleEng, titleOrig),
            const SizedBox(height: 12),
            Text('Penulis: $author', style: theme.textTheme.titleMedium),
            Text('Status: $status • Ch. Terakhir: $chapter', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.star, color: Colors.amber),
                title: const Text('Rating Novel'),
                subtitle: Text('$rating ★'),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text('Nama & Kepribadian MC', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text('${mc['name'] ?? '-'} (${mc['personality'] ?? '-'})'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.bolt, color: Colors.amber),
                        const SizedBox(width: 8),
                        Text('Kemampuan MC', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text('${mc['abilities'] ?? '-'}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.public, color: Colors.green),
                        const SizedBox(width: 8),
                        Text('Setting & Lore Dunia', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text('${latestLore['lore'] ?? '-'}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderHeader(ThemeData theme, String placeholder, String titleEng, String titleOrig) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text('📖 $titleEng', textAlign: TextAlign.center, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          if (titleOrig.isNotEmpty) Text('($titleOrig)', textAlign: TextAlign.center, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}