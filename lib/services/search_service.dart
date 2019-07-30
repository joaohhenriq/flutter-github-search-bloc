import 'package:dio/dio.dart';
import 'package:flutter_github_search_bloc/models/search_result_model.dart';

class SearchService{
  final Dio dio = new Dio();

  Future<SearchResultModel> search(String text) async{

    // dio já retorna a resposta em mapa de String, dynamic
    // então não precisa de json decode para fazer o parse da resposta
    Response res = await dio.get("https://api.github.com/search/repositories?q=${text}");

    return SearchResultModel.fromJson(res.data);
  }
}