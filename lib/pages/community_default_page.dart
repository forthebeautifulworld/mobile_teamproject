import 'package:flutter/material.dart';
import '../models/review.dart';
import '../pages/write_review_page.dart';
import '../widgets/review_widget.dart';

class CommunityPage_default extends StatefulWidget {
  @override
  _CommunityPageDefaultState createState() => _CommunityPageDefaultState();
}

class _CommunityPageDefaultState extends State<CommunityPage_default> {
  List<Review> reviews = [
    Review(
        profileImage: 'assets/images/default_profile.jpeg',
        rating: 4.0,
        title: '첫 커뮤니티 글을 작성해주세요',
        content: '',
        likes: 0,
        isLiked: false),
  ];

  void _addReview(Review review) {
    setState(() {
      reviews.insert(0, review);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return ReviewWidget(
                  review: reviews[index],
                  onLike: () {
                    setState(() {
                      reviews[index].isLiked = !reviews[index].isLiked;
                      reviews[index].isLiked
                          ? reviews[index].likes += 1
                          : reviews[index].likes -= 1;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WriteReviewPage()),
          );
          if (result != null && result is Review) {
            _addReview(result);
          }
        },
        child: const Text('글쓰기'),
      ),
    );
  }
}
