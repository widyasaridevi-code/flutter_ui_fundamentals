
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl =
      'https://nbbvrdrzhzybiurjirxu.supabase.co';

  static const String supabasePublishableKey =
      'sb_publishable_NgEiXFFIyQbCGkNG_ikkyA_WR33ZQq3';

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      publishableKey: supabasePublishableKey,
    );
  }
}
