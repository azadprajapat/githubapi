class RepoList{
  String name;
  String url;
  RepoList(this.name,this.url);
  RepoList.fromJson(Map<String, dynamic> json) {
     name=json['name'];
     url=json['html_url'];
  }
}