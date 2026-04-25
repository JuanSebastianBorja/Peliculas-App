import 'package:flutter/material.dart';
import 'package:peliculas_app/screens/movie_search_delegate.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:peliculas_app/widgets/card_swiper.dart';
import 'package:peliculas_app/widgets/movie_slider.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en Cartelera'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              final movie = await showSearch<Movie?>(
                context: context,
                delegate: MovieSearchDelegate(),
              );

              if (movie == null || !context.mounted) return;

              Navigator.pushNamed(context, 'details', arguments: movie);
            },
            icon: const Icon(Icons.search_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(movies: moviesProvider.onDisplayMovies),
            //listado de peliculas horizontal
            MovieSlider(movies: moviesProvider.popularMovies),
          ],
        ),
      ),
    );
  }
}
