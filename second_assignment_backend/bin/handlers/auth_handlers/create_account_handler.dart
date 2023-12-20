import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../configuration/supabase.dart';
import '../../helper/check_body.dart';

createAccountHandler(Request req) async {
  try {
    final Map body = json.decode(await req.readAsString());

    List<String> keyNames = ['email', 'password', 'name'];

    checkBody(keysCheck: keyNames, body: body);

    final supabse = SupabaseIntegration.instant;

    AuthResponse? user;

    await supabse!.auth.admin
        .createUser(AdminUserAttributes(
            email: body['email'],
            password: body['password'],
            emailConfirm: true))
        .then((value) async {
      try {
        user = await supabse.auth.signInWithPassword(
            password: body['password'], email: body['email']);

        body.remove('password');

        await supabse.from('users').insert(body);
      } catch (error) {
        throw FormatException(error.toString());
      }
    });

    return Response.ok(
        json.encode({
          'message': 'your account have been created  SUCCESSFULLY',
          'email': body['email'],
          'name': body['name'],
          'token': user!.session?.accessToken,
          'refresh_token': user!.session?.refreshToken
        }),
        headers: {'Content-Type': 'application/json'});
  } on FormatException catch (error) {
    return Response.badRequest(body: error.message);
  } on AuthException catch (error) {
    return Response.badRequest(body: error.message);
  } on PostgrestException catch (error) {
    String msgError = '';
    if (error.code == 'PGRST204') {
      msgError = 'there is error with password';
    }
    return Response.badRequest(body: msgError);
  } catch (error) {
    return Response.badRequest(body: error.toString());
  }
}
