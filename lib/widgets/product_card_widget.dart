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
    Key? key,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Row(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    color: Colors.blueGrey[100],
                    child: Center(
                      child: Text(
                        imagePlaceholder,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        Text('By: $artist', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        if (location != null)
                          Text('📍 $location', style: const TextStyle(color: Colors.grey, fontSize: 11)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 14),
                            Text(' $rating', style: const TextStyle(fontSize: 12)),
                            const SizedBox(width: 12),
                            Text(price, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 16),

            // Tombol Batalkan, Simpan, dan Beli dengan Counter Pembelian
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onCancel,
                  child: const Text('Batalkan', style: TextStyle(color: Colors.red, fontSize: 12)),
                ),
                TextButton(
                  onPressed: onSave,
                  child: Text(
                    isSaved ? 'Tersimpan ❤️' : 'Simpan',
                    style: TextStyle(
                      color: isSaved ? Colors.purple : Colors.blue,
                      fontWeight: isSaved ? FontWeight.bold : FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (buyCount > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        margin: const EdgeInsets.only(bottom: 2),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Terbeli ${buyCount}x',
                          style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                      ),
                    ElevatedButton(
                      onPressed: onBuy,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      child: const Text('Beli', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}