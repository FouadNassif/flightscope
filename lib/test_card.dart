import 'package:flutter/material.dart';

class TestCard extends StatelessWidget {
  const TestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(16), // Inner padding
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade50, // Background color
          borderRadius: BorderRadius.circular(12), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 3), // Shadow position
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align text left
              children: [
                Text("Flight Number: KFC-342"),
                SizedBox(height: 8), // Spacing between elements
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Dubai"),
                        Text("09:45"),
                      ],
                    ),
                    SizedBox(width: 10), // Space between columns
                    Text("==>"),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [Text("Lebanon"), Text("12:45")],
                    ),
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("STATUS"),
                SizedBox(height: 8),
                Text(
                  "ON-TIME",
                  style: TextStyle(
                    color: Colors.green, // You can change color based on status
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
