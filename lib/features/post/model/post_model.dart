class PostModel {
  final String id;
  final String content;
  final List<String> images;
  final String creatorUid;
  final String creator;
  final int createdAt;
  final int like;

  PostModel({
    required this.like,
    required this.id,
    required this.content,
    required this.images,
    required this.creatorUid,
    required this.creator,
    required this.createdAt,
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

  PostModel.fromJson({required Map<String, dynamic> json})
      : id = json["id"],
        content = json["content"],
        images = List<String>.from(json["images"]),
        creatorUid = json["creatorUid"],
        creator = json["creator"],
        like = json["like"],
        createdAt = json["createdAt"];
}
