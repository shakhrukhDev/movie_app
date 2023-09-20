import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movie/bloc/movie_bloc.dart';
import 'package:movie_app/features/movie/detail/detail_page.dart';

class FilmsListWidget extends StatelessWidget {
  const FilmsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var media=MediaQuery.of(context).size;
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: state.movie?.similarMovies?.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: media.height * 150 / 812,
                child: Column(
                  children: [
                    SizedBox(
                      height: media.height * 250 / 812,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailPage(),
                              ));
                          context.read<MovieBloc>().add(
                              GetMovieIdEvent(state.movie
                                  ?.similarMovies?[index].id
                                  .toString() ??
                                  ''));
                        },
                        child: CachedNetworkImage(
                          imageUrl: state
                              .movie
                              ?.similarMovies?[index]
                              .poster
                              ?.previewUrl ??
                              '',
                          fit: BoxFit.fitHeight,
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                      ),
                    ),
                    Text(
                      state.movie?.similarMovies?[index].name ?? '',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
