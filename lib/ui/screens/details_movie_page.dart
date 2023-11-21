import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notnetflix/models/movie.dart';
import 'package:notnetflix/repositories/data_repository.dart';
import 'package:notnetflix/ui/screens/widgets/action_button.dart';
import 'package:notnetflix/ui/screens/widgets/casting_card.dart';
import 'package:notnetflix/ui/screens/widgets/image_movie_card.dart';
import 'package:notnetflix/ui/screens/widgets/movie_info.dart';
import 'package:notnetflix/ui/screens/widgets/my_video_player.dart';
import 'package:notnetflix/utils/constant.dart';
import 'package:provider/provider.dart';

class DetailsMoviePage extends StatefulWidget {
  final Movie movie;
  const DetailsMoviePage({super.key, required this.movie});

  @override
  State<DetailsMoviePage> createState() => _DetailsMoviePageState();
}

class _DetailsMoviePageState extends State<DetailsMoviePage> {
  Movie? newMovie;
  @override
  void initState() {
    super.initState();
    getMovieData();
  }

  void getMovieData() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    //récupération détails du movie
    Movie repMovie = await dataProvider.getDetailsMovies(movie: widget.movie);
    setState(() {
      newMovie = repMovie;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
      ),
      body: newMovie == null
          ? Center(
              child: SpinKitCircle(
                color: kPrimaryColor,
                size: 20,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  SizedBox(
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    child: newMovie!.video!.isEmpty
                        ? Center(
                            child: Text(
                              'Pas de vidéo disponible',
                              style: GoogleFonts.poppins(
                                backgroundColor: kBackgroundColor,
                                color: Colors.amber,
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          )
                        : MyVideoPlayer(movieId: newMovie!.video!.first),
                  ),
                  MovieInfo(movie: newMovie!),
                  const SizedBox(
                    height: 10,
                  ),
                  ActionButton(
                      label: 'Lecture',
                      icon: Icons.play_arrow,
                      bgColor: Colors.white,
                      fColor: kBackgroundColor),
                  const SizedBox(
                    height: 10,
                  ),
                  ActionButton(
                    label: 'Télécharger la vidéo',
                    icon: Icons.download,
                    bgColor: Colors.grey.withOpacity(0.3),
                    fColor: Colors.white,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    newMovie!.description,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Casting',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 350,
                    child: ListView.builder(
                      itemCount: newMovie!.casting!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, int index) {
                        return (newMovie!.casting![index].imageURL == null
                            ? const Center()
                            : CastingCard(person: newMovie!.casting![index]));
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Images du film',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: newMovie!.imagesMovie!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, int index) {
                        return (ImageMovieCard(
                            imageMoviePath: newMovie!.imagesMovie![index]));
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
