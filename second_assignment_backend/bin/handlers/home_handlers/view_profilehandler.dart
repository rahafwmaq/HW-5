import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';

import '../../configuration/supabase.dart';

viewProfileHandler(Request req) async {
  try {
    final supabase = SupabaseIntegration.instant;
    File userIDFile = File('user_id.txt');
    final userID = userIDFile.readAsLinesSync()[0];
    final profile =
        await supabase?.from('profile').select().eq('user_id', userID);
    final userInfo = await supabase?.from('users').select().eq('id', userID);
    print(profile);
    print(userInfo);

    return Response.ok(
        json.encode({
          "email": userInfo?[0]['email'],
          "name": userInfo?[0]['name'],
          "bio": profile?[0]['bio']
        }),
        headers: {'Content-Type': 'application/json'});
  } catch (error) {
    return Response.badRequest(body: error.toString());
  }
}
