class PostModel {
  final String id;
  final String content;
  final List<String> images;
  final String creatorUid;
  final String creator;
  final int createdAt;
  final int like;

  PostModel({
    required this.id,
    required this.content,
    required this.images,
    required this.creatorUid,
    required this.creator,
    required this.createdAt,
    required this.like,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "content": content,
      "images": images,
      "creatorUid": creatorUid,
      "creator": creator,
      "createdAt": createdAt,
      "like": like
    };
  }

  PostModel.fromJson(
      {required Map<String, dynamic> json, required String postId})
      : id = postId,
        content = json["content"],
        images = List<String>.from(json["images"]),
        creatorUid = json["creatorUid"],
        creator = json["creator"],
        like = json["like"],
        createdAt = json["createdAt"];

  PostModel copyWith({
    String? id,
    String? emotionName,
    String? userId,
    String? content,
    List<String>? images,
    int? createdAt,
  }) {
    return PostModel(
      like: like ?? like,
      id: id ?? this.id,
      creatorUid: creatorUid ?? creatorUid,
      creator: creator ?? creator,
      content: content ?? this.content,
      images: images ?? this.images,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
