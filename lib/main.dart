import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_flutter_clean_architecture/config/routes/routes.dart';
import 'package:learn_flutter_clean_architecture/config/theme/app_theme.dart';
import 'package:learn_flutter_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:learn_flutter_clean_architecture/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:learn_flutter_clean_architecture/features/movie/presentation/pages/movie_list/movie_list_page.dart';
import 'package:learn_flutter_clean_architecture/injection_container.dart';

import 'features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}): super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticlesBloc>(
      create: (context) => sl()..add(const GetArticles()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: const DailyNews(),
      ),
    );
  }
}
