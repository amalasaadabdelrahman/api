import 'dart:convert';

import 'package:api_test/models/cities.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Citiy> cities = [];
  void fetchData() async {
    const url = 'https://sallah.hexacit.com/api/getCities';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final city = json['cities'] as List<dynamic>;
    final transformed = city.map((e) {
      final translations = Translations(
          locale: e['translations']['locale'], name: e['translations']['name']);
      return Citiy(name: e['name'], id: e['id'], translation: translations);
    }).toList();
    setState(() {
      cities = transformed;
    });
    print('data fetched');
    print(transformed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Api Call'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchData();
        },
        child: Icon(Icons.add),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            final city = cities[index];
            return ListTile(
              title: Text(city.name),
              subtitle: Text(''),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10,
            );
          },
          itemCount: cities.length),
    );
  }
}
