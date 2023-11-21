import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notnetflix/models/movie.dart';
import 'package:notnetflix/ui/screens/widgets/movie_card.dart';

class MovieCategory extends StatelessWidget {
  final String label;
  final List<Movie> movieList;
  final double imageHeight;
  final double imageWidth;
  final Function callback;
  const MovieCategory(
      {super.key,
      required this.label,
      required this.movieList,
      required this.imageHeight,
      required this.imageWidth,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Text(
          label,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: imageHeight,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              final double currentPosition = notification.metrics.pixels;
              // debugPrint('CURRENT POSITION : $currentPosition');
              final double maxPosition = notification.metrics.maxScrollExtent;
              // debugPrint('MAX POSITION = $maxPosition');
              if (currentPosition >= maxPosition / 2) {
                // debugPrint('ON EST ARRIVE AU BOUT DE LA LISTE');
                callback();
              }

              return true;
            },
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movieList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  width: imageWidth,
                  child: movieList.isEmpty
                      ? Center(
                          child: Text(index.toString()),
                        )
                      : MovieCard(movie: movieList[index]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
