import 'package:flightscope/all_flights_page.dart';
import 'package:flightscope/search_page.dart';
import 'package:flightscope/tickets_page.dart';
import 'package:flutter/material.dart';

class TabMenu extends StatelessWidget {
  const TabMenu(this.text, this.icon, this.page, {super.key});

  final String text;
  final IconData icon;
  final Widget Function() page; // Function returning a Widget

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page(), // Call the page function
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(20),
        backgroundColor: const Color(0xFF3770FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ), // Button color
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TabMenu(
                      "ALL FLIGHTS",
                      Icons.local_airport,
                      () => const AllFlightsPage(),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TabMenu(
                      "SEARCH",
                      Icons.search,
                      () => const SearchFlightsPage(),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TabMenu(
                      "TICKETS",
                      Icons.airplane_ticket,
                      () => const TicketsPage(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
