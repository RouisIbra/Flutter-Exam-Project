import 'package:examen_flutter/provider/pets_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton({super.key, required this.petId});

  final int petId;

  _addPetToFavorite(BuildContext context) {
    Provider.of<PetsProvider>(context, listen: false).addPetToFavorites(petId);
  }

  _removeFromFavorites(BuildContext context) {
    Provider.of<PetsProvider>(context, listen: false)
        .removePetFromFavorites(petId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PetsProvider>(
      builder: (context, petsProvider, child) => IconButton(
        onPressed: petsProvider.isPetAlreadyFavorite(petId)
            ? () => _removeFromFavorites(context)
            : () => _addPetToFavorite(context),
        icon: Icon(
          petsProvider.isPetAlreadyFavorite(petId)
              ? Icons.favorite
              : Icons.favorite_border,
          color: Colors.red,
          size: 30,
        ),
      ),
    );
  }
}
