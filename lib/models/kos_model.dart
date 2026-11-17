
class KosModel {
  final int? id;
  final String? ownerId;
  final String namaKos;
  final String alamat;
  final int harga;
  final String deskripsi;
  final List<String> fasilitas;
  final bool tersedia;

  const KosModel({
    this.id,
    this.ownerId,
    required this.namaKos,
    required this.alamat,
    required this.harga,
    this.deskripsi = '',
    this.fasilitas = const [],
    this.tersedia = true,
  });

  factory KosModel.fromJson(Map<String, dynamic> json) {
    return KosModel(
      id: json['id'] as int?,
      ownerId: json['owner_id'] as String?,
      namaKos: json['nama_kos'] as String,
      alamat: json['alamat'] as String,
      harga: json['harga'] as int,
      deskripsi: json['deskripsi'] as String? ?? '',
      fasilitas: List<String>.from(json['fasilitas'] ?? []),
      tersedia: json['tersedia'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'owner_id': ownerId,
      'nama_kos': namaKos,
      'alamat': alamat,
      'harga': harga,
      'deskripsi': deskripsi,
      'fasilitas': fasilitas,
      'tersedia': tersedia,
    };
  }
}
