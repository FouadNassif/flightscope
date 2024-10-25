import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum(int id) async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'));

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': int userId,
        'id': int id,
        'title': String title,
      } =>
          Album(
            userId: userId,
            id: id,
            title: title,
          ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

class AlbumWidget extends StatelessWidget {
  final int albumId;

  const AlbumWidget({super.key, required this.albumId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Album>(
      future: fetchAlbum(albumId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.title);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
