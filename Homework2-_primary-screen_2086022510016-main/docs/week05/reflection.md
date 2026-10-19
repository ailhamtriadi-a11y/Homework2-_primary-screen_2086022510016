# AFL 1: Architecture & Structural Reflection

 1. Which structural decision from Week 1 helped you most by Week 5?
Pengambilan keputusan terbaik yang ada untuk dapat membantu menyelesaikan masalah yang ada dengan cara yaitu penerapan "Layered Structure" yang dimana ini berguna untuk dapat memisahkan kode secara ketat ke dalam direktori yang berbeda yang membuat tidak hanya memunuhi keinginan dari tugas yang dikerjakan tetapi ketika terdapat kesalahan dapat lebih mudah untuk diselesaikan atau proses debugging layout agar bisa dapat responsif di berbagai perangkat elektronik

 2. Which one cost you time, and what would you do differently?
Keputusan yang memakan banyak waktu adalah penggunaan cara membuat layout yang responsif dikarenakan setiap perangkat elektronik memiliki beragam layout yang dimana sulit buat dapat menyenangkan semuanya jadi solusi yang ditawarkan itu dibagian UI saya memasang satu lagi tempat buat memasang tempat pembuatan novel jadi semisal masih ada aplikasi yang memiliki UI bermasalah , saya tinggal menghapus bagian yang ada agar tampilan layout tetap rapi

 3. Where is your app's state right now, and what will be hard about moving it in Module 2?
Saat ini memory yang ada tersimpan di local sehingga hanya tersimpan sementara yang dikendalikan stateful widget

materi selanjutnya "Data Layer: Giving the App a Memory" :

1. Dapat Mengganti generator data memory dengan penyimpanan permanen seperti SQLite agar data log novel dapat selalu tersimpan walaupun aplikasi ditutup atau di-restart ulang
2. Mengubah struktur Map dinamis  menjadi  "strongly-typed"  yang dapat dilegkapi dengan metode seperti "fromJson" dan    "toJson" agar dapat compatible dengan database yang bakal dibuat
3. Memindahkan  logika dari seperti tambah, edit, hapus, ataupun bookmark , Dapat keluar dari widget UI yang ada ke    Data Source,  sehingga UI Layer hanya menampilan  data yang ada sehingga dapat lebih rapi