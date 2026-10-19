import 'package:flutter/material.dart';
import '../widgets/control_panel_widget.dart';
import '../widgets/novel_card_widget.dart';
import '../widgets/empty_state_widget.dart';
import '../data/mock_novel_data.dart';
import 'novel_detail_screen.dart';
import 'add_edit_log_screen.dart';

class PrimaryScreen extends StatefulWidget {
  const PrimaryScreen({super.key});

  @override
  State<PrimaryScreen> createState() => _PrimaryScreenState();
}

class _PrimaryScreenState extends State<PrimaryScreen> {
  List<Map<String, dynamic>> _allLogs = [];
  bool _isLoading = true;
  String _searchQuery = '', _selectedCat = 'All', _subFilter = 'All', _activeFilter = 'All';
  bool _isFilterVisible = false;
  final List<String> _news = ['📖 System: Novel Vault Tracker siap digunakan.'];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      _allLogs = getLargeMockNovelLogs(count: 500);
      _isLoading = false;
    });
  }

  void _resetFilters() {
    setState(() {
      _selectedCat = _subFilter = _activeFilter = 'All';
      _searchQuery = '';
    });
  }

  Future<void> _addLog() async {
    final res = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (_) => const AddEditLogScreen()),
    );
    if (res != null) {
      setState(() {
        _allLogs.insert(0, res);
        _news.insert(0, '➕ Tambah: [${res['titleEnglish']}]');
      });
    }
  }

  Widget _buildList(List<Map<String, dynamic>> list) {
    if (list.isEmpty) return EmptyStateWidget(onReset: _resetFilters);
    return ListView.builder(
      key: const PageStorageKey('novel_list'),
      padding: const EdgeInsets.only(bottom: 24),
      itemCount: list.length,
      itemBuilder: (context, i) {
        final item = list[i];
        return NovelCardWidget(
          titleEnglish: item['titleEnglish'] ?? 'Untitled',
          titleOriginal: item['titleOriginal'] ?? '',
          author: item['author'] ?? 'Unknown',
          status: item['status'] ?? 'Reading',
          currentChapter: (item['currentChapter'] as num?)?.toInt() ?? 1,
          rating: (item['ratingValue'] as num?)?.toDouble() ?? 0.0,
          imagePlaceholder: item['imagePlaceholder'] ?? 'NVL',
          imageUrl: item['imageUrl'] ?? '',
          isSaved: item['isSaved'] ?? false,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NovelDetailScreen(novel: item))),
          onEdit: () async {
            final edit = await Navigator.push<Map<String, dynamic>>(context, MaterialPageRoute(builder: (_) => AddEditLogScreen(novelToEdit: item)));
            if (edit != null) {
              setState(() {
                final idx = _allLogs.indexWhere((e) => e['id'] == item['id']);
                if (idx != -1) {
                  _allLogs[idx] = edit;
                  _news.insert(0, '✏️ Edit: [${edit['titleEnglish']}]');
                }
              });
            }
          },
          onSave: () => setState(() {
            item['isSaved'] = !(item['isSaved'] as bool? ?? false);
            _news.insert(0, item['isSaved'] == true ? '🔖 Bookmark: [${item['titleEnglish']}]' : '🗑️ Unbookmark');
          }),
          onDelete: () => setState(() {
            _allLogs.removeWhere((e) => e['id'] == item['id']);
            _news.insert(0, '❌ Hapus: [${item['titleEnglish']}]');
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    final filtered = _allLogs.where((n) {
      final title = (n['titleEnglish'] ?? '').toString().toLowerCase();
      final orig = (n['titleOriginal'] ?? '').toString();
      final author = (n['author'] ?? '').toString().toLowerCase();
      final q = _searchQuery.toLowerCase();
      if (!title.contains(q) && !orig.contains(q) && !author.contains(q)) return false;
      if (_activeFilter == 'All') return true;
      final rating = (n['ratingValue'] as num?)?.toDouble() ?? 0.0;
      if (_activeFilter.contains('Stars')) {
        final val = double.tryParse(_activeFilter.split(' ')[0]) ?? double.tryParse(_activeFilter.split('+')[0]) ?? 0.0;
        return _activeFilter.contains('+') ? rating >= val : rating == val;
      }
      return n['status'] == _activeFilter;
    }).toList();

    final controlPanel = ControlPanelWidget(
      searchQuery: _searchQuery,
      onSearchChanged: (q) => setState(() => _searchQuery = q),
      isFilterVisible: _isFilterVisible,
      onToggleFilter: () => setState(() => _isFilterVisible = !_isFilterVisible),
      selectedCategory: _selectedCat,
      selectedSubFilter: _subFilter,
      onCategorySelected: (c) => setState(() {
        _selectedCat = c;
        _subFilter = 'All';
      }),
      onSubFilterSelected: (s) => setState(() => _subFilter = s),
      onApplyFilter: () => setState(() => _activeFilter = _subFilter),
      onClearFilter: _resetFilters,
      newsUpdates: _news,
      activeFilter: _activeFilter,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Novel Vault Tracker'),
        centerTitle: true,
        actions: [IconButton(icon: const Icon(Icons.add), tooltip: 'Tambah Log Novel', onPressed: _addLog)],
      ),
      floatingActionButton: MediaQuery.of(context).size.width >= 600
          ? null
          : FloatingActionButton.extended(onPressed: _addLog, icon: const Icon(Icons.add), label: const Text('Tambah Log')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth >= 600;
            if (isTablet) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 280,
                      child: SingleChildScrollView(child: controlPanel),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tracked Novels (${filtered.length})', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Expanded(child: _buildList(filtered)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Column(
              children: [
                Padding(padding: const EdgeInsets.all(12.0), child: controlPanel),
                Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12.0), child: _buildList(filtered))),
              ],
            );
          },
        ),
      ),
    );
  }
}