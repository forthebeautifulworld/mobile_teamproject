import 'package:flutter/material.dart';
import '../models/review.dart';

class ReviewWidget extends StatelessWidget {
  final Review review;
  final VoidCallback onLike;

  ReviewWidget({required this.review, required this.onLike});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Image.asset(review.profileImage,
            width: 50, height: 50, fit: BoxFit.cover),
        title: Row(
          children: [
            Icon(Icons.star, color: Colors.yellow, size: 16.0),
            SizedBox(width: 4.0),
            Text(review.rating.toString()),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                review.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        subtitle: Text(review.content),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                review.isLiked ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: onLike,
            ),
            Text(review.likes.toString()),
          ],
        ),
      ),
    );
  }
}