
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:ExploreCities/utility/geminiAPI.dart';
import '../utility/constants.dart';
import 'home.dart';

class ExploringPage extends StatelessWidget {
  int days;
  int maxDailyHour;

  ExploringPage({
    super.key,
    required this.days,
    required this.maxDailyHour,
  });

  GeminiAPI? gemini;

  Future< Map<String, String>> initCity() async {
    await Const.lg.clearKml(keepLogos: true);

    Map<String, String> responses = await gemini!.askAll(Const.citySelected!.name, days, maxDailyHour);
    if(responses.containsKey("coordinates") && responses["coordinates"] != "Unknown") {
      Const.citySelected!.setCoordinate(responses["coordinates"]!);
    }

    if(responses.containsKey("activities")) {
      Const.citySelected!.activities = responses["activities"] ?? "No activities found";
    }

    if(responses.containsKey("description")) {
      Const.citySelected!.description = responses["description"] ?? "No description found";
    }

    await Const.lg.sendTour(Const.citySelected!.latitude, Const.citySelected!.longitude, 4500.0, 60, 1);

    Const.lg.displayCityBaloon(Const.citySelected!.name, responses["description"] ?? "No description found", responses["activities"] ?? "No activities found");

    return responses;
  }

  @override
  Widget build(BuildContext context) {
    if (Const.citySelected == null) {
      return Container();
    }
    print("building ${Const.citySelected!.name}, ${Const.citySelected!.country}, ${Const.citySelected!.state} ");
    gemini = GeminiAPI();

    return Scaffold(
      backgroundColor: Const.grey,
      appBar: AppBar(
        backgroundColor: Const.darkGrey,
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 24,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            await Const.lg.clearSlave(2);
            Const.citySelected = null;
            FocusScope.of(context).unfocus();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );

            },
        ),
        title: Row(
          children: [
            Text(Const.citySelected!.name, style: Const.titleText),
            const Spacer(),
            Const.ssh.connected
                ? const Tooltip(
                message: 'Online',
                child: Icon(Icons.check_circle, color: Colors.green))
                : const Tooltip(
                message: 'Offline',
                child: Icon(Icons.error, color: Colors.red)),
          ],
        ),
      ),
      body: FutureBuilder(future: initCity(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.data == null) {
                return Center(child: Text("No data", style: Const.simpleText));
              }

              return Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: Markdown(data: Const.citySelected!.description, styleSheet: MarkdownStyleSheet(
                          p: Const.simpleText,
                          listBullet: Const.simpleText,
                          h1: Const.titleText,
                          h2: Const.titleText,
                          h3: Const.titleText,
                          h4: Const.titleText,
                          h5: Const.titleText,
                          h6: Const.titleText,
                        )
                      ),
                  ),
                Align(
                alignment: Alignment.topLeft,
                child: Padding(padding: const EdgeInsets.only(left: 15),child: Text("\nSuggested activities: ", style: Const.simpleText))),
                  const SizedBox(height: 10),
                  Expanded(
                      child: Markdown(data: Const.citySelected!.activities, styleSheet: MarkdownStyleSheet(
                          p: Const.simpleText,
                          listBullet: Const.simpleText,
                          h1: Const.titleText,
                          h2: Const.titleText,
                          h3: Const.titleText,
                          h4: Const.titleText,
                          h5: Const.titleText,
                          h6: Const.titleText,
                        )
                      ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.white),
                  Row(children: [
                    const Spacer(),
                    Text("Coordinates: ${(Const.citySelected!.longitude* 10000).truncateToDouble() / 10000} lat, ${(Const.citySelected!.latitude* 10000).truncateToDouble() / 10000} long", style: Const.simpleText),
                  ],)
                ],
              );
            }
          }),
    );
  }
}