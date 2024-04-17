import 'dart:convert';

import 'package:flutter/material.dart';

import '../entities/city.dart';
import '../services/lg_service.dart';
import '../services/ssh_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Const {
  static SharedPreferences? prefs;
  static SSHService ssh = SSHService();
  static String geminiAPIKey = "";
  static LGService lg = LGService(ssh.client);
  static Color grey = const Color(0xFF2d2d2d);
  static Color darkGrey = const Color(0xFF222222);
  static Color lightGrey = const Color(0xFF424242);
  static Color superlightGrey = const Color(0xFFA1A3A5);
  static Color foregroundColor = const Color(0xCD144ED3);
  static City? citySelected;

  static loadPrefs() async {
    prefs = await SharedPreferences.getInstance();
    geminiAPIKey = prefs!.getString('geminiAPIKey') ?? geminiAPIKey;
  }

  static TextStyle simpleText = const TextStyle(
    color: Colors.white,
    fontSize: 20,
  );

  static TextStyle titleText = const TextStyle(
    color: Colors.white,
    fontSize: 20,
  );

  static TextStyle BigText = const TextStyle(
    color: Colors.white,
    fontSize: 20,
  );

  static TextStyle bigTitleText = const TextStyle(
    color: Colors.white,
    fontSize: 30,
  );

  static TextStyle splashTitleText = TextStyle(
    color: superlightGrey,
    fontSize: 50,
  );

  static TextStyle splashSimpleText = TextStyle(
    color: superlightGrey,
    fontSize: 20,
  );

  static RichText parseAndDisplayText(String inputText) {
    final RegExp pattern = RegExp(r'\*\*(.*?)\*\*');
    List<TextSpan> spans = [];
    int start = 0;

    pattern.allMatches(inputText).forEach((match) {
      final String normalText = inputText.substring(start, match.start);

      if (normalText.isNotEmpty) {
        spans.add(TextSpan(text: normalText));
      }
      final String boldText = match.group(1)!;
      spans.add(TextSpan(text: boldText, style: const TextStyle(fontWeight: FontWeight.bold)));

      start = match.end;
    });

    if (start < inputText.length) {
      spans.add(TextSpan(text: inputText.substring(start)));
    }

    return RichText(text: TextSpan(children: spans, style: const TextStyle(color: Colors.black)));
  }

  ///apiKey allows up to 2,500 API requests/day (free)
  static Future<String> getCoordinatesForCity(String city) async {
    String apiKey = "f7bd0324f515445f8a27c79c977d1586";
    final uri = Uri.parse(
        'https://api.opencagedata.com/geocode/v1/json?q=$city&key=$apiKey');

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null && data['results'].isNotEmpty) {
          final geometry = data['results'][0]["annotations"]["DMS"];
          String lat = geometry['lat'];
          String lng = geometry['lng'];
          return "${dmsToDecimal(lat)}, ${dmsToDecimal(lng)}";
        } else {
          return "Unknown";
        }
      } else {
        return "Unknown";
      }
    } catch (e) {
      return "Unknown";
    }
  }

  static double dmsToDecimal(String dms) {
    List<String> parts = dms.split(' ');

    double degrees = double.parse(parts[0].substring(0, parts[0].length - 1));
    double minutes = double.parse(parts[1].substring(0, parts[1].length - 1));
    double seconds = double.parse(parts[2].substring(0, parts[2].length - 2));

    double decimal = degrees + (minutes / 60) + (seconds / 3600);

    if (dms.contains('S') || dms.contains('W')) {
      decimal = -decimal;
    }

    return decimal;
  }
}