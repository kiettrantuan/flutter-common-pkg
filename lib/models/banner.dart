import 'package:f_common_package_1/models/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'banner.g.dart';

@JsonSerializable()
class Banner extends Model {
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

  @override
  Map<String, dynamic> toJson() => _$BannerToJson(this);

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
