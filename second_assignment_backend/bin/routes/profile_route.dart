import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../handlers/home_handlers/edit_profile_handler.dart';
import '../handlers/home_handlers/delete_account_handler.dart';
import '../handlers/home_handlers/view_profilehandler.dart';

class ProfileRoutes {
  Handler get route {
    final appRoute = Router();
    appRoute
      ..get('/', (Request req) {
        return Response.ok('profile Routes');
      })
      ..post('/edit-profile', editProfileHandler)
      ..get('/view_profile', viewProfileHandler)
      ..delete('/delete-account', deleteHandler);

    final pipline = Pipeline().addMiddleware(checkToken()).addHandler(appRoute);
    return pipline;
  }
}

Middleware checkToken() => (innerHandler) => (Request req) {
      File tokenFile = File('token.txt');

      final headers = req.headers;
      if (headers['token'] == tokenFile.readAsLinesSync()[0]) {
        return innerHandler(req);
      }
      return Response.unauthorized("Sorry your token is wrong");
    };
