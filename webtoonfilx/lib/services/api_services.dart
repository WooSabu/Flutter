//Flutter widget이나 class가 아닌 평범한 Dart class 만들 것
//fetching Data Part(Using API source)

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoonfilx/models/webtoon_detail.dart';
import 'package:webtoonfilx/models/webtoon_episode.dart';
import 'package:webtoonfilx/models/webtoon_models.dart';

class ApiService {
  static const String baseUrl =
      'https://webtoon-crawler.nomadcoders.workers.dev'; //네이버 웹툰 API(교육용)
  static const String today = 'today';

  //await 함수는 async function 안에서만 실행 가능함!
  // function이름 뒤에 'async'를 붙이면 async 함수 설정 가능
  static Future<List<WebToonModel>> getTodaysToons() async {
    List<WebToonModel> webtoonsInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //response에 대한 statusCode가 200일때, body 출력.(statusCode 200은 요청이 성공했다는 뜻)
      //response.body에는 서버가 보낸 데이터가 들어있음
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        final toon = WebToonModel.fromJson(webtoon);
        webtoonsInstances.add(toon);
      }
      return webtoonsInstances;
    }
    throw Error();
  }

  static Future<WebToonDetail> getToonById(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebToonDetail.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebToonEpisode>> getLatestEpisodesById(String id) async {
    List<WebToonEpisode> episodesInstances = [];
    final url = Uri.parse("$baseUrl/$id/episodes");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodesInstances.add(WebToonEpisode.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }
}
