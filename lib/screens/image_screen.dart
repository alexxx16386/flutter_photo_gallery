import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class ImageScreen extends StatelessWidget {
  final String imageUrl;
  final String blurHash;
  ImageScreen({this.imageUrl, this.blurHash});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: BlurHash(
          duration: Duration(milliseconds: 100),
          hash: blurHash,
          image: imageUrl,
          imageFit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
