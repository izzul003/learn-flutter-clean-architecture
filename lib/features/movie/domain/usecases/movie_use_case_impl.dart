import 'package:learn_flutter_clean_architecture/core/resources/data_state.dart';

import 'package:learn_flutter_clean_architecture/features/movie/domain/entities/movie.dart';

import 'package:learn_flutter_clean_architecture/features/movie/domain/entities/movie_detail.dart';
import 'package:learn_flutter_clean_architecture/features/movie/domain/repository/movie_repository.dart';

import 'movie_use_case.dart';

class MovieUseCaseImpl implements MovieUseCase {
  final MovieRepository _movieRepository;

  MovieUseCaseImpl(this._movieRepository);

  @override
  Future<DataState<List<Movie>>> getComingSoonMovieList() {
    return _movieRepository.getComingSoonMovieList();
  }

  @override
  Future<DataState<MovieDetail>> getMovieDetail(int id) {
    return _movieRepository.getMovieDetail(id);
  }

  @override
  Future<DataState<List<Movie>>> getMovieList() {
    return _movieRepository.getMovieList();
  }
}