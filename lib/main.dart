import 'package:album/screens/fingerprint.dart';
import 'package:album/screens/pin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    home: MyApp(),
    themeMode: ThemeMode.system,
    theme: ThemeData(
      brightness: Brightness.light,
      accentColor: Colors.blue,
    ),
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      accentColor: Colors.amber[700],
    ),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to My Album'),
        backgroundColor: Colors.blue[400],
        elevation: 0,
      ),
      body: Center(
        child: FlatButton.icon(
          label: Text('Login'),
          icon: Icon(Icons.login),
          onPressed: () => showChoiceDialog(context),
          color: Colors.blue,
        ),
      ),
    );
    //HomePinScreen();
  }
}

Future<void> showChoiceDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Make a choice"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text("Pin"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePin(),
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
              GestureDetector(
                child: Text("Fingerprint"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      );
    },
  );
}
