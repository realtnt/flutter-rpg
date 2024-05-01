import 'package:flutter/material.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledTextField extends StatelessWidget {
  const StyledTextField({
    super.key,
    required this.label,
    this.controller,
    this.prefixIcon,
    this.onChanged,
  });

  final Widget label;
  final TextEditingController? controller;
  final Icon? prefixIcon;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: GoogleFonts.kanit(
        textStyle: Theme.of(context).textTheme.bodyMedium,
      ),
      cursorColor: AppColors.textColor,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        label: label,
      ),
      controller: controller,
      onChanged: onChanged,
    );
  }
}
