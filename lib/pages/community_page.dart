//community_page.dart
import 'package:flutter/material.dart';
import '../models/review.dart';
import '../pages/write_review_page.dart';
import '../widgets/review_widget.dart';

class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  List<Review> reviews = [
    Review(
        profileImage: 'assets/images/profile1.png',
        rating: 4.0,
        title: '사장님이 너무 친절해요!',
        content: '음식도 맛있고 알바생분들도 너무 이뻐요!',
        likes: 20),
    Review(
        profileImage: 'assets/images/profile2.png',
        rating: 2.0,
        title: '화장실 잠금장치 ㅠㅠ',
        content: '화장실 문 안잠겨요 고쳐주세요 ㅠㅠ',
        likes: 99),
    Review(
        profileImage: 'assets/images/profile3.png',
        rating: 5.0,
        title: '아이고 사장님',
        content: '서비스를 너무 많이 주셨어요 ㅠㅠㅠㅠ',
        likes: 5),
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
                      reviews[index].likes += 1;
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
