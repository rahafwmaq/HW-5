import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../configuration/supabase.dart';
import '../../helper/check_body.dart';

loginHandler(Request req) async {
  try {
    //--------------------------------------------------
    final body = json.decode(await req.readAsString());
    List<String> keysNames = ['email', 'password'];
    File tokenFile = File('token.txt');
    File userUIDFile = File('user_uid.txt');
    //--------------------------------------------------
    checkBody(keysCheck: keysNames, body: body);
    final supabase = SupabaseIntegration.instant;
    AuthResponse? user;
    //---------------------------------------------------
    user = await supabase?.auth
        .signInWithPassword(password: body['password'], email: body['email']);
    //---------------------------------------------------
    final String? token = user!.session?.accessToken;
    tokenFile.writeAsString(token!);
    userUIDFile.writeAsString(user.user!.id);
    //---------------------------------------------------
    final userInfo =
        await supabase?.from('users').select('id').eq('email', body['email']);
    print(userInfo);
    return Response.ok(
        json.encode({
          'message': 'your login goes SUCCESSFULLY',
          'token': user.session?.accessToken,
          'refresh_token': user.session?.refreshToken,
          'user_id': userInfo![0]
        }),
        headers: {'Content-Type': 'application/json'});
    //---------------------------------------------------
  } on FormatException catch (error) {
    return Response.badRequest(body: error.message);
  } catch (error) {
    throw Response.badRequest(body: error.toString());
  }
}
