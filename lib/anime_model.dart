class AnimeInfo {
  final int id;
  final String title;
  final MainPicture? mainPicture;
  double? mean;

  AnimeInfo({
    required this.id,
    required this.title,
    this.mainPicture,
    this.mean,
  });

  factory AnimeInfo.fromJson(Map<String, dynamic> json) {
    return AnimeInfo(
      id: json['node']['id'],
      title: json['node']['title'],
      mainPicture: json['node']['main_picture'] != null
          ? MainPicture.fromJson(json['node']['main_picture'])
          : null,
    );
  }

  void updateMean(double? newMean) {
    mean = newMean;
  }
}

class MainPicture {
  final String? medium;
  final String? large;

  MainPicture({this.medium, this.large});

  factory MainPicture.fromJson(Map<String, dynamic> json) {
    return MainPicture(
      medium: json['medium'],
      large: json['large'],
    );
  }
}