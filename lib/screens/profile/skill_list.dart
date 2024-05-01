import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/models/skills.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';

const imageBasePath = 'assets/img/';
const skillsImagePath = '${imageBasePath}skills/';

class SkillList extends StatefulWidget {
  const SkillList(this.character, {super.key});

  final Character character;

  @override
  State<SkillList> createState() => _SkillListState();
}

class _SkillListState extends State<SkillList> {
  late List<Skill> availableSkills;
  late Skill selectedSkill;

  @override
  void initState() {
    availableSkills = getSkillsFor(widget.character.vocation);
    if (widget.character.skills.isEmpty) {
      selectedSkill = availableSkills.first;
    } else {
      selectedSkill = widget.character.skills.first;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        color: AppColors.secondaryColor.withOpacity(0.5),
        child: Column(
          children: [
            const StyledHeading('Choose an active skill.'),
            const StyledText('Skills are unique to your vocation.'),
            const SizedBox(height: 20),
            Row(
              children: availableSkills.map(
                (skill) {
                  return Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(2),
                    color: skill == selectedSkill
                        ? Colors.yellow
                        : Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            widget.character.updateSkill(skill);
                            selectedSkill = skill;
                          },
                        );
                      },
                      child: Image.asset(
                        '$skillsImagePath${skill.image}',
                        width: 68,
                        colorBlendMode: BlendMode.color,
                        color: selectedSkill == skill
                            ? Colors.transparent
                            : Colors.black.withOpacity(0.8),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
