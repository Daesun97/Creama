// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostModelImpl _$$PostModelImplFromJson(Map<String, dynamic> json) =>
    _$PostModelImpl(
      id: json['id'] as String,
      content: json['content'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      creatorUid: json['creatorUid'] as String,
      creator: json['creator'] as String,
      createdAt: (json['createdAt'] as num).toInt(),
      like: (json['like'] as num).toInt(),
    );

Map<String, dynamic> _$$PostModelImplToJson(_$PostModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'images': instance.images,
      'creatorUid': instance.creatorUid,
      'creator': instance.creator,
      'createdAt': instance.createdAt,
      'like': instance.like,
    };
