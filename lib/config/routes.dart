import 'package:examen_flutter/routes/favorites_page.dart';
import 'package:examen_flutter/routes/home_page.dart';
import 'package:examen_flutter/routes/pet_profile.dart';
import 'package:go_router/go_router.dart';

final routerConfig = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: "/pet/:id",
      builder: (context, state) => PetProfile(
        petId: int.parse(state.params["id"]!),
      ),
    ),
    GoRoute(
      path: "/favorites",
      builder: (context, state) => const FavoritesPage(),
    ),
  ],
);
