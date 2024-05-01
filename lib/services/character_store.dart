import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/services/firestore_service.dart';

class CharacterStore extends ChangeNotifier {
  final List<Character> _characters = [];

  List<Character> get characters => _characters;

  // add character
  void addCharacter(Character character) {
    FirestoreService.addCharacter(character);
    _characters.add(character);
    notifyListeners();
  }

  // save (update) character
  void saveCharacter(Character character) async {
    await FirestoreService.updateCharacter(character);
    _characters.removeWhere((element) => element.id == character.id);
    _characters.add(character);
    notifyListeners();
  }

  // remove character
  void removeCharacter(Character character) async {
    await FirestoreService.deleteCharacter(character);
    _characters.remove(character);
    notifyListeners();
  }

  // initially fetch characters
  void fetchCharacterOnce() async {
    if (_characters.isNotEmpty) return;

    final snapshot = await FirestoreService.getCharactersOnce();
    for (var doc in snapshot.docs) {
      _characters.add(doc.data());
    }
    notifyListeners();
  }
}
