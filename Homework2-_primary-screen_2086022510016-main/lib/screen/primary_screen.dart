import 'package:flutter/material.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/filter_panel_widget.dart';
import '../widgets/product_card_widget.dart';
import '../widgets/news_banner_widget.dart';
import '../data/mock_product.dart';

class PrimaryScreen extends StatefulWidget {
  const PrimaryScreen({super.key});

  @override
  State<PrimaryScreen> createState() => _PrimaryScreenState();
}

class _PrimaryScreenState extends State<PrimaryScreen> {
  late List<Map<String, dynamic>> _allProducts;

  String _searchQuery = '';
  String _selectedCategory = 'All';
  String _tempSubFilter = 'All';
  String _activeFilter = 'All';
  bool _isFilterVisible = false;

  final List<String> _newsUpdates = [
    '📦 Status Paket: [Patung Keramik Custom] dalam perjalanan ke Makassar',
  ];

  @override
  void initState() {
    super.initState();
    _allProducts = getLargeMockProducts(count: 500);
  }

  void _resetFilters() {
    setState(() {
      _selectedCategory = 'All';
      _tempSubFilter = 'All';
      _activeFilter = 'All';
      _searchQuery = '';
    });
  }

void _showProductDetailDialog(Map<String, dynamic> product) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header: Judul & Tombol Silang (X) di Pojok Kanan Atas
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product['title'] as String,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Placeholder Gambar (Tinggi disesuaikan jadi 100 agar hemat ruang)
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        '🖼️ ${product['imagePlaceholder']}',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Foto Alternatif
                  Text('Foto Alternatif Karya:', style: theme.textTheme.labelMedium),
                  const SizedBox(height: 4),
                  Row(
                    children: (product['altImages'] as List<String>).map((alt) {
                      return Expanded(
                        child: Card(
                          elevation: 0,
                          color: theme.colorScheme.surfaceContainerHigh,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
                            child: Text(
                              alt,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.labelSmall,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 8),

                  // Informasi Artis
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.palette),
                    title: Text('Artis: ${product['artist']}'),
                    subtitle: Text('WA: ${product['contact']} • Lokasi: ${product['location'] ?? "N/A"}'),
                  ),

                  // Rating & Varian
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      Text(' ${product['ratingValue']} (${product['reviews']} ulasan)', style: theme.textTheme.bodyMedium),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('Varian: ${(product['colors'] as List<String>).join(', ')}', style: theme.textTheme.bodySmall),
                  const SizedBox(height: 8),

                  // Harga
                  Text(
                    'Harga: ${product['priceTag']}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Tombol Tutup Utama
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.tonal(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Tutup'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 64,
              color: theme.colorScheme.secondary,
            ),
            const SizedBox(height: 12),
            Text(
              'Karya seni tidak ditemukan',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              'Coba ubah kata kunci pencarian atau bersihkan filter.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _resetFilters,
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('Reset Filter'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SearchBarWidget(
          searchQuery: _searchQuery,
          onSearchChanged: (query) {
            setState(() => _searchQuery = query);
          },
          isFilterVisible: _isFilterVisible,
          onStarPressed: () {
            setState(() {
              _isFilterVisible = !_isFilterVisible;
            });
          },
        ),
        if (_isFilterVisible) ...[
          const SizedBox(height: 12),
          FilterPanelWidget(
            selectedCategory: _selectedCategory,
            selectedSubFilter: _tempSubFilter,
            onCategorySelected: (cat) {
              setState(() {
                _selectedCategory = cat;
                _tempSubFilter = 'All';
              });
            },
            onSubFilterSelected: (sub) {
              setState(() => _tempSubFilter = sub);
            },
            onApplyFilter: () {
              setState(() {
                _activeFilter = _tempSubFilter;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Filter "$_activeFilter" diterapkan!')),
              );
            },
            onClearFilter: () {
              _resetFilters();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Filter dibersihkan!')),
              );
            },
          ),
        ],
        const SizedBox(height: 12),
        NewsBannerWidget(
          title: 'Art Updates',
          subtitle: 'Berita & status terbaru karya favoritmu',
          updates: _newsUpdates,
          activeFilter: _activeFilter,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filteredProducts = _allProducts.where((product) {
      final matchesSearch = (product['title'] as String).toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (product['artist'] as String).toLowerCase().contains(_searchQuery.toLowerCase());

      if (!matchesSearch) return false;
      if (_activeFilter == 'All') return true;

      final loc = product['location'] as String?;
      final pay = product['payment'] as String?;
      final promo = product['promo'] as String?;
      final rTag = product['ratingTag'] as String?;

      return loc == _activeFilter || pay == _activeFilter || promo == _activeFilter || rTag == _activeFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Art Marketplace'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Layout Tablet (>= 600dp)
            if (constraints.maxWidth >= 600) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 340,
                      child: SingleChildScrollView(
                        child: _buildControlPanel(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: filteredProducts.isEmpty
                          ? _buildEmptyState(theme)
                          : ListView.builder(
                              itemCount: filteredProducts.length + 1,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: Text(
                                      'Featured Art Works (${filteredProducts.length})',
                                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  );
                                }
                                final item = filteredProducts[index - 1];
                                return ProductCardWidget(
                                  title: item['title'] as String,
                                  artist: item['artist'] as String,
                                  price: item['priceTag'] as String,
                                  rating: (item['ratingValue'] as num).toDouble(),
                                  location: item['location'] as String?,
                                  imagePlaceholder: item['imagePlaceholder'] as String,
                                  buyCount: item['buyCount'] as int,
                                  isSaved: item['isSaved'] as bool,
                                  onTap: () => _showProductDetailDialog(item),
                                  onBuy: () {
                                    setState(() {
                                      item['buyCount'] = (item['buyCount'] as int) + 1;
                                      _newsUpdates.insert(0, '🛒 Pembelian karya [${item['title']}] berhasil!');
                                    });
                                  },
                                  onSave: () {
                                    setState(() {
                                      item['isSaved'] = !(item['isSaved'] as bool);
                                      if (item['isSaved'] as bool) {
                                        _newsUpdates.insert(0, '❤️ Kamu menyimpan karya: [${item['title']}]');
                                      } else {
                                        _newsUpdates.insert(0, '🗑️ Kamu menghapus simpanan karya: [${item['title']}]');
                                      }
                                    });
                                  },
                                  onCancel: () {
                                    setState(() {
                                      if (item['isSaved'] == true) item['isSaved'] = false;
                                      _newsUpdates.insert(0, '❌ Membatalkan pesanan/simpanan [${item['title']}]');
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Transaksi "${item['title']}" dibatalkan.')),
                                    );
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
              );
            }

            // Layout Mobile (< 600dp): Seluruh Layar Bebas Di-scroll
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildControlPanel(),
                  const SizedBox(height: 16),
                  Text(
                    'Featured Art Works (${filteredProducts.length})',
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  if (filteredProducts.isEmpty)
                    _buildEmptyState(theme)
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final item = filteredProducts[index];
                        return ProductCardWidget(
                          title: item['title'] as String,
                          artist: item['artist'] as String,
                          price: item['priceTag'] as String,
                          rating: (item['ratingValue'] as num).toDouble(),
                          location: item['location'] as String?,
                          imagePlaceholder: item['imagePlaceholder'] as String,
                          buyCount: item['buyCount'] as int,
                          isSaved: item['isSaved'] as bool,
                          onTap: () => _showProductDetailDialog(item),
                          onBuy: () {
                            setState(() {
                              item['buyCount'] = (item['buyCount'] as int) + 1;
                              _newsUpdates.insert(0, '🛒 Pembelian karya [${item['title']}] berhasil!');
                            });
                          },
                          onSave: () {
                            setState(() {
                              item['isSaved'] = !(item['isSaved'] as bool);
                              if (item['isSaved'] as bool) {
                                _newsUpdates.insert(0, '❤️ Kamu menyimpan karya: [${item['title']}]');
                              } else {
                                _newsUpdates.insert(0, '🗑️ Kamu menghapus simpanan karya: [${item['title']}]');
                              }
                            });
                          },
                          onCancel: () {
                            setState(() {
                              if (item['isSaved'] == true) item['isSaved'] = false;
                              _newsUpdates.insert(0, '❌ Membatalkan pesanan/simpanan [${item['title']}]');
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Transaksi "${item['title']}" dibatalkan.')),
                            );
                          },
                        );
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}