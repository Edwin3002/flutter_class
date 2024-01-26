import 'package:equatable/equatable.dart';

class Images extends Equatable {
  String id;
  String slug;
  String description;
  Urls urls;
  int likes;

  Images({
    required this.id,
    required this.slug,
    required this.description,
    required this.urls,
    required this.likes,
  });
  @override
  List<Object> get props => [
        id,
        slug,
        description,
        urls,
        likes,
      ];
}

class Urls {
  String raw;
  String full;
  String regular;
  String small;
  String thumb;
  String smallS3;

  Urls({
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
    required this.smallS3,
  });

  static jsonToEntity(Map<String, dynamic> json) => Urls(
        raw: json["raw"],
        full: json["full"],
        regular: json["regular"],
        small: json["small"],
        thumb: json["thumb"],
        smallS3: json["small_s3"],
      );
}

class ImagesMapper {
  static jsonToEntity(Map<String, dynamic> json) => Images(
        id: json["id"],
        slug: json["slug"],
        description: json["description"] ?? "",
        urls: Urls.jsonToEntity(json["urls"]),
        likes: json["likes"],
      );
}
