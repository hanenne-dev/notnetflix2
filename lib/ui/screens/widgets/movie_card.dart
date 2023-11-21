import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:notnetflix/models/movie.dart';
import 'package:notnetflix/ui/screens/details_movie_page.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DetailsMoviePage(movie: movie);
            },
          ),
        );
      },
      child: CachedNetworkImage(
        imageUrl: movie.posterURL(),
        errorWidget: (context, url, error) => const Center(
          child: Icon(Icons.error),
        ),
        fit: BoxFit.cover,
      ),
    );
  }
}
