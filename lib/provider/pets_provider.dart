import 'dart:convert';

import 'package:examen_flutter/models/pet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:collection/collection.dart';

class PetsProvider extends ChangeNotifier {
  List<Pet>? _pets;
  List<Pet>? get pets => _pets;

  final List<Pet> _favoritePets = <Pet>[];

  PetsProvider() {
    // get pets list when creating PetsProvider state
    _getPets().then((petsList) {
      _pets = petsList;
      notifyListeners();
    }).onError((error, stackTrace) {
      debugPrint("An error has occured: ${error.toString()}");
      _pets = null;
    });
  }

  // fetch pets data from a json file
  Future<List<Pet>> _getPets() async {
    // load json file
    final String response = await rootBundle.loadString("assets/pets.json");

    // convert json string to an object and convert every item of object to a Pet object
    final List<Pet> petsList = (await jsonDecode(response) as List)
        .map((e) => Pet.fromJson(e))
        .toList();

    return petsList;
  }

  // get favorite pets
  List<Pet> getFavoritePets() => _favoritePets;

  // get pet by id
  Pet? getPetByid(int id) => _pets?.singleWhere((pet) => pet.id == id);

  // check if pet if favortie
  bool isPetAlreadyFavorite(int id) {
    if (_favoritePets.singleWhereOrNull((pet) => pet.id == id) != null) {
      return true;
    } else {
      return false;
    }
  }

  // add pet to favorites
  addPetToFavorites(int id) {
    if (isPetAlreadyFavorite(id)) {
      return;
    }
    final Pet? pet = getPetByid(id);
    if (pet != null) {
      _favoritePets.add(pet);
    }

    notifyListeners();
  }

  // remove pet from favorites
  removePetFromFavorites(int id) {
    if (!isPetAlreadyFavorite(id)) {
      return;
    }

    _favoritePets.removeWhere((pet) => pet.id == id);

    notifyListeners();
  }
}
