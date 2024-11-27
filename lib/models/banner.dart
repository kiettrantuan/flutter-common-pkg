import 'package:json_annotation/json_annotation.dart';

part 'banner.g.dart';

@JsonSerializable()
class Banner {
  final String id;
  @JsonKey(name: 'download_url')
  final String imageUrl;
  final int width;
  final int height;
  final String author;

  Banner({
    required this.id,
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.author,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => _$BannerFromJson(json);

  Map<String, dynamic> toJson() => _$BannerToJson(this);

  // factory Banner.fromJson(Map<String, dynamic> json) {
  //   return Banner(
  //     id: json['id'] ?? "",
  //     imageUrl: json['download_url'] ?? "",
  //     width: json['width'] ?? 0,
  //     height: json['height'] ?? 0,
  //     author: json['author'] ?? "",
  //   );
  // }

  Banner copyWith({
    String? id,
    String? imageUrl,
    int? width,
    int? height,
    String? author,
  }) {
    return Banner(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      width: width ?? this.width,
      height: height ?? this.height,
      author: author ?? this.author,
    );
  }
}

// {
// "id": "",
// "author": "",
// "width": 0,
// "height": 0,
// "url": "",
// "download_url": ""
// }
