import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:notnetflix/services/api.dart';

class ImageMovieCard extends StatelessWidget {
  final String imageMoviePath;
  const ImageMovieCard({super.key, required this.imageMoviePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CachedNetworkImage(
            imageUrl: API().baseImageURL + imageMoviePath,
            width: 350,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.error),
                )),
      ),
    );
  }
}
