import 'package:flutter/material.dart';

class Test2Card extends StatelessWidget {
  const Test2Card({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
              width: 1,
            )),
        child: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tokyo",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      "HND",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Sydney",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      "SYD",
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 18,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 8.0),
            Divider(thickness: 1, color: Colors.black),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "DEPARTURE",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "09:00 AM",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "ARRIVAL",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "05:00 PM",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                ),
                Icon(
                  Icons.airplanemode_active,
                  color: Colors.blue,
                ),
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "FLIGHT NUMBER",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "QF-26",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "FLIGHT STATUS",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "ON-TIME",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.green),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
