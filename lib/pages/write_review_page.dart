import 'package:flutter/material.dart'; // Flutter의 기본 위젯 패키지를 가져옴
import '../models/review.dart'; // Review 모델을 가져옴

// 글 작성 페이지의 상태를 유지하는 StatefulWidget 클래스
class WriteReviewPage extends StatefulWidget {
  @override
  _WriteReviewPageState createState() => _WriteReviewPageState();
}

// WriteReviewPage의 상태를 관리하는 클래스
class _WriteReviewPageState extends State<WriteReviewPage> {
  double rating = 0.0; // 별점의 초기값을 0.0으로 설정
  TextEditingController titleController =
      TextEditingController(); // 제목 입력 필드의 컨트롤러
  TextEditingController contentController =
      TextEditingController(); // 내용 입력 필드의 컨트롤러

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("커뮤니티 글 작성"), // 앱 바의 제목 설정
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // 모든 방향에 16.0의 패딩을 적용
        child: Column(
          children: [
            // 별점 입력을 위한 행
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // 행을 중앙 정렬
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < rating
                        ? Icons.star
                        : Icons.star_border, // 별점에 따라 채워진 별 또는 빈 별 아이콘을 표시
                    color: Colors.yellow, // 별 아이콘의 색상을 노란색으로 설정
                  ),
                  onPressed: () {
                    setState(() {
                      rating = index + 1.0; // 별을 눌렀을 때 해당 별점으로 업데이트
                    });
                  },
                );
              }),
            ),
            // 제목 입력 필드
            TextField(
              controller: titleController, // 제목 입력 필드의 컨트롤러 설정
              decoration:
                  InputDecoration(labelText: '제목을 입력해주세요.'), // 입력 필드에 레이블 설정
            ),
            // 내용 입력 필드
            TextField(
              controller: contentController, // 내용 입력 필드의 컨트롤러 설정
              decoration:
                  InputDecoration(labelText: '내용을 입력해주세요.'), // 입력 필드에 레이블 설정
              maxLines: 5, // 최대 5줄까지 입력 가능
            ),
            const SizedBox(height: 20), // 20의 간격을 추가
            // 완료 버튼
            ElevatedButton(
              onPressed: () {
                // 새 리뷰 객체를 생성
                final newReview = Review(
                  profileImage:
                      'assets/images/default_profile.jpeg', // 기본 프로필 이미지
                  rating: rating, // 입력된 별점
                  title: titleController.text, // 입력된 제목
                  content: contentController.text, // 입력된 내용
                  likes: 0, // 초기 좋아요 수를 0으로 설정
                );
                Navigator.pop(context, newReview); // 새 리뷰 객체와 함께 이전 화면으로 이동
              },
              child: const Text('완료'), // 버튼에 표시될 텍스트
            ),
          ],
        ),
      ),
    );
  }
}
