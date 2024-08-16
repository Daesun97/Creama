// class PostModel {
//   final String id;
//   final String content;
//   final List<String> images;
//   final String creatorUid;
//   final String creator; //유저닉네임
//   final int createdAt;
//   final int like;

//   PostModel({
//     required this.id,
//     required this.content,
//     required this.images,
//     required this.creatorUid,
//     required this.creator,
//     required this.createdAt,
//     required this.like,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       "id": id,
//       "content": content,
//       "images": images,
//       "creatorUid": creatorUid,
//       "creator": creator,
//       "createdAt": createdAt,
//       "like": like
//     };
//   }

//   PostModel.fromJson(
//       {required Map<String, dynamic> json, required String postId})
//       : id = postId,
//         content = json["content"],
//         images = List<String>.from(json["images"]),
//         creatorUid = json["creatorUid"],
//         creator = json["creator"],
//         like = json["like"],
//         createdAt = json["createdAt"];

//   PostModel copyWith({
//     int? like,
//     String? id,
//     String? userId,
//     String? content,
//     List<String>? images,
//     int? createdAt,
//   }) {
//     return PostModel(
//       like: like ?? this.like,
//       id: id ?? this.id,
//       creatorUid: creatorUid ?? creatorUid,
//       creator: creator ?? creator,
//       content: content ?? this.content,
//       images: images ?? this.images,
//       createdAt: createdAt ?? this.createdAt,
//     );
//   }
// }

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
class PostModel with _$PostModel {
  const factory PostModel({
    required String id,
    required String content,
    required List<String> images,
    required String creatorUid,
    required String creator, // 유저닉네임
    required int createdAt,
    required int like,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}
