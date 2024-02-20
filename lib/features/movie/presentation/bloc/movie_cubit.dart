import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:learn_flutter_clean_architecture/core/resources/data_state.dart';
import 'package:learn_flutter_clean_architecture/features/movie/domain/entities/movie.dart';
import 'package:learn_flutter_clean_architecture/features/movie/domain/entities/movie_detail.dart';
import 'package:learn_flutter_clean_architecture/features/movie/domain/usecases/movie_use_case.dart';

part 'package:learn_flutter_clean_architecture/features/movie/presentation/bloc/movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieUseCase _movieUseCase;

  MovieCubit(this._movieUseCase) : super(MovieInitial());

  void getMovieList() async {
    emit(GetMovieLoading());

    final dataState = await _movieUseCase.getMovieList();

    if (dataState is DataSuccess) {
      emit(GetMovieSuccessful(dataState.data ?? []));
    }

    if (dataState is DataFailed) {
      emit(GetMovieFailed(dataState.error!));
    }
  }


  MovieDetail? movieDetail;
  bool getMovieDetailLoading = false;
  void getMovieDetail(int id) async {
    getMovieDetailLoading = true;
    emit(GetMovieDetailInit());

    final dataState = await _movieUseCase.getMovieDetail(id);
    getMovieDetailLoading = false;

    if (dataState is DataSuccess) {
      movieDetail = dataState.data!;
      emit(GetMovieDetailSuccessful());
    }

    if (dataState is DataFailed) {
      emit(GetMovieDetailFailed(dataState.error!));
    }
  }
}