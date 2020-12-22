import 'package:album/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class HomeScreen extends StatelessWidget {
  final LocalAuthentication localAuth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Touch Fingerprint'),
        backgroundColor: Colors.blue[400],
        elevation: 0,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () async {
          bool weCanCheckBiometrics = await localAuth.canCheckBiometrics;

          if (weCanCheckBiometrics) {
            bool authenticated = await localAuth.authenticateWithBiometrics(
              localizedReason: "Authenticate to see Album.",
            );

            if (authenticated) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            }
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(
              Icons.fingerprint,
              size: 124.0,
            ),
            Text(
              "Touch to Login",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
