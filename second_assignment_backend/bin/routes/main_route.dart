import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:content_length_validator/content_length_validator.dart';
import 'package:shelf_rate_limiter/shelf_rate_limiter.dart';
import 'package:shelf_helmet/shelf_helmet.dart';

import 'auth_route.dart';
import 'profile_route.dart';

class MainRoutes {
  Handler get route {
    final appRoutes = Router();
    appRoutes
      ..get("/", (Request req) {
        return Response.ok('Welcome to my SERVER ;)');
      })
      ..mount('/auth', AuthRoutes().route)
      ..mount('/profile', ProfileRoutes().route)
      ..all('/<ignore|.*>', (Request req) {
        return Response.notFound('Sorry your page not found -_-');
      });

    final memoryStorage = MemStorage();
    final rateLimiter = ShelfRateLimiter(
        storage: memoryStorage,
        duration: Duration(seconds: 60),
        maxRequests: 15);

    final pipeline = Pipeline()
        .addMiddleware(rateLimiter.rateLimiter())
        .addMiddleware(helmet())
        .addMiddleware(
          maxContentLengthValidator(
            maxContentLength: 1 * 1024 * 1024,
          ),
        )
        .addHandler(appRoutes);
    return pipeline;
  }
}
