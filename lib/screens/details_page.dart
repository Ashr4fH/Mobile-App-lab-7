import 'package:album/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String _locationMessage = "";
  DateTime pickedDate;
  TimeOfDay time;
  Geolocator location;

  void _getCurrentLocation() async {
    final position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);

    setState(() {
      _locationMessage = "${position.latitude}, ${position.longitude}";
    });
  }

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Album'),
        backgroundColor: Colors.blue[400],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            TextField(
              decoration: InputDecoration(
                  hintText: "Detailed Description",
                  labelText: "Description",
                  labelStyle: TextStyle(fontSize: 12, color: Colors.black),
                  border: UnderlineInputBorder()),
              obscureText: false,
              maxLines: 2,
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: Text("Location: $_locationMessage"),
                    trailing: Icon(Icons.location_city),
                    onTap: _getCurrentLocation,
                  ),
                  ListTile(
                    title: Text(
                        "Date: ${pickedDate.year}, ${pickedDate.month}, ${pickedDate.day},"),
                    trailing: Icon(Icons.calendar_today),
                    onTap: _pickDate,
                  ),
                  ListTile(
                    title: Text("Time: ${time.hour}:${time.minute},"),
                    trailing: Icon(Icons.access_time),
                    onTap: _pickTime,
                  ),
                ],
              ),
            ),
            FlatButton.icon(
              label: Text('Save'),
              icon: Icon(Icons.save),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              color: Colors.green,
            ),
          ]),
        ),
      ),
    );
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
    );

    if (date != null) {
      setState(() {
        pickedDate = date;
      });
    }
  }

  _pickTime() async {
    TimeOfDay t = await showTimePicker(
      context: context,
      initialTime: time,
    );

    if (t != null) {
      setState(() {
        time = t;
      });
    }
  }
}
