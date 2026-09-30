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
    _allProducts = <Map<String, dynamic>>[];
    mockProducts.map((item) => Map<String, dynamic>.from(item)).toList()
        .forEach((item) => _allProducts.add(item));
}

  void _showProductDetailDialog(Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(product['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.orange[100],
                  child: Center(
                    child: Text(
                      '🖼️ ${product['imagePlaceholder']}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text('Foto Alternatif Karya:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                const SizedBox(height: 6),
                Row(
                  children: (product['altImages'] as List<String>).map((alt) {
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 4),
                        padding: const EdgeInsets.all(6),
                        color: Colors.grey[200],
                        child: Text(alt, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10)),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('🎨 Artis: ${product['artist']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('📞 Kontak/WA: ${product['contact']}', style: const TextStyle(fontSize: 12, color: Colors.blue)),
                      if (product['location'] != null)
                        Text('📍 Lokasi Galeri: ${product['location']}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    Text(' ${product['ratingValue']} (${product['reviews']})', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                const Text('Varian Warna/Pilihan:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                Text((product['colors'] as List<String>).join(', '), style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 8),
                Text('Harga: ${product['priceTag']}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.orange[400],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 16),

            if (_isFilterVisible) ...[
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
                  setState(() {
                    _selectedCategory = 'All';
                    _tempSubFilter = 'All';
                    _activeFilter = 'All';
                    _searchQuery = '';
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Filter dibersihkan!')),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],

            NewsBannerWidget(
              title: 'Art Updates',
              subtitle: 'Berita & status terbaru karya favoritmu',
              updates: _newsUpdates,
              activeFilter: _activeFilter,
            ),
            const SizedBox(height: 20),

            Text(
              'Featured Art Works (${filteredProducts.length})',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            filteredProducts.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text('Karya seni tidak ditemukan.'),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final item = filteredProducts[index];
                      return ProductCardWidget(
                        title: item['title'] as String,
                        artist: item['artist'] as String,
                        price: item['priceTag'] as String,
                        rating: item['ratingValue'] as double,
                        location: item['location'] as String?,
                        imagePlaceholder: item['imagePlaceholder'] as String,
                        buyCount: item['buyCount'] as int,
                        isSaved: item['isSaved'] as bool,
                        onTap: () => _showProductDetailDialog(item),
                        onBuy: () {
                          setState(() {
                            item['buyCount'] = (item['buyCount'] as int) + 1;
                            _newsUpdates.insert(
                              0,
                              '🛒 Pembelian karya [${item['title']}] berhasil! (Total: ${item['buyCount']}x dibeli)',
                            );
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
                            _newsUpdates.insert(0, '❌ Membatalkan pesanan/simpanan [${item['title']}]');
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Transaksi/Simpanan "${item['title']}" dibatalkan.')),
                          );
                        },
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}