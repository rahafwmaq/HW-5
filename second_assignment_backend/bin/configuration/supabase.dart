import 'package:supabase/supabase.dart';

class SupabaseIntegration {
  static SupabaseClient? instant;

  SupabaseClient? get supabase {
    final supabase = SupabaseClient(
      'https://xtqnjyouyuynkgzekjsy.supabase.co',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh0cW5qeW91eXV5bmtnemVranN5Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwMjk3Mjc2MiwiZXhwIjoyMDE4NTQ4NzYyfQ.3Zi4Q3W1sLwSbdqbOb_uqBgZNZNhl50avOZ9jyltzoo');
    instant = supabase;
    return supabase;
  }
}
