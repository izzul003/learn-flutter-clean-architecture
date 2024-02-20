part of 'movie_cubit.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class GetMovieLoading extends MovieState {}

class GetMovieSuccessful extends MovieState {
  final List<Movie> movie;

  const GetMovieSuccessful(this.movie);
}

class GetMovieFailed extends MovieState {
  final DioException dioException;

  const GetMovieFailed(this.dioException);
}

class GetMovieDetailInit extends MovieState {}

class GetMovieDetailSuccessful extends MovieState {}

class GetMovieDetailFailed extends MovieState {
  final DioException dioException;

  const GetMovieDetailFailed(this.dioException);
}
