class AdminPostModel {
  final String id;
  final String authorName;
  final String avatarUrl;
  final String contentSnippet;
  final String fullContent;
  final int likes;
  final int commentsCount;
  final String postDate;
  final bool isReported;

  AdminPostModel({
    required this.id,
    required this.authorName,
    required this.avatarUrl,
    required this.contentSnippet,
    required this.fullContent,
    required this.likes,
    required this.commentsCount,
    required this.postDate,
    this.isReported = false,
  });
}
