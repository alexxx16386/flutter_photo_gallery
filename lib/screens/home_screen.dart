import 'package:flutter/material.dart';
import 'package:flutter_photo_gallery/models/image_model.dart';
import 'package:flutter_photo_gallery/models/user_model.dart';
import 'package:flutter_photo_gallery/screens/image_screen.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<ImageModel>> getImages() async {
    List<ImageModel> imageList = [];
    var url =
        'https://api.unsplash.com/photos/?client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var images = convert.jsonDecode(response.body);
      for (var image in images) {
        imageList.add(ImageModel(
            urlSmall: image['urls']['small'],
            urlFull: image['urls']['full'],
            blurHash: image['blur_hash'],
            likes: image['likes'],
            likedByUser: image['liked_by_user'],
            description: image['description'],
            user: UserModel(
              name: image['user']['name'],
              profileImageSmall: image['user']['profile_image']['small'],
            )));
      }
    }
    return imageList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: getImages(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return buildList(context, snapshot.data);
          }
        },
      ),
    );
  }

  ListView buildList(BuildContext _context, List<ImageModel> listImage) {
    return ListView.builder(
      itemCount: listImage.length,
      itemBuilder: (_context, index) {
        String description = '';
        if (listImage[index].description != null) {
          description = listImage[index].description;
        }
        return new Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            listImage[index].user.profileImageSmall),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          listImage[index].user.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ImageScreen(
                              imageUrl: listImage[index].urlFull,
                            )));
                  },
                  child: ClipRRect(
                    child: Image.network(listImage[index].urlSmall),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(listImage[index].likedByUser
                              ? Icons.favorite
                              : Icons.favorite_border),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Likes: ${listImage[index].likes}'),
                          )
                        ],
                      ),
                      (listImage[index].description != null)
                          ? Text(listImage[index].description)
                          : SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
