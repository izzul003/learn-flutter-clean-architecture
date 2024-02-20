import 'package:dio/dio.dart';
import 'response/movie_detail_response.dart';
import 'package:retrofit/retrofit.dart';
import 'response/movie_response.dart';

part 'movie_api_service.g.dart';

@RestApi(baseUrl: 'https://api.themoviedb.org/3/')
abstract class MovieApiService {
  factory MovieApiService(Dio dio) = _MovieApiService;

  static const String _apiKey = 'd4bee1442fda04e0b421566f1a54e4ae';

  @GET('/movie/popular')
  Future<HttpResponse<MovieResponse>> getMovieList({
    @Query("api_key") String? apiKey = _apiKey,
    @Query("language") String? language = 'enUS',
    @Query("sort_by") String? sortBy = 'popularity.asc',
    @Query("include_adult") bool? includeAdult = false,
    @Query("include_video") bool? category = false,
    @Query("page") int? page = 1,
    @Query("with_genres") bool? withGenres = true,
  });

  @GET('movie/{id}')
  Future<HttpResponse<MovieDetailResponse>> getMovieDetail({
    @Path("id") required String id,
    @Query("api_key") String? apiKey = _apiKey,
  });
}