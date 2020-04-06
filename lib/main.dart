import 'package:app/screens/note_list.dart';
import 'package:appspector/appspector.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //runAppSpector();
  runApp(MyApp());
}

void runAppSpector() {
  var config = new Config();
  config.iosApiKey = "ios_NTc5MWRkZTctMjA4MC00MjRjLWI0NDItNGY1ZDUxOTgyNGNm";
  config.androidApiKey = "android_MjRkMTc5YjgtNTk3My00ZmM3LTliMWEtYjQ1ZmMxMGM0NDE0";
  AppSpectorPlugin.run(config);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: NoteList()
    );
  }
}
