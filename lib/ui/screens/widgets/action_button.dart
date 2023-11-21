import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color bgColor;
  final Color fColor;

  const ActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.bgColor,
    required this.fColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: bgColor,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          icon,
          color: fColor,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
              color: fColor, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ]),
    );
  }
}
