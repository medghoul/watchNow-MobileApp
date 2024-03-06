import 'package:flutter/material.dart';
import 'package:watchnow_app/data/models/tv_show.dart';
import '../../constants/images.dart';
import '../../constants/styles.dart';

class TvShowItem extends StatelessWidget {
  final TvShow tvShow;

  const TvShowItem({Key? key, required this.tvShow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
        padding: const EdgeInsetsDirectional.all(8),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: black,
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: GridTile(
          footer: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            alignment: Alignment.bottomCenter,
            child: ListTile(
              title: Text(
                tvShow.name,
                style: const TextStyle(
                    color: black,
                    height: 1.3,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              subtitle:
              Text(
                'Status: ${tvShow.status}',
                style: const TextStyle(color: black),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
        ),
        child: Container(
          color: grey,
          child: tvShow.image.isNotEmpty
              ? FadeInImage(
            placeholder: AssetImage(loadingImage),
            image: NetworkImage(tvShow.image),
            fit: BoxFit.cover,
          )
              : Image.asset(
            noImage,
            fit: BoxFit.cover,
          ),
        ))
    ,
    );
  }
}
