import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_flutter_clean_architecture/core/resources/data_state.dart';
import 'package:learn_flutter_clean_architecture/features/daily_news/data/models/article.dart';
import 'package:learn_flutter_clean_architecture/features/daily_news/domain/usecases/get_article.dart';
import 'package:learn_flutter_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:learn_flutter_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

class RemoteArticlesBloc extends Bloc<RemoteArticlesEvent, RemoteArticlesState>{
  final GetArticleUseCase _getArticleUseCase;

  RemoteArticlesBloc(this._getArticleUseCase) : super(const RemoteArticlesLoading()){
    on <GetArticles> (onGetArticles);
  }


  void onGetArticles(GetArticles event, Emitter < RemoteArticlesState > emit) async {
    final dataState = await _getArticleUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      print(dataState.data);

      emit(
          RemoteArticlesDone(dataState.data!)
      );
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(
          RemoteArticlesError(dataState.error!)
      );
    }
  }
}