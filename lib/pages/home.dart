import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import '../entities/city.dart';
import '../utility/constants.dart';
import 'exploringPage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  double days = 3;
  double maxDailyHour = 3;

  showSnackBar(String text, bool goSettings) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: SizedBox(
            height: 60,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(text, style: Const.titleText))),
        backgroundColor: Const.lightGrey,
        duration: const Duration(seconds: 1),
        action: goSettings
            ? SnackBarAction(
                label: 'Go to settings',
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              )
            : null));
  }

  @override
  Widget build(BuildContext context) {
    if(Const.ssh.connected) {
      Const.lg.clearKml(keepLogos: true);
    }

    return Scaffold(
        backgroundColor: Const.grey,
        appBar: AppBar(
          backgroundColor: Const.darkGrey,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            const SizedBox(width: 45),
            Text('Travel Planner', style: Const.BigText),
            const Spacer(),
            Const.ssh.connected
                ? const Tooltip(
                    message: 'Online',
                    child: Icon(Icons.check_circle, color: Colors.green))
                : const Tooltip(
                    message: 'Offline',
                    child: Icon(Icons.error, color: Colors.red)),
            IconButton(
                onPressed: () {
                  setState(() {
                    Navigator.pushNamed(context, '/settings');
                  });
                },
                icon: const Icon(Icons.settings)),
            const SizedBox(width: 16)
          ],
        ),
        body:
          ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text("Select a City", style: Const.bigTitleText),
              SizedBox(
                width: 280,
                height: 150,
                child: CSCPicker(
                  layout: Layout.vertical,
                  onCountryChanged: (value) {
                    setState(() {
                      countryValue = value;
                      stateValue = "";
                      cityValue = "";
                    });
                  },
                  onStateChanged: (value) {
                    setState(() {
                      stateValue = value ?? "";
                      cityValue = "";
                    });
                  },
                  onCityChanged: (value) {
                    setState(() {
                      cityValue = value ?? "";
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text("Select a Duration (days)", style: Const.bigTitleText),
              const SizedBox(height: 20),
              SizedBox(
                width: 500,
                height: 20,
                child: Slider(
                  value: days,
                  min: 1,
                  max: 14,
                  divisions: 13,
                  label: days.toInt().toString() + (days>1 ? " days": " day"),
                  onChanged: (double value) {
                  setState(() {
                    days = value;
                  });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text("Select a maximum daily of exploration (hours)", style: Const.bigTitleText),
              const SizedBox(height: 20),
              SizedBox(
                width: 500,
                height: 20,
                child: Slider(
                  value: maxDailyHour,
                  min: 1,
                  max: 8,
                  divisions: 8,
                  label: maxDailyHour.toInt().toString() + (maxDailyHour>1 ? " hours": " hour"),
                  onChanged: (double value) {
                    setState(() {
                      maxDailyHour = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                  width: 500,
                  height: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Const.prefs?.remove('geminiAPIKey');

                      if(!Const.ssh.connected) {
                        showSnackBar("Please connect to the screens first", true);
                      }else if(Const.geminiAPIKey == "") {
                        showSnackBar("Please set your Gemini API Key in settings", true);
                      } else if (countryValue.isEmpty) {
                        showSnackBar("Please select a country", false);
                      } else {


                        countryValue = countryValue.substring(8);
                        if(stateValue.isEmpty) {
                          stateValue = countryValue;
                        }

                        if(cityValue.isEmpty) {
                          cityValue = stateValue;
                        }

                        print("city: $cityValue, state: $stateValue, country: $countryValue");

                        Const.citySelected =  City(
                      name: cityValue,
                      state: stateValue,
                      country: countryValue);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExploringPage( days: days.toInt(), maxDailyHour: maxDailyHour.toInt())),
                        );

                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.all(20),
                      backgroundColor: Const.darkGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Const.lightGrey,
                          width: 4,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            countryValue.isNotEmpty
                                ? countryValue.characters.first
                                : "🌍",
                            style: const TextStyle(fontSize: 60)),
                        Text(
                            countryValue.isNotEmpty
                                ? "Explore ${cityValue.isNotEmpty ? cityValue : stateValue.isNotEmpty ? stateValue : countryValue.substring(8)}"
                                : "Select a Country first",
                            style: Const.BigText)
                      ],
                    ),
                  )),],
          ),
        );
  }
}
