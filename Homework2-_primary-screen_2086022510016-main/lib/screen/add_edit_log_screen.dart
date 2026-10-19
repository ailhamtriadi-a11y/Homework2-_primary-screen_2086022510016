// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddEditLogScreen extends StatefulWidget {
  final Map<String, dynamic>? novelToEdit;
  const AddEditLogScreen({super.key, this.novelToEdit});

  @override
  State<AddEditLogScreen> createState() => _AddEditLogScreenState();
}

class _AddEditLogScreenState extends State<AddEditLogScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleEng, _titleOrig, _author, _chapter, _rating, _mcName, _mcAbilities, _lore;
  String _selectedStatus = 'Reading';
  String _selectedFileName = '';
  String _imageDataUrl = '';
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final item = widget.novelToEdit;
    final mc = (item?['mcCharacteristics'] as Map<String, dynamic>?) ?? {};
    final loreList = (item?['worldLoreHistory'] as List<dynamic>?) ?? [];
    final latestLore = loreList.isNotEmpty ? (loreList.last as Map<String, dynamic>) : {};

    _titleEng = TextEditingController(text: item?['titleEnglish'] ?? '');
    _titleOrig = TextEditingController(text: item?['titleOriginal'] ?? '');
    _author = TextEditingController(text: item?['author'] ?? '');
    _chapter = TextEditingController(text: item != null ? '${item['currentChapter'] ?? 1}' : '1');
    _rating = TextEditingController(text: item != null ? '${item['ratingValue'] ?? 4.5}' : '4.5');
    _mcName = TextEditingController(text: mc['name'] ?? '');
    _mcAbilities = TextEditingController(text: mc['abilities'] ?? '');
    _lore = TextEditingController(text: latestLore['lore'] ?? '');
    _imageDataUrl = item?['imageUrl'] ?? '';
    if (item != null && item['status'] != null) {
      _selectedStatus = item['status'] as String;
    }
  }

  @override
  void dispose() {
    for (var c in [_titleEng, _titleOrig, _author, _chapter, _rating, _mcName, _mcAbilities, _lore]) {
      c.dispose();
    }
    super.dispose();
  }

  // Fungsi ambil gambar khusus Android (Pakai image_picker)
  Future<void> _pickRealLocalFile() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await File(image.path).readAsBytes();
      final base64String = base64Encode(bytes);
      
      setState(() {
        _selectedFileName = image.name;
        _imageDataUrl = 'data:image/png;base64,$base64String';
      });
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final title = _titleEng.text.trim();
      final placeholder = title.length >= 3 ? title.substring(0, 3).toUpperCase() : 'NVL';

      Navigator.pop(context, {
        'id': widget.novelToEdit?['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
        'titleEnglish': title,
        'titleOriginal': _titleOrig.text.trim(),
        'author': _author.text.trim(),
        'status': _selectedStatus,
        'currentChapter': int.tryParse(_chapter.text) ?? 1,
        'ratingValue': double.tryParse(_rating.text) ?? 4.0,
        'imagePlaceholder': placeholder,
        'imageUrl': _imageDataUrl,
        'isSaved': widget.novelToEdit?['isSaved'] ?? false,
        'mcCharacteristics': {
          'name': _mcName.text.trim().isEmpty ? '-' : _mcName.text.trim(),
          'personality': '-',
          'abilities': _mcAbilities.text.trim().isEmpty ? '-' : _mcAbilities.text.trim(),
        },
        'worldLoreHistory': [
          {'version': 'v1.0', 'lore': _lore.text.trim().isEmpty ? '-' : _lore.text.trim()}
        ],
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.novelToEdit != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Log' : 'Tambah Log'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(controller: _titleEng, decoration: const InputDecoration(labelText: 'Judul Inggris *', border: OutlineInputBorder()), validator: (v) => v!.isEmpty ? 'Wajib diisi' : null),
              const SizedBox(height: 10),
              TextFormField(controller: _titleOrig, decoration: const InputDecoration(labelText: 'Judul Asli *', border: OutlineInputBorder()), validator: (v) => v!.isEmpty ? 'Wajib diisi' : null),
              const SizedBox(height: 10),
              TextFormField(controller: _author, decoration: const InputDecoration(labelText: 'Penulis *', border: OutlineInputBorder()), validator: (v) => v!.isEmpty ? 'Wajib diisi' : null),
              const SizedBox(height: 10),
              Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: _pickRealLocalFile,
                        icon: const Icon(Icons.upload_file),
                        label: const Text('Pilih File Gambar Asli'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: Text(_selectedFileName.isEmpty ? 'Belum ada file' : _selectedFileName, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12))),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                decoration: const InputDecoration(labelText: 'Status', border: OutlineInputBorder()),
                items: ['Reading', 'Completed', 'Plan to Read', 'Dropped'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                onChanged: (v) => setState(() => _selectedStatus = v!),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: TextFormField(controller: _chapter, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Chapter', border: OutlineInputBorder()))),
                  const SizedBox(width: 10),
                  Expanded(child: TextFormField(controller: _rating, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Rating', border: OutlineInputBorder()))),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(controller: _mcName, decoration: const InputDecoration(labelText: 'Nama MC', border: OutlineInputBorder())),
              const SizedBox(height: 10),
              TextFormField(controller: _mcAbilities, decoration: const InputDecoration(labelText: 'Kemampuan MC', border: OutlineInputBorder())),
              const SizedBox(height: 10),
              TextFormField(controller: _lore, maxLines: 2, decoration: const InputDecoration(labelText: 'Setting & Lore', border: OutlineInputBorder())),
              const SizedBox(height: 20),
              FilledButton.icon(onPressed: _saveForm, icon: const Icon(Icons.save), label: Text(isEdit ? 'Simpan' : 'Tambah Log')),
            ],
          ),
        ),
      ),
    );
  }
}