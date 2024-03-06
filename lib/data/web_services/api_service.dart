import 'package:watchnow_app/data/models/tv_show.dart';

import 'dio_utlis.dart';

class ApiService {
  final dio = DioUtil().getInstance();

  Future<List<TvShow>> getAllTvShows() async {
    try {
      final response = await dio.get('/most-popular?page=1');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final List<dynamic> results = data['tv_shows'];
        return results.map((e) => TvShow.fromJson(e)).toList();
      } else if (response.statusCode == 403) {
        return throw Exception();
      } else {
        throw Exception('Si è verificato un errore');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
