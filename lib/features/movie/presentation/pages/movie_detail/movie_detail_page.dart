import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn_flutter_clean_architecture/core/widgets/app_button.dart';
import 'package:learn_flutter_clean_architecture/features/movie/presentation/bloc/movie_cubit.dart';
import 'package:learn_flutter_clean_architecture/injection_container.dart';

class MovieDetailPage extends StatefulWidget {
  final int id;

  const MovieDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailPage> {
  MovieCubit _movieCubit = sl<MovieCubit>();

  @override
  void initState() {
    _movieCubit.getMovieDetail(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _movieCubit,
      listener: (context, state) {
        /*if (state is ToggleFavoritesSuccessful) {
          _movieCubit.getMovieDetail(widget.id);

          String message = state.movie != null
              ? "Berhasil menambahkan ke favorit"
              : "Berhasil menghapus dari favorit";
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
          ));
        } else if (state is ToggleFavoritesFailed) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Gagal toggle favorite'),
          ));
        }*/
      },
      child: BlocBuilder(
        bloc: _movieCubit,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFF25272A),
            body: _movieCubit.getMovieDetailLoading ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF04837C)),
              ),
            ) : SingleChildScrollView(
              child: Stack(
                children: [
                  _backdrop(),

                  // AppBar
                  SafeArea(
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 24,
                          color: Color(0xFF04837C),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4),
                    child: Column(
                      children: [
                        // Main Contents
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _movieCubit.movieDetail!.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 28,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700
                                ),
                              ),

                              const SizedBox(height: 9),

                              Row(
                                children: [
                                  Text(
                                    _movieCubit.movieDetail!.duration,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white.withOpacity(0.7)
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  SvgPicture.asset(
                                    'assets/icons/ic_hd_white.svg',
                                    height: 15,
                                    width: 15,
                                  )
                                ],
                              ),

                              const SizedBox(height: 13),

                              Row(
                                children: _movieCubit.movieDetail!.genres.split(',').asMap().entries.map((entry) {
                                  return Row(
                                    children: [
                                      Text(
                                        entry.value,
                                        style: const TextStyle(
                                            color: Colors.white
                                        ),
                                      ),
                                      entry.key != (_movieCubit.movieDetail!.genres.split(',').length-1) ? Container(
                                        width: 4, height: 4,
                                        margin: const EdgeInsets.symmetric(horizontal: 5),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFF04837C)
                                        ),
                                      ) : const SizedBox()
                                    ],
                                  );
                                }).toList(),
                              ),

                              const SizedBox(height: 24),

                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: AppButton(
                                        style: AppButtonStyle.primary,
                                        text: 'Watch Trailer',
                                        iconSvgUri: 'assets/icons/ic_play.svg',
                                        onPressed: () {}
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: AppButton(
                                        style: AppButtonStyle.secondary,
                                        text: _movieCubit.movieDetail!.isFavorite ? 'Remove Favorite' : 'Add to Favorite',
                                        iconSvgUri: 'assets/icons/ic_plus_primary.svg',
                                        onPressed: () {

                                        }
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 24),

                              Text(
                                _movieCubit.movieDetail?.overview ?? '',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.7)
                                ),
                              ),

                              const SizedBox(height: 32),

                              const Text(
                                'Cast',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Cast
                        SizedBox(
                            height: 160,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: _movieCubit.movieDetail!.casts.length,
                              padding: const EdgeInsets.only(left: 20),
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 14),
                                  child: Column(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: _movieCubit.movieDetail!.casts[index].photoUrl,
                                        imageBuilder: (context, imageProvider) => Container(
                                          width: 80.0,
                                          height: 80.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: imageProvider, fit: BoxFit.cover
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) => const SizedBox(
                                            height: 80,
                                            width: 80,
                                            child: Center(child: CircularProgressIndicator())
                                        ),
                                        errorWidget: (context, url, error) => Container(
                                            height: 80,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white.withOpacity(0.3)
                                            ),
                                            child: const Center(child: Icon(Icons.error))
                                        ),
                                      ),

                                      const SizedBox(height: 16),

                                      Text(
                                        _movieCubit.movieDetail!.casts[index].name,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _backdrop() {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: _movieCubit.movieDetail!.imageUrl,
          height: MediaQuery.of(context).size.height * 0.65,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.66,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.1, 0.4, 1],
                  colors: [
                    Color(0xFF25272A),
                    Color(0xFF25272A).withOpacity(0.6),
                    Colors.transparent
                  ]
              )
          ),
        ),
      ],
    );
  }
}