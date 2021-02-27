import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  final String imageUrl;
  ImageScreen({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}
