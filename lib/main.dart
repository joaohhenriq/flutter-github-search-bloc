import 'package:flutter/material.dart';
import 'package:flutter_github_search_bloc/pages/details_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'blocs/search_bloc.dart';
import 'models/search_item_model.dart';
import 'models/search_result_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SearchBloc _searchBloc;

  // initState executa somente uma vez, antes do componente ser montado
  @override
  void initState() {
    _searchBloc = new SearchBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Github Search"),
              SizedBox(
                width: 10,
              ),
              Icon(FontAwesomeIcons.github)
            ],
          ),
          backgroundColor: Colors.black87,
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            margin: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.black.withOpacity(0.7),
            ),
            child: Column(
              children: <Widget>[
                _searchField(),
                Expanded(
                  child: StreamBuilder<SearchResultModel>(
                      stream: _searchBloc.apiResult,
                      builder: (context, snapshot) {
                        if(!snapshot.hasData){
                          return Center(child: CircularProgressIndicator(),);
                        } else if(snapshot.data.items == null){
                          return Center(
                            child: Text("No projects found!"),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: snapshot.data.items.length,
                          itemBuilder: (context, index) {
                            SearchItemModel item = snapshot.data.items[index];
                            return buildItems(item);
                          },
                        );
                      }),
                )
              ],
            ),
          ),
        ));
  }

  Widget _searchField() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Material(
          color: Colors.white,
          elevation: 2,
          shadowColor: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: TextField(
            onChanged: _searchBloc.outSearchSink.add,
            cursorColor: Colors.black87,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter a repository name",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                suffixIcon: Material(
                  elevation: 0.0,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Icon(
                    Icons.search,
                    color: Colors.black87,
                  ),
                )),
          ),
        ));
  }

  Widget buildItems(SearchItemModel item) {
    return ListTile(
      leading: Hero(
        tag: item.url,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(item?.avatarUrl ??
              "https://d2v9y0dukr6mq2.cloudfront.net/video/thumbnail/VCHXZQKsxil3lhgr4/animation-loading-circle-icon-on-white-background-with-alpha-channel-4k-video_sjujffkcde_thumbnail-full01.png"),
        ),
      ),
      title: Text(item?.fullname ?? "title", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
      subtitle: Text(item?.url ?? "url", style: TextStyle(color: Colors.grey),),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(item: item,)));
      },
    );
  }
}
