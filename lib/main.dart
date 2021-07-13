import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Position position;
  @override
  void initState() {
    super.initState();
    _getLocation(context);
  }
  Future<void> _getLocation(context) async {
    Position _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high); // ここで精度を「high」に指定している
    print(_currentPosition);
    setState(() {
      position = _currentPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Sample'),
      ),
      body: Center(
        child: _image == null
            ? Text('${position}')
            : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.add_a_photo),
      ),
    );

    // return FutureBuilder<GeolocationStatus>(
    //   future: Geolocator().checkGeolocationPermissionStatus(),
    //   builder:
    //       (BuildContext context, AsyncSnapshot<GeolocationStatus> snapshot) {
    //     if (!snapshot.hasData) {
    //       return const Center(child: CircularProgressIndicator());
    //     }
    //
    //     if (snapshot.data == GeolocationStatus.denied) {
    //       return Text(
    //         'Access to location denied',
    //         textAlign: TextAlign.center,
    //       );
    //     }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Location Infomation",
                style: TextStyle(
                  fontSize: 20.0
                ),
              ),
              Text("Your Current Location is :"),
              Text("${position}")
            ],
          ),
        );
      // }
    // );

  }
}
