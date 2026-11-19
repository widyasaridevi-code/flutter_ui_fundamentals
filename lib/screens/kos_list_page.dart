
import 'package:flutter/material.dart';
import '../models/kos_model.dart';
import '../services/kos_service.dart';
import '../services/profile_service.dart';
import 'add_kos_page.dart';

class KosListPage extends StatefulWidget {
  const KosListPage({super.key});

  @override
  State<KosListPage> createState() => _KosListPageState();
}

class _KosListPageState extends State<KosListPage> {
  final KosService _kosService = KosService();
  final ProfileService _profileService = ProfileService();

  late Future<List<KosModel>> _kosFuture;
  late Future<UserProfile?> _profileFuture;

  @override
  void initState() {
    super.initState();
    _kosFuture = _kosService.getKosList();
    _profileFuture = _profileService.getMyProfile();
  }

  void _refreshData() {
    setState(() {
      _kosFuture = _kosService.getKosList();
      _profileFuture = _profileService.getMyProfile();
    });
  }

  Future<void> _bukaTambahKos() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddKosPage(),
      ),
    );

    if (!mounted) return;
    _refreshData();
  }

  Future<void> _logout() async {
    try {
      await _kosService.supabase.auth.signOut();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout gagal: $e')),
      );
    }
  }

  String formatHarga(int harga) {
    return 'Rp ${harga.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    )} / bulan';
  }

  String formatRole(String role) {
    switch (role) {
      case 'owner':
        return 'Pemilik Kos';
      case 'admin':
        return 'Admin';
      default:
        return 'Pencari Kos';
    }
  }

  Widget _buildProfile() {
    return FutureBuilder<UserProfile?>(
      future: _profileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: LinearProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Profil tidak dapat dimuat'),
              subtitle: Text('${snapshot.error}'),
            ),
          );
        }

        final profile = snapshot.data;

        if (profile == null) {
          return const Card(
            child: ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('Data profil tidak ditemukan'),
            ),
          );
        }

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.account_circle,
                      color: Color(0xFF4056A1),
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Profil Pengguna',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 24),
                Text('Nama: ${profile.name.isEmpty ? '-' : profile.name}'),
                const SizedBox(height: 8),
                Text('Email: ${profile.email}'),
                const SizedBox(height: 8),
                Text('Role: ${formatRole(profile.role)}'),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KosFinder'),
        backgroundColor: const Color(0xFF4056A1),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _refreshData,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: FutureBuilder<List<KosModel>>(
        future: _kosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Gagal memuat data: ${snapshot.error}'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _refreshData,
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          final kosList = snapshot.data ?? [];

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildProfile(),
              if (kosList.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    children: [
                      Icon(
                        Icons.home_work_outlined,
                        size: 75,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text('Belum ada data kos tersedia.'),
                    ],
                  ),
                )
              else
                ...kosList.map((kos) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.home_work_rounded,
                            size: 45,
                            color: Color(0xFF4056A1),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            kos.namaKos,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(kos.alamat),
                          const SizedBox(height: 8),
                          Text(
                            formatHarga(kos.harga),
                            style: const TextStyle(
                              color: Color(0xFF4056A1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (kos.deskripsi.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text(kos.deskripsi),
                          ],
                          if (kos.fasilitas.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text(
                              'Fasilitas: ${kos.fasilitas.join(', ')}',
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _bukaTambahKos,
        backgroundColor: const Color(0xFF4056A1),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Kos'),
      ),
    );
  }
}
