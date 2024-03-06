part of 'tv_shows_cubit.dart';

@immutable
abstract class TvShowsState {}

class TvShowsInitial extends TvShowsState {}

class TvShowsLoaded extends TvShowsState {
  final List<TvShow> tvShows;
  TvShowsLoaded(this.tvShows);
}

class TvShowsError extends TvShowsState {
  final String message;
  TvShowsError(this.message);
}
