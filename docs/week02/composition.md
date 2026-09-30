1. NewsBannerWidget
a. Trigger : Readability
b. What it Owns:
- Properti visual untuk header promo, termasuk judul dan subjudul.
- Struktur tata letak keseluruhan dari banner promo.
c. Reports upward:
- Tidak ada (komponen ini statis dan tidak memiliki interaksi).

2. SearchBarWidget
a. Trigger : Readability & Reuse
b. What it Owns:
- Pengaturan gaya untuk TextField pencarian beserta ikon dekoratifnya.
c. Reports upward:
- Mengirimkan teks pencarian ke primary_screen.dart melalui callback onSearchChanged(String query).

3. FilterPanelWidget
a. Trigger : Readability
b. What it Owns:
- Daftar opsi kategori filter dalam bentuk data Map.
- Komponen visual ChoiceChip untuk menampilkan kategori utama dan sub-filter.
c. Reports upward:
- Mengirim kategori yang dipilih dengan onCategorySelected(String category).
- Mengirim sub-filter yang dipilih dengan onSubFilterSelected(String subFilter).
- Memicu tindakan konfirmasi dengan onApplyFilter().
- Memicu tindakan pengaturan ulang dengan onClearFilter().

4. ProductCardWidget
a. Trigger : Reuse
b. What it Owns:
- Kerangka tata letak untuk satu item produk, mencakup gambar placeholder, judul, artis, harga, rating, dan tombol aksi.
c. Reports upward:
- Menjalankan onTap() saat kartu produk diklik.
- Menjalankan onBuy() ketika tombol beli ditekan.
- Menjalankan onSave() ketika ikon favorit ditekan.
- Menjalankan onErase() saat tombol hapus ditekan.