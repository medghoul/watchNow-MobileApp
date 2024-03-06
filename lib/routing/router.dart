import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchnow_app/business_logic/cubit/tv_shows_cubit.dart';
import 'package:watchnow_app/data/web_services/api_service.dart';
import 'package:watchnow_app/routing/routes.dart';

import '../presentation/screens/HomeScreen/home_screen.dart';
import '../presentation/screens/TvShowsSreens/tv_show_detail_screen.dart';
import '../presentation/screens/TvShowsSreens/tv_shows_screen.dart';

class AppRouter {
  late TvShowsCubit tvShowsCubit;
  late ApiService apiService;

  AppRouter() {
    apiService = ApiService();
    tvShowsCubit = TvShowsCubit();
  }


  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreenRoute:
        return _getPageRoute(const HomeScreen());
      case tvShowsScreenRoute:
        return _getPageRoute(BlocProvider(create: (context) => tvShowsCubit..tvShows, child: const TvShowsScreen()) );
      case tvShowDetailsScreenRoute:
        return _getPageRoute(const TvShowDetailScreen());
      default:
        return _getPageRoute(const HomeScreen());
    }
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(
      builder: (context) => child, settings: const RouteSettings());
}
