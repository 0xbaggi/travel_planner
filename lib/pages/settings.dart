import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ExploreCities/entities/ssh_entity.dart';

import '../utility/constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Controller for text fields
  TextEditingController ipController = TextEditingController();
  TextEditingController portController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController geminiAPIController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureKey = true;

  @override
  void initState() {
    super.initState();

    // Set default values
    ipController.text = '192.168.1.89';
    portController.text = '22';
    userController.text = 'lg';
    passwordController.text = 'toor';
    geminiAPIController.text = Const.geminiAPIKey;
  }

  @override
  Widget build(BuildContext context) {
    showSnackBar(String text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: SizedBox(
            height: 60,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(text, style: Const.titleText))),
        backgroundColor: Const.lightGrey,
      ));
    }

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Const.grey,
        appBar: AppBar(
          backgroundColor: Const.darkGrey,
          iconTheme: const IconThemeData(
            color: Colors.white,
            size: 24,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              FocusScope.of(context).unfocus();
              Navigator.pushNamed(context, '/home');
            },
          ),
          title: Row(
            children: [
              Text('Settings', style: Const.titleText),
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // IP Input
                TextField(
                  controller: ipController,
                  style: Const.simpleText,
                  // Assuming this is defined in your constants
                  decoration: InputDecoration(
                    labelText: 'Ip',
                    labelStyle: Const.simpleText,
                    // Assuming this is defined in your constants
                    filled: true,
                    fillColor: Const.darkGrey,
                    // Background color of the field
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Const.lightGrey,
                        width: 4,
                        style: BorderStyle.solid,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Const.lightGrey,
                        width: 4,
                        style: BorderStyle.solid,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Const.lightGrey,
                        width: 4,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Port Input
                TextField(
                  controller: portController,
                  keyboardType: TextInputType.number,
                  style: Const.simpleText,
                  // Assuming this is defined in your constants
                  decoration: InputDecoration(
                    labelText: 'Port',
                    labelStyle: Const.simpleText,
                    // Assuming this is defined in your constants
                    filled: true,
                    fillColor: Const.darkGrey,
                    // Background color of the field
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Const.lightGrey,
                        width: 4,
                        style: BorderStyle.solid,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Const.lightGrey,
                        width: 4,
                        style: BorderStyle.solid,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Const.lightGrey,
                        width: 4,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // User Input
                TextField(
                  controller: userController,
                  style: Const.simpleText,
                  // Assuming this is defined in your constants
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: Const.simpleText,
                    // Assuming this is defined in your constants
                    filled: true,
                    fillColor: Const.darkGrey,
                    // Background color of the field
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Const.lightGrey,
                        width: 4,
                        style: BorderStyle.solid,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Const.lightGrey,
                        width: 4,
                        style: BorderStyle.solid,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Const.lightGrey,
                        width: 4,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Password Input
                TextField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  style: Const.simpleText,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: Const.simpleText,
                      filled: true,
                      fillColor: Const.darkGrey,
                      // Set the background color of the field
                      suffixIcon: IconButton(
                        icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Const.lightGrey,
                          width: 4,
                          style: BorderStyle.solid,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Const.lightGrey,
                          width: 4,
                          style: BorderStyle.solid,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Const.lightGrey,
                          width: 4,
                          style: BorderStyle.solid,
                        ),
                      )),
                ),
                const SizedBox(height: 16),

                // Service Port Input
                TextField(
                  controller: geminiAPIController,
                  keyboardType: TextInputType.text,
                  obscureText: _obscureKey,
                  style: Const.simpleText,
                  onSubmitted: (value) {
                    Const.prefs?.setString('geminiAPIKey', value);
                  },
                  decoration: InputDecoration(
                      labelText: 'Gemini API key',
                      labelStyle: Const.simpleText,
                      // Assuming this is defined in your constants
                      filled: true,
                      fillColor: Const.darkGrey,
                      suffixIcon: IconButton(
                        icon: Icon(
                            _obscureKey
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white),
                        onPressed: () {
                          setState(() {
                            _obscureKey = !_obscureKey;
                          });
                        },
                      ),
                      // Background color of the field
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Const.lightGrey,
                          width: 4,
                          style: BorderStyle.solid,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Const.lightGrey,
                          width: 4,
                          style: BorderStyle.solid,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Const.lightGrey,
                          width: 4,
                          style: BorderStyle.solid,
                        ),
                      )),
                ),
                const SizedBox(height: 32),

                // Connect Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
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
                        )),
                    onPressed: () async {
                      String ip = ipController.text;
                      int port = int.tryParse(portController.text) ?? 0;
                      String user = userController.text;
                      String password = passwordController.text;

                      Const.geminiAPIKey = geminiAPIController.text;
                      try {
                        await Const.ssh
                            .connect(SSHEntity(
                                host: ip,
                                port: port,
                                username: user,
                                passwordOrKey: password))
                            .timeout(const Duration(seconds: 5));
                        showSnackBar(Const.ssh.connected
                            ? 'Connected successfully!'
                            : 'Connection failed!');
                      } on TimeoutException catch (_) {
                        showSnackBar('Connection timed out!');
                      }
                      setState(() {});
                    },
                    child: Text('Connect', style: Const.simpleText),
                  ),
                ),
                const SizedBox(height: 10),

                // Disconnect Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
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
                        )),
                    onPressed: () {
                      setState(() {
                        if(Const.ssh.connected) {
                          Const.ssh.disconnect();
                        } else {
                          showSnackBar('Already disconnected!');
                        }
                      });
                    },
                    child: Text('Disconnect', style: Const.simpleText),
                  ),
                ),
                const SizedBox(height: 10),

                // Disconnect Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
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
                        )),
                    onPressed: () {
                      setState(() {
                        if(Const.ssh.connected) {
                          Const.lg.clearKml(keepLogos: false);
                        } else {
                          showSnackBar('Connect to the liquid galaxy first!');
                        }
                      });
                    },
                    child: Text('Clear KML', style: Const.simpleText),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
