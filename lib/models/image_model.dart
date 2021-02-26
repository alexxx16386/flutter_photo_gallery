import 'package:flutter_photo_gallery/models/user_model.dart';

class ImageModel {
  final String urlSmall;
  final String urlFull;
  final String blurHash;
  final String description;
  final int likes;
  final bool likedByUser;
  final UserModel user;

  ImageModel({
    this.urlSmall,
    this.urlFull,
    this.blurHash,
    this.description,
    this.likes,
    this.likedByUser,
    this.user,
  });
}
