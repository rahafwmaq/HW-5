import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../configuration/supabase.dart';

deleteHandler(Request request) async {
  try {
    final supabase = SupabaseIntegration.instant;
    File userUIDFile = File('user_uid.txt');
    final userUID = userUIDFile.readAsLinesSync()[0];

    File userIDFile = File('user_id.txt');
    final userID = userIDFile.readAsLinesSync()[0];
    await supabase?.from('profile').delete().eq('user_id', userID);
    await supabase?.from('users').delete().eq('id', userID);
    await supabase?.auth.admin.deleteUser(userUID);

    return Response.ok("The user has been DELETED");
  } on PostgrestException catch (error) {
    String msgError = '';
    if (error.code == '42703') {
      msgError = 'the id does not exist';
    }
    return Response.badRequest(body: msgError);
  } on AuthException catch (error) {
    return Response.badRequest(body: error.message);
  } catch (error) {
    return Response.badRequest(body: error.toString());
  }
}
