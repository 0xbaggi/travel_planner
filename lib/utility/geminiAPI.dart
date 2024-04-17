
import 'package:google_generative_ai/google_generative_ai.dart';

import 'constants.dart';

class GeminiAPI {
  final model = GenerativeModel(model: 'gemini-pro', apiKey: Const.geminiAPIKey);

  Future<String> _ask(String prompt) async {
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    return response.text ?? "Unknown";
  }

  Future<Map<String, String>> askAll(String cityName, int days, int maxDailyHour) async {
    Map<String, String> responses = {};
    print("ASKED $cityName");

    responses["description"] = await askCityDescription(cityName);
    responses["coordinates"] = await Const.getCoordinatesForCity(cityName);
    responses["activities"] = await askActivities(cityName, days, maxDailyHour);
    return responses;
  }

  Future<String> askActivities(String city, int days, int maxDailyHour) async {

    final prompt = '''Give me a list of some activities I can do in $city in $days with a maximum duration of $maxDailyHour for every day, 
    give me a list that follow this format: 
    template begin
    Day 1 - xam to ypm:
       - from xam to xpm: activity
       - from xam to xpm: activity
       ...
       
    Day 2 - xpm to ypm:
       activity
       
    Day 3 - xam to ypm:
       activity
    ...
    template end
    Make sure to include the time of the activity and the name of the activity and check if every day activity duration is equal or less than $maxDailyHour hours.
    ''';

    return _ask(prompt);
  }

  Future<String> askCityDescription(String city) {
    final prompt = '''Give me a quick description of $city city with a maximum of 50 words''';
    return _ask(prompt);
  }

  Future<String> askCoordinates(String city) {
    final prompt = '''
      Give me the coordinates of $city center in this format: "latitude, longitude" with max 4 decimal points, 
      if you dont know the coordinates of $city return "Unknown"
    ''';

    return _ask(prompt);
  }

}