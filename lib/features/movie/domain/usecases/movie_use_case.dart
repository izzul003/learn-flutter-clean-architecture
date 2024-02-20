import 'package:learn_flutter_clean_architecture/core/resources/data_state.dart';
import 'package:learn_flutter_clean_architecture/features/movie/domain/entities/movie.dart';
import 'package:learn_flutter_clean_architecture/features/movie/domain/entities/movie_detail.dart';

abstract class MovieUseCase {
  Future<DataState<List<Movie>>> getMovieList();
  Future<DataState<List<Movie>>> getComingSoonMovieList();
  Future<DataState<MovieDetail>> getMovieDetail(int id);
}