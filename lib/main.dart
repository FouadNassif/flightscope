import 'dart:async'; // Import Timer
import 'package:flutter/material.dart';
import 'package:flightscope/all_flights_page.dart';
import 'package:flightscope/search_page.dart';
import 'package:flightscope/tickets_page.dart';
import 'package:flightscope/flight_home_card.dart';
import 'package:flightscope/api/api_10_flights.dart';
import 'package:flightscope/tab.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: "lib/.env");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {``
  late Future<List<Flight>> futureFlights;
  bool autoRefreshEnabled = false; // Track if auto-refresh is enabled
  Timer? _timer; // Timer for auto-refresh
  DateTime? lastUpdatedTime; // Store the last update time

  @override
  void initState() {
    super.initState();
    futureFlights = fetchFlights();

    // If auto-refresh is enabled, set up the timer
    if (autoRefreshEnabled) {
      _startAutoRefresh();
    }
  }

  Future<void> _refreshData() async {
    futureFlights = fetchFlights();
    lastUpdatedTime = DateTime.now(); // Update the last update time
    setState(() {}); // Update the UI
  }

  void _toggleAutoRefresh() {
    setState(() {
      autoRefreshEnabled = !autoRefreshEnabled; // Toggle the state
    });

    if (autoRefreshEnabled) {
      _startAutoRefresh();
    } else {
      _stopAutoRefresh();
    }
  }

  void _startAutoRefresh() {
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      _refreshData(); // Call refresh function every 10 seconds
    });
  }

  void _stopAutoRefresh() {
    _timer?.cancel(); // Cancel the timer
    _timer = null; // Reset the timer
  }

  @override
  void dispose() {
    _stopAutoRefresh(); // Stop the timer when disposing
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    // Background Image
                    Container(
                      height: 250.0,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                        image: DecorationImage(
                          image: AssetImage('assets/img/Hero.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Black Box with Text
                    Container(
                      height: 250.0,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Track your flight and stay updated with real-time flight data from airports around the world!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Tabs
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TabMenu(
                      "ALL FLIGHTS",
                      Icons.local_airport,
                      () => const AllFlightsPage(),
                    ), // Tab 1
                    TabMenu(
                      "SEARCH",
                      Icons.search,
                      () => const SearchFlightsPage(),
                    ), // Tab 2
                    TabMenu(
                      "TICKETS",
                      Icons.airplane_ticket,
                      () => const TicketsPage(),
                    ), // Tab 3
                  ],
                ),
                const SizedBox(height: 16),
                // Auto-refresh row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: _toggleAutoRefresh,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              autoRefreshEnabled ? Colors.red : Colors.blue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          autoRefreshEnabled
                              ? 'Stop Auto Refresh'
                              : 'Start Auto Refresh',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      if (lastUpdatedTime != null)
                        Text(
                          'Last updated: ${lastUpdatedTime!.hour}:${lastUpdatedTime!.minute}:${lastUpdatedTime!.second}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Display fetched flights dynamically
                FutureBuilder<List<Flight>>(
                  future: futureFlights,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final flights = snapshot.data!;
                      return Column(
                        children: flights.map((flight) {
                          return FlightHomeCard(
                            departureCity: flight.departureCity,
                            departureCode: flight.departureCode,
                            arrivalCity: flight.arrivalCity,
                            arrivalCode: flight.arrivalCode,
                            departureTime: flight.departureTime,
                            arrivalTime: flight.arrivalTime,
                            flightNumber: flight.flightNumber,
                            flightStatus: flight.flightStatus,
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
