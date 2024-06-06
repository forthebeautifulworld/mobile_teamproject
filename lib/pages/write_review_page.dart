import 'package:flutter/material.dart';
import '../models/review.dart';

class WriteReviewPage extends StatefulWidget {
  @override
  _WriteReviewPageState createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends State<WriteReviewPage> {
  double rating = 0.0;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("커뮤니티 글 작성"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.yellow,
                  ),
                  onPressed: () {
                    setState(() {
                      rating = index + 1.0;
                    });
                  },
                );
              }),
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: '제목을 입력해주세요.'),
            ),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: '내용을 입력해주세요.'),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newReview = Review(
                  profileImage: 'assets/images/default_profile.jpeg',
                  rating: rating,
                  title: titleController.text,
                  content: contentController.text,
                  likes: 0,
                );
                Navigator.pop(context, newReview);
              },
              child: const Text('완료'),
            ),
          ],
        ),
      ),
    );
  }
}
