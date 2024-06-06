class Review {
  final String profileImage;
  final double rating;
  final String title;
  final String content;
  int likes;
  bool isLiked; // Add this line

  Review({
    required this.profileImage,
    required this.rating,
    required this.title,
    required this.content,
    required this.likes,
    this.isLiked = false, // Initialize isLiked to false
  });
}