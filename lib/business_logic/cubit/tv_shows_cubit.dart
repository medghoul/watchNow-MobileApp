import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:watchnow_app/data/models/tv_show.dart';

import '../../data/web_services/api_service.dart';

part 'tv_shows_state.dart';

class TvShowsCubit extends Cubit<TvShowsState> {
  final apiService = ApiService();

  TvShowsCubit() : super(TvShowsInitial()) {
    loadTvShows();
  }

  List<TvShow> tvShows = [];

  Future<void> loadTvShows() async {
    try {
      emit(TvShowsInitial());
      tvShows = await apiService.getAllTvShows();
      emit(TvShowsLoaded(tvShows));
    } on Exception catch (e) {
      emit(TvShowsError(e.toString()));
    }
  }

}



