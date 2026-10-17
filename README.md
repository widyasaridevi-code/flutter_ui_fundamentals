\# Learning Dashboard Flutter



Project praktikum Widget Flutter Fundamentals.



\## Identitas Mahasiswa



\- NIM: 2415051078

\- Nama: Komang Widyasari Devi



\## Deskripsi



Aplikasi Learning Dashboard menampilkan identitas mahasiswa,

profil, ringkasan materi, dan daftar course dari static JSON.



\## Fitur



\- MaterialApp dan Scaffold

\- Profile mahasiswa

\- Summary card

\- Collection Dart

\- ListView

\- StatefulWidget dan setState

\- Static JSON

\- Future dan async/await

\- FutureBuilder

\- Loading dan error state

\- Reusable widget/function

\- Git version control



\## Data



Data course disimpan pada:



assets/data/student\_data.json



Aplikasi menggunakan data JSON untuk menampilkan daftar mata kuliah,

kode course, jumlah SKS, status, dan kategori.



\## Student



NIM: 2415051078

Nama: Komang Widyasari Devi


## Struktur Folder dan Tanggung Jawab

- `lib/models/`: menyimpan model data, seperti Course, serta parsing JSON ke object.
- `lib/services/`: menangani sumber data, seperti membaca file JSON menggunakan rootBundle.
- `lib/repositories/`: menjadi lapisan abstraksi antara Provider dan Service.
- `lib/providers/`: mengelola shared state, data course, loading, error, dan favorites.
- `lib/screens/`: berisi halaman aplikasi dan navigasi antarlayar.
- `lib/widgets/`: berisi komponen UI yang dapat digunakan kembali.

## Alur Dependency

Screens/Widgets -> Provider -> Repository -> Service/Data Source.

UI tidak membaca JSON secara langsung. Provider mengelola state, Repository menjadi perantara akses data, dan Service menangani detail sumber data.
