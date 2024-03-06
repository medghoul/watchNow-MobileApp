import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchnow_app/data/models/tv_show.dart';
import '../../../constants/styles.dart';
import '../../../business_logic/cubit/tv_shows_cubit.dart';
import '../../widgets/tv_show_item.dart';

class TvShowsScreen extends StatefulWidget {
  const TvShowsScreen({Key? key}) : super(key: key);

  @override
  _TvShowsScreenState createState() => _TvShowsScreenState();
}

class _TvShowsScreenState extends State<TvShowsScreen> {
  late List<TvShow> tvShows;
  List<TvShow> filteredTvShows=[];
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TvShowsCubit>(context).loadTvShows().then((_) {
      tvShows = BlocProvider.of<TvShowsCubit>(context).tvShows;
    });
  }

  Widget buildBlocWidget() {
    return BlocBuilder<TvShowsCubit, TvShowsState>(
      builder: (context, state) {
        if (state is TvShowsLoaded) {
          tvShows = state.tvShows;
          return buildLoadedListWidgets();
        } else if (state is TvShowsError) {
          return const Center(
            child: Text('Error'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  buildLoadedListWidgets() {
    return SingleChildScrollView(
        child: Container(
            color: grey,
            child: Column(children: [
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: white,
                ),
                child: TextField(
                  controller: _searchTextController,
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) => {
                    _search(value),
                  },

                ),
              ),
              buildCharactersList(),
            ])));
  }

  void _search(value){
    if(value.isEmpty){
      setState(() {
        _isSearching = false;
        filteredTvShows = tvShows;
      });
      return;
    }else {
      setState(() {
        _isSearching = true;
        filteredTvShows = tvShows
            .where((tvShow) =>
            tvShow.name
                .toLowerCase()
                .contains(value.toLowerCase()))
            .toList();
      });
    }
  }

  buildCharactersList() {
    if (_isSearching) {
      filteredTvShows = tvShows.where((tvShow) =>
          tvShow.name.toLowerCase().contains(_searchTextController.text.toLowerCase()))
          .toList();
      return buildTvShowsList(filteredTvShows);
    } else {
      return buildTvShowsList(tvShows);
    }

  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            setState(() {
              _searchTextController.clear();
              Navigator.pop(context);
            });
          },
        ),
      ];
    } else {
      return [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: _startSearch,
        ),
      ];
    }
  }

  Widget _buildAppBarTitle() {
    return const Text('Tv Shows');
  }

  _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  _stopSearching() {
    _clearSearchQuery();
    setState(() {
      _isSearching = false;
    });
  }

  _clearSearchQuery() {
    setState(() {
      _searchTextController.clear();
    });
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search for Tv Shows...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (value) => {
        _search(value),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: yellow,
        actions: _buildAppBarActions(),
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        leading: _isSearching ? const BackButton(color: white) : Container()
      ),
      body: buildBlocWidget(),
    );
  }

  buildTvShowsList(listTvShows) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 1.0,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(8.0),
        itemCount: listTvShows.length,
        itemBuilder: (context, index) {
          return TvShowItem(tvShow: listTvShows[index]);
        });
  }
}
