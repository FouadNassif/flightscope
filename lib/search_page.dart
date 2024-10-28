import 'package:flutter/material.dart';
import 'package:flightscope/flight_home_card.dart';
import 'package:flightscope/api/all_flights.dart';

class SearchFlightsPage extends StatefulWidget {
  const SearchFlightsPage({super.key});

  @override
  _SearchFlightsPageState createState() => _SearchFlightsPageState();
}

class _SearchFlightsPageState extends State<SearchFlightsPage> {
  late Future<List<Flight>> futureFlights;
  List<Flight> allFlights = [];
  List<Flight> filteredFlights = [];
  String searchTerm = '';

  @override
  void initState() {
    super.initState();
    futureFlights = fetchFlights();
    futureFlights.then((flights) {
      setState(() {
        allFlights = flights;
        filteredFlights = flights; // Initially, all flights are shown
      });
    });
  }

  void _filterFlights(String term) {
    setState(() {
      searchTerm = term;
      filteredFlights = allFlights
          .where((flight) =>
              flight.departureCity.toLowerCase().contains(term.toLowerCase()) ||
              flight.arrivalCity.toLowerCase().contains(term.toLowerCase()) ||
              flight.flightNumber.toLowerCase().contains(term.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3770FF),
        title: const Text("Search Flights"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _filterFlights,
              decoration: InputDecoration(
                labelText: 'Search by city or flight number',
                border: const OutlineInputBorder(),
                suffixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Flight>>(
              future: futureFlights,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  // Use filteredFlights for displaying the results
                  if (filteredFlights.isEmpty) {
                    return const Center(
                        child:
                            Text('No results found')); // Message for no results
                  } else {
                    return ListView.builder(
                      itemCount: filteredFlights.length,
                      itemBuilder: (context, index) {
                        final flight = filteredFlights[index];
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
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
