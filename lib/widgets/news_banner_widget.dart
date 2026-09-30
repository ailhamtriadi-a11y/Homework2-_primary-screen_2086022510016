import 'package:flutter/material.dart';

class NewsBannerWidget extends StatelessWidget {
  final List<String> updates;
  final String activeFilter;

  const NewsBannerWidget({
    Key? key,
    required this.updates,
    required this.activeFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.newspaper, color: Colors.blue, size: 18),
              const SizedBox(width: 6),
              const Text('News & Order Status Updates',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.blue)),
              const Spacer(),
              if (activeFilter != 'All')
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: Colors.orange[200], borderRadius: BorderRadius.circular(4)),
                  child: Text('Filter: $activeFilter', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
          const Divider(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: updates.map((update) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  update,
                  style: const TextStyle(fontSize: 11, color: Colors.black87),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}