import 'package:flutter/material.dart';

class TabMenu extends StatelessWidget {
  const TabMenu(this.text, this.icon, {super.key});

  final String text;
  final IconData icon; // Accepting IconData instead of String for the icon

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 100, // Set the minimum width for the tabs
        ),
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF3770FF),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon, // Using IconData
              color: Colors.white,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
