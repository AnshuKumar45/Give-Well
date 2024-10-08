class CommentModels {
  final String profile;
  final String commentId;
  final String name;
  final String text;
  final List likes;
  final String datePublished;
  final String userId;
  final String fundId;
  const CommentModels({
    required this.commentId,
    required this.datePublished,
    required this.likes,
    required this.name,
    required this.profile,
    required this.text,
    required this.userId,
    required this.fundId,
  });

  Map<String, dynamic> toJson() => {
        "profile": profile,
        "commentId": commentId,
        "userName": name,
        "comment": text,
        "like": likes,
        "userId": userId,
        "publishDate": datePublished,
        "fundId": fundId,
      };
}
