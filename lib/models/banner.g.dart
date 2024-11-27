// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Banner _$BannerFromJson(Map<String, dynamic> json) => Banner(
      id: json['id'] as String,
      imageUrl: json['download_url'] as String,
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
      author: json['author'] as String,
    );

Map<String, dynamic> _$BannerToJson(Banner instance) => <String, dynamic>{
      'id': instance.id,
      'download_url': instance.imageUrl,
      'width': instance.width,
      'height': instance.height,
      'author': instance.author,
    };
