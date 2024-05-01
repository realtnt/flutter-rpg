import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/screens/profile/heart.dart';
import 'package:flutter_rpg/screens/profile/skill_list.dart';
import 'package:flutter_rpg/screens/profile/stats_table.dart';
import 'package:flutter_rpg/services/character_store.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:provider/provider.dart';

const imageBasePath = 'assets/img/';
const vocationsImagePath = '${imageBasePath}vocations/';
const skillsImagePath = '${imageBasePath}skills/';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.character});

  final Character character;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StyledTitle(widget.character.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: AppColors.secondaryColor.withOpacity(0.3),
                  child: Row(
                    children: [
                      Hero(
                        tag: widget.character.id,
                        child: Image.asset(
                          '$vocationsImagePath${widget.character.vocation.image}',
                          width: 140,
                          height: 140,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StyledHeading(widget.character.vocation.title),
                            StyledText(widget.character.vocation.description),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 10,
                  child: Heart(widget.character),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Icon(Icons.code, color: AppColors.primaryColor),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: AppColors.secondaryColor.withOpacity(0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StyledHeading('Slogan'),
                    StyledText(widget.character.slogan),
                    const SizedBox(height: 10),
                    const StyledHeading('Weapon of choice'),
                    StyledText(widget.character.vocation.weapon),
                    const SizedBox(height: 10),
                    const StyledHeading('Unique ability'),
                    StyledText(widget.character.vocation.ability),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                StatsTable(widget.character),
                SkillList(widget.character),
              ],
            ),
            StyledButton(
              onPressed: () {
                Provider.of<CharacterStore>(context, listen: false)
                    .saveCharacter(widget.character);
                return ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const StyledHeading('Character saved'),
                    showCloseIcon: true,
                    duration: const Duration(seconds: 2),
                    backgroundColor: AppColors.secondaryColor,
                  ),
                );
              },
              child: const StyledHeading('Save Character'),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
