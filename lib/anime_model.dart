class AnimesResponse {
  final List<AnimeInfo> data;

  AnimesResponse({required this.data});

  factory AnimesResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<AnimeInfo> animeList = list.map((i) => AnimeInfo.fromJson(i)).toList();
    return AnimesResponse(data: animeList);
  }
}

class AnimeInfo {
  final Node node;

  AnimeInfo({required this.node});

  factory AnimeInfo.fromJson(Map<String, dynamic> json) {
    return AnimeInfo(
      node: Node.fromJson(json['node']),
    );
  }
}

class Node {
  final int id;
  final String title;
  final MainPicture mainPicture;
  final double? mean;

  Node({required this.id, required this.title, required this.mainPicture, this.mean});

  factory Node.fromJson(Map<String, dynamic> json) {
    return Node(
      id: json['id'],
      title: json['title'],
      mainPicture: MainPicture.fromJson(json['main_picture']),
      mean: json['mean']?.toDouble(),
    );
  }
}

class MainPicture {
  final String medium;
  final String large;

  MainPicture({required this.medium, required this.large});

  factory MainPicture.fromJson(Map<String, dynamic> json) {
    return MainPicture(
      medium: json['medium'],
      large: json['large'],
    );
  }
}