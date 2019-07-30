import 'package:flutter_github_search_bloc/models/search_item_model.dart';

class SearchResultModel {
  final List<SearchItemModel> items;

  SearchResultModel(this.items);

  factory SearchResultModel.fromJson(Map<String, dynamic> json){
    // 1º faz cast do items para uma lista
    // 2° faz o cast de cada item da lista para Map<String, dynamic>
    // 3º converte cada item para o objeto da classe SearchItemModel
    final listItems = (json["items"] as List).cast<Map<String, dynamic>>()?.map((item){
      return SearchItemModel.fromJson(item);
    })?.toList();

    return SearchResultModel(listItems);
  }
}