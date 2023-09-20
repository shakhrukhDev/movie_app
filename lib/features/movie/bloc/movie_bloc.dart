import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/features/movie/data/model/movie_response.dart';
import 'package:movie_app/features/movie/data/model/movies_response.dart';
import 'package:movie_app/features/movie/domain/repository/movies_repository.dart';

part 'movie_event.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(const MovieState()) {
    on<GetMoviesEvent>(_getMovies);
    on<GetMovieIdEvent>(_movieId);
  }

  final _moviesRepository = MoviesRepository();

  Future<void> _getMovies(
      GetMoviesEvent event, Emitter<MovieState> emit) async {
    final result = await _moviesRepository.getMovies();

    emit(state.copyWith(
      movies: result,
    ));
  }

  Future<void> _movieId(GetMovieIdEvent event, Emitter<MovieState> emit) async {
    final result = await _moviesRepository.getmovieId(event.id);

    emit(state.copyWith(movie: result));
  }
}
