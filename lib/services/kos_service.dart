
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/kos_model.dart';

class KosService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<List<KosModel>> getKosList() async {
    final response = await supabase
        .from('kos_listings')
        .select()
        .eq('tersedia', true)
        .order('created_at', ascending: false);

    return (response as List)
        .map((item) => KosModel.fromJson(item))
        .toList();
  }

  Future<void> addKos(KosModel kos) async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('Silakan login terlebih dahulu');
    }

    await supabase.from('kos_listings').insert({
      ...kos.toJson(),
      'owner_id': user.id,
    });
  }
}
