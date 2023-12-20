import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../handlers/auth_handlers/login_handler.dart';
import '../handlers/auth_handlers/create_account_handler.dart';

class AuthRoutes {
  Handler get route {
    final appRoute = Router();
    appRoute
      ..get('/', (Request req) {
        return Response.ok('Auth Routes');
      })
      ..post('/create-account', createAccountHandler)
      ..post('/login', loginHandler);

    return appRoute;
  }
}
