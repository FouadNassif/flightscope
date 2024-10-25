import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flightscope/flight_home_card.dart';
import 'package:flightscope/tabs/tab.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> flights = []; // Changed to Map<String, dynamic>

  @override
  void initState() {
    super.initState();
    fetchFlightData(); // Fetch flight data when the app starts
  }

  // Function to fetch real-time flight data from the AviationStack API
  Future<void> fetchFlightData() async {
    
    final String apiUrl ='https://api.aviationstack.com/v1/flights?access_key=d7a8fdb1b7c5f5e673d62f96002588da';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> flightsData = data['data']; // Extract flight data

        setState(() {
          // Map flight data to the structure expected by FlightHomeCard
          flights = flightsData.take(5).map((flight) {
            return {
              'departureCity': flight['departure']['airport'] ?? 'Unknown',
              'departureCode': flight['departure']['iata'] ?? '---',
              'arrivalCity': flight['arrival']['airport'] ?? 'Unknown',
              'arrivalCode': flight['arrival']['iata'] ?? '---',
              'departureTime': flight['departure']['scheduled'] ?? '---',
              'arrivalTime': flight['arrival']['scheduled'] ?? '---',
              'flightNumber': flight['flight']['iata'] ?? '---',
              'flightStatus': flight['flight_status'] ?? '---',
            };
          }).toList();
        });
      } else {
        debugPrint('Failed to load flights. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching flights: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TabMenu("ALL FLIGHTS", Icons.local_airport),
                  TabMenu("WORLD", Icons.public),
                  TabMenu("AIRPORTS", Icons.airplane_ticket),
                ],
              ),
              const SizedBox(height: 16),
              // Display flight data
              flights.isEmpty
                  ? const CircularProgressIndicator() // Show a loading indicator if data is not yet available
                  : Column(
                      children: flights.map((flight) {
                        return FlightHomeCard(
                          departureCity: flight['departureCity'] as String,
                          departureCode: flight['departureCode'] as String,
                          arrivalCity: flight['arrivalCity'] as String,
                          arrivalCode: flight['arrivalCode'] as String,
                          departureTime: flight['departureTime'] as String,
                          arrivalTime: flight['arrivalTime'] as String,
                          flightNumber: flight['flightNumber'] as String,
                          flightStatus: flight['flightStatus'] as String,
                        );
                      }).toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
