import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Flight>> fetchFlights() async {
  final response = await http.get(
    Uri.parse('https://api.aviationstack.com/v1/flights?access_key=666977412562e42e1d0e1a8c0f4a3763&limit=10'),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    final List<dynamic> flightsJson = json['data'];
    return flightsJson
        .map((flight) => Flight.fromJson(flight as Map<String, dynamic>))
        .toList();
  } else {
    throw Exception('Failed to load flights');
  }
}

class Flight {
  final String flightNumber;
  final String departureCity;
  final String departureCode;
  final String arrivalCity;
  final String arrivalCode;
  final String departureDate;
  final String departureTime;
  final String arrivalDate;
  final String arrivalTime;
  final String flightStatus;

  Flight({
    required this.flightNumber,
    required this.departureCity,
    required this.departureCode,
    required this.arrivalCity,
    required this.arrivalCode,
    required this.departureDate,
    required this.departureTime,
    required this.arrivalDate,
    required this.arrivalTime,
    required this.flightStatus,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    String formatDate(String? dateTime) {
      if (dateTime == null) return 'TBD';
      final parsedDate = DateTime.parse(dateTime);
      return '${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}';
    }

    String formatTime(String? dateTime) {
      if (dateTime == null) return 'TBD';
      final parsedTime = DateTime.parse(dateTime);
      return '${parsedTime.hour.toString().padLeft(2, '0')}:${parsedTime.minute.toString().padLeft(2, '0')}';
    }

    return Flight(
      flightNumber: json['flight']['iata'] as String? ?? 'Unknown',
      departureCity: json['departure']['airport'] as String? ?? 'Unknown',
      departureCode: json['departure']['iata'] as String? ?? 'Unknown',
      arrivalCity: json['arrival']['airport'] as String? ?? 'Unknown',
      arrivalCode: json['arrival']['iata'] as String? ?? 'Unknown',
      departureDate: formatDate(json['departure']['estimated']),
      departureTime: formatTime(json['departure']['estimated']),
      arrivalDate: formatDate(json['arrival']['estimated']),
      arrivalTime: formatTime(json['arrival']['estimated']),
      flightStatus: json['flight_status'] as String? ?? 'UNKNOWN',
    );
  }
}