import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_flutter_clean_architecture/features/movie/presentation/bloc/movie_cubit.dart';
import 'package:learn_flutter_clean_architecture/features/movie/presentation/pages/movie_detail/movie_detail_page.dart';
import 'package:learn_flutter_clean_architecture/features/movie/presentation/widgets/movie_thumbnail.dart';
import 'package:learn_flutter_clean_architecture/injection_container.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  MovieCubit movieCubit = sl<MovieCubit>();

  @override
  void initState() {
    movieCubit.getMovieList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: movieCubit,
      listener: (_, state) {

      },
      child: BlocBuilder(
        bloc: movieCubit,
        builder: (context, MovieState state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Movie Bro'),
            ),
            body: _buildBody(state),
          );
        },
      ),
    );
  }

  Widget _buildBody(MovieState state) {
    if (state is GetMovieLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is GetMovieFailed) {
      return const Text('Error');
    } else if (state is GetMovieSuccessful) {
      if (state.movie.isEmpty) {
        return const Center(
          child: Text(
            'Tidak ada daftar film',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white
            ),
          ),
        );
      }

      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: state.movie.length,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          itemBuilder: (context, index) {
            return MovieThumbnail(
              imageUrl: state.movie[index].imageUrl,
              title: state.movie[index].title,
              year: state.movie[index].year,
              genres: state.movie[index].genres,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => MovieDetailPage(
                    id: state.movie[index].id,
                  )
                ));
              },
              onToggle: () {

              },
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }
}
