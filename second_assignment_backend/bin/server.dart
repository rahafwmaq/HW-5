import 'dart:io';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'package:test/test.dart';

import 'configuration/supabase.dart';
import 'routes/main_route.dart';

void main() async {
  withHotreload(() => createSrever(),
      onReloaded: () => prints(''),
      onHotReloadNotAvailable: () => prints(''),
      onHotReloadAvailable: () => prints(''),
      onHotReloadLog: (log) => prints(''),
      logLevel: Level.INFO);
}

Future<HttpServer> createSrever() async {
  SupabaseIntegration().supabase;
  final ip = InternetAddress.anyIPv4;
  final port = int.parse(Platform.environment["PORT"] ?? "8080");
  final server = await serve((MainRoutes().route), ip, port);
  print("http://${server.address.host}:${server.port}");

  return server;
}
