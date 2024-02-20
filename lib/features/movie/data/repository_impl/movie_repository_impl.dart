import 'dart:io';

import 'package:dio/dio.dart';
import 'package:learn_flutter_clean_architecture/core/resources/data_state.dart';
import 'package:learn_flutter_clean_architecture/features/movie/data/data_sources/remote/movie_api_service.dart';
import 'package:learn_flutter_clean_architecture/features/movie/domain/entities/movie.dart';
import 'package:learn_flutter_clean_architecture/features/movie/domain/entities/movie_detail.dart';
import 'package:learn_flutter_clean_architecture/features/movie/domain/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieApiService _movieApiService;

  MovieRepositoryImpl(this._movieApiService);

  @override
  Future<DataState<List<Movie>>> getComingSoonMovieList() {
    // TODO: implement getComingSoonMovieList
    throw UnimplementedError();
  }

  @override
  Future<DataState<MovieDetail>> getMovieDetail(int id) async {
    try {
      final response = await _movieApiService.getMovieDetail(id: id.toString());
      if(response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(response.data.toDomain());
      } else {
        return DataFailed(
          DioException(
            error: response.response.statusMessage,
            response: response.response,
            type: DioErrorType.badResponse,
            requestOptions: response.response.requestOptions
          )
        );
      }
    } on DioException catch(e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<Movie>>> getMovieList() async {
    try {
      final response = await _movieApiService.getMovieList();
      if(response.response.statusCode == HttpStatus.ok) {
        List<Movie> res = [];
        if (response.data.results != null) {
          for (var e in response.data.results!) {
            res.add(e.toDomain());
          }
        }

        return DataSuccess(res);
      } else {
        return DataFailed(
          DioException(
            error: response.response.statusMessage,
            response: response.response,
            type: DioErrorType.badResponse,
            requestOptions: response.response.requestOptions
          )
        );
      }
    } on DioException catch(e) {
      return DataFailed(e);
    }
  }
}