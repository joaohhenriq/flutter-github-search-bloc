class SearchItemModel {
  final String fullname;
  final String url;
  final String avatarUrl;

  SearchItemModel({this.fullname, this.avatarUrl, this.url});

  factory SearchItemModel.fromJson(Map<String, dynamic> json){
    return SearchItemModel(
      fullname: json["full_name"] as String,
      url: json["html_url"] as String,
      avatarUrl: (json["owner"] as Map<String, dynamic>)["avatar_url"] as String
    );
  }
}