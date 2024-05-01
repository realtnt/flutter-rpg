import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rpg/models/skills.dart';
import 'package:flutter_rpg/models/stats.dart';
import 'package:flutter_rpg/models/vocation.dart';

class Character with Stats {
  Character({
    required this.name,
    required this.slogan,
    required this.vocation,
    required this.id,
  });

  final Set<Skill> skills = {};
  final Vocation vocation;
  final String name;
  final String slogan;
  final String id;
  bool _isFav = false;

  // getters
  bool get isFav => _isFav;

  void toggleFav() {
    _isFav = !_isFav;
  }

  void updateSkill(Skill skill) {
    skills.clear();
    skills.add(skill);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'slogan': slogan,
      'isFav': _isFav,
      'vocation': vocation.toString(),
      'skills': skills.map((skill) => skill.id).toList(),
      'stats': statsAsMap,
      'points': points
    };
  }

  factory Character.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;

    Character character = Character(
        name: data['name'],
        slogan: data['slogan'],
        vocation:
            Vocation.values.firstWhere((v) => v.toString() == data['vocation']),
        id: snapshot.id);

    for (String id in data['skills']) {
      Skill skill = allSkills.firstWhere((s) => s.id == id);
      character.updateSkill(skill);
    }

    character._isFav = data['isFav'];

    character.setStats(points: data['points'], stats: data['stats']);

    return character;
  }
}
