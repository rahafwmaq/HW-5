import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import '../../configuration/supabase.dart';
import '../../helper/check_body.dart';

editProfileHandler(Request req) async {
  try {
    final Map body = json.decode(await req.readAsString());
    File userIDFile = File('user_id.txt');
    List<String> keyNames = ['email', 'name', 'user_id', 'bio'];
    userIDFile.writeAsString(body['user_id']);
    checkBody(keysCheck: keyNames, body: body);
    final supabse = SupabaseIntegration.instant;
    await supabse
        ?.from('profile')
        .insert({'bio': body['bio'], 'user_id': body['user_id']});
    await supabse
        ?.from('users')
        .update({'email': body['email'], 'name': body['name']}).eq(
            'id', body['user_id']);
    return Response.ok(
        json.encode({
          'message': 'you have add your bio in your profile SUCCESSFULLY',
        }),
        headers: {'Content-Type': 'application/json'});
  } on FormatException catch (error) {
    return Response.badRequest(body: error.message);
  } catch (error) {
    return Response.badRequest(body: error.toString());
  }
}
