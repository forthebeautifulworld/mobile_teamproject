class Review {
  final String profileImage;
  final double rating;
  final String title;
  final String content;
  int likes;

  Review({
    required this.profileImage,
    required this.rating,
    required this.title,
    required this.content,
    required this.likes,
  });
}
