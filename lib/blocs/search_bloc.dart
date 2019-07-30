import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_github_search_bloc/models/search_result_model.dart';
import 'package:flutter_github_search_bloc/services/search_service.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends BlocBase {

  SearchService _searchService = new SearchService();

  final _searchController = new BehaviorSubject<String>();

  Observable<String> get outSearchStream => _searchController.stream;

  Sink<String> get outSearchSink => _searchController.sink;

  Observable<SearchResultModel> apiResult;

  SearchBloc() {
    apiResult = outSearchStream
    // faz com que a stream só receba valores distintos,
    // se o último valor for igual ao penúltimo, será ignorado
        .distinct()
    // atribuição somente é feita se passar no teste do where
    // no caso, somente quando o usuário digitar mais que dois dígitos
        .where((value) => value.length > 2)
    // converte um tipo de dado em outro
    // assim como aguardar uma future, que será a pesquisa das informações
        .asyncMap(_searchService.search)
    // usado para receber somente o último estado da chamada da api
    // vai ouvir sempre o valor mais atual retornado para o asyncMap
        .switchMap((value) => Observable.just(value));
  }

  @override
  void dispose() {
    _searchController.close();
    super.dispose();
  }


}