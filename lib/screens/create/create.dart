import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/models/vocation.dart';
import 'package:flutter_rpg/screens/create/vocation_card.dart';
import 'package:flutter_rpg/screens/home/home.dart';
import 'package:flutter_rpg/services/character_store.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/shared/styled_textfield.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _nameController = TextEditingController();
  final _sloganController = TextEditingController();

  void checkTextName() {}

  Vocation selectedVocation = Vocation.raider;

  void updateVocation(Vocation vocation) {
    setState(() {
      selectedVocation = vocation;
    });
  }

  void showError({required String title, required String content}) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: StyledHeading(title),
          content: StyledText(content),
          actions: [
            StyledButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const StyledHeading('Close'),
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );
  }

  void handleSubmit() {
    if (_nameController.text.trim().isEmpty) {
      showError(
        title: 'Missing Character Name',
        content: 'Every good RPG character needs a great name.',
      );
      return;
    }
    if (_sloganController.text.trim().isEmpty) {
      showError(
        title: 'Missing Character Slogan',
        content: 'Every good RPG character needs a great slogan.',
      );
      return;
    }

    Provider.of<CharacterStore>(context, listen: false).addCharacter(
      Character(
        name: _nameController.text.trim(),
        slogan: _sloganController.text.trim(),
        vocation: selectedVocation,
        id: uuid.v4(),
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => const Home(),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _sloganController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle('Character Creation'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(child: Icon(Icons.code, color: AppColors.primaryColor)),
              const Center(
                child: StyledHeading('Welcome, new player!'),
              ),
              const Center(
                child: StyledText('Create a name & slogan for your character.'),
              ),
              const SizedBox(height: 30),

              // input for name and slogan
              StyledTextField(
                label: const StyledText('Character name'),
                prefixIcon: const Icon(Icons.person_2),
                controller: _nameController,
              ),
              const SizedBox(height: 20),
              StyledTextField(
                label: const StyledText('Character slogan'),
                prefixIcon: const Icon(Icons.chat),
                controller: _sloganController,
              ),
              const SizedBox(height: 20),

              Center(child: Icon(Icons.code, color: AppColors.primaryColor)),
              const Center(
                child: StyledHeading('Choose a vocation.'),
              ),
              const Center(
                child: StyledText('This determines your available skills.'),
              ),
              const SizedBox(height: 30),

              ListView.builder(
                shrinkWrap:
                    true, // Use shrinkWrap to size the ListView to its children's height
                physics: const NeverScrollableScrollPhysics(),
                itemCount: Vocation.values.length,
                itemBuilder: (_, index) {
                  return VocationCard(
                    selected: Vocation.values[index] == selectedVocation,
                    vocation: Vocation.values[index],
                    onTap: updateVocation,
                  );
                },
              ),

              Center(child: Icon(Icons.code, color: AppColors.primaryColor)),
              const Center(
                child: StyledHeading('Good Luck.'),
              ),
              const Center(
                child: StyledText('And enjoy the journey...'),
              ),

              Center(
                  child: StyledButton(
                      onPressed: handleSubmit,
                      child: const StyledHeading('Create Character')))
            ],
          ),
        ),
      ),
    );
  }
}
