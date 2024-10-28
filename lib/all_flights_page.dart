import 'package:flutter/material.dart';
import 'package:flightscope/flight_home_card.dart';
import 'package:flightscope/api/all_flights.dart';
import 'dart:async';

class AllFlightsPage extends StatefulWidget {
  const AllFlightsPage({super.key});

  @override
  _AllFlightsPageState createState() => _AllFlightsPageState();
}

class _AllFlightsPageState extends State<AllFlightsPage> {
  late Future<List<Flight>> futureFlights;

  @override
  void initState() {
    super.initState();
    futureFlights = fetchFlights();
  }

  Future<void> _refreshData() async {
    setState(() {
      futureFlights = fetchFlights();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Flights"),
        backgroundColor: const Color(0xFF3770FF),
      ),
      body: FutureBuilder<List<Flight>>(
        future: futureFlights,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else {
            final flights = snapshot.data!;
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView.builder(
                itemCount: flights.length,
                itemBuilder: (context, index) {
                  final flight = flights[index];
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
                },
              ),
            );
          }
        },
      ),
    );
  }
}