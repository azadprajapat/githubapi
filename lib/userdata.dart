
class profile{
  final int id;
  final int repo_length;
  profile({this.id,this.repo_length});

  factory profile.fromJson(Map<String, dynamic> json) {
    return profile(id: json['id'],repo_length: json['public_repos']);

  }

}