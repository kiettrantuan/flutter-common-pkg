import 'package:f_common_package_1/models/banner.dart';
import 'package:json_annotation/json_annotation.dart';

class BannerListConverter extends JsonConverter<List<Banner>, List<dynamic>> {
  @override
  List<Banner> fromJson(List<dynamic> json) {
    return json
        .map((item) => Banner.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  List<dynamic> toJson(List<Banner> object) {
    return object.map((banner) => banner.toJson()).toList();
  }
}
