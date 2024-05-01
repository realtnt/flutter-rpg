import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/theme.dart';

class Heart extends StatefulWidget {
  const Heart(this.character, {super.key});

  final Character character;

  @override
  State<Heart> createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _sizeAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _sizeAnimation = TweenSequence([
      TweenSequenceItem<double>(tween: Tween(begin: 25, end: 40), weight: 50),
      TweenSequenceItem<double>(tween: Tween(begin: 40, end: 25), weight: 50),
    ]).animate(_controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return IconButton(
          onPressed: () {
            setState(() {
              _controller.reset();
              _controller.forward();
              widget.character.toggleFav();
            });
          },
          icon: Icon(
            widget.character.isFav ? Icons.favorite : Icons.favorite_border,
            color:
                widget.character.isFav ? AppColors.primaryColor : Colors.grey,
            size: _sizeAnimation.value,
          ),
        );
      },
    );
  }
}
