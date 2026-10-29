# Course Explorer — Flutter

Project praktikum Pemrograman Mobile (PEMOB) menggunakan Flutter untuk mengelola data mata kuliah dengan backend Supabase.

## Identitas Mahasiswa

- **NIM:** 2415051078
- **Nama:** Komang Widyasari Devi

## Deskripsi Aplikasi

Course Explorer adalah aplikasi Flutter untuk menampilkan dan mengelola data mata kuliah. Aplikasi menerapkan pemisahan tanggung jawab antara antarmuka pengguna, pengelolaan state, repository, dan layanan sumber data.

Aplikasi terintegrasi dengan Supabase sebagai backend untuk membaca dan mengelola data mata kuliah.

## Fitur

- Menampilkan daftar mata kuliah.
- Membaca data mata kuliah dari Supabase.
- Menambahkan data mata kuliah.
- Memperbarui dan menghapus data mata kuliah sesuai implementasi service.
- Mengelola state menggunakan Provider dan ChangeNotifier.
- Menampilkan status loading dan menangani error.
- Mengelola data favorit.
- Menggunakan navigasi responsif untuk perangkat mobile dan layar lebih lebar.
- Memisahkan UI, state management, repository, dan service.

## Teknologi

- Flutter dan Dart
- Material Design 3
- Provider untuk state management
- Supabase untuk backend dan database PostgreSQL
- Git dan GitHub untuk version control

## Arsitektur Aplikasi

Struktur folder utama:

- `lib/models/`: model data mata kuliah dan pemetaan JSON.
- `lib/services/`: implementasi akses sumber data, termasuk Supabase.
- `lib/repositories/`: abstraksi akses data antara Provider dan service.
- `lib/providers/`: pengelolaan state, data mata kuliah, loading, error, dan favorit.
- `lib/screens/`: halaman aplikasi dan navigasi.
- `lib/widgets/`: komponen antarmuka yang dapat digunakan kembali.

### Alur Dependency

`Screens/Widgets → Provider → Repository → Service/Data Source`

UI tidak mengakses backend secara langsung. Provider mengelola state aplikasi, Repository menjadi perantara akses data, dan Service menangani komunikasi dengan sumber data.

## Backend dan Database

Backend menggunakan Supabase dengan tabel `courses` untuk menyimpan data mata kuliah.

Data yang dikelola mencakup kode mata kuliah, judul, jumlah SKS, dan status. Atribut tambahan seperti kategori digunakan apabila tersedia pada model dan skema database.

Konfigurasi koneksi Supabase dikelola melalui file konfigurasi aplikasi. Gunakan URL project dan anon/publishable key yang sesuai. Jangan memasukkan `service_role` key atau secret backend ke dalam source code yang dipublikasikan.

## Cara Menjalankan Aplikasi

### Prasyarat

- Flutter SDK telah terpasang.
- Android emulator atau perangkat yang mendukung Flutter tersedia.
- Project Supabase telah disiapkan dan tabel `courses` tersedia.

### Langkah Menjalankan

1. Clone repository:

   ```bash
   git clone https://github.com/widyasaridevi-code/flutter_ui_fundamentals.git
   ```

2. Masuk ke folder project:

   ```bash
   cd flutter_ui_fundamentals
   ```

3. Instal dependency:

   ```bash
   flutter pub get
   ```

4. Pastikan konfigurasi Supabase tersedia dan sesuai dengan project yang digunakan.

5. Jalankan pemeriksaan kode:

   ```bash
   flutter analyze
   ```

6. Jalankan aplikasi:

   ```bash
   flutter run
   ```

## Version Control

Pengembangan aplikasi dicatat menggunakan Git dengan commit terpisah untuk tahapan praktikum. Repository sumber tersedia di:

https://github.com/widyasaridevi-code/flutter_ui_fundamentals

## Catatan Keamanan

- Jangan commit password, token rahasia, atau Supabase `service_role` key.
- Atur Row Level Security (RLS) dan policy database sesuai kebutuhan aplikasi.
- Gunakan key yang memang diperuntukkan bagi aplikasi klien.

## Penutup

Project ini merupakan hasil praktikum Flutter yang mencakup pembuatan UI, pengelolaan state, pemisahan arsitektur, integrasi backend, serta penggunaan Git dan GitHub.

**Mahasiswa:** Komang Widyasari Devi  
**NIM:** 2415051078
