import 'package:flutter/material.dart';
import '../models/review.dart';

class ReviewWidget extends StatelessWidget {
  final Review review; // 리뷰 객체를 저장하는 변수
  final VoidCallback onLike; // 좋아요 버튼 클릭 시 호출되는 콜백 함수

  ReviewWidget({required this.review, required this.onLike});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Image.asset(review.profileImage,
            width: 50, height: 50, fit: BoxFit.cover), // 프로필 이미지 설정
        title: Row(
          children: [
            Icon(Icons.star, color: Colors.yellow, size: 16.0), // 별 아이콘
            SizedBox(width: 4.0),
            Text(review.rating.toString()), // 리뷰 평점
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                review.title,
                overflow: TextOverflow.ellipsis, // 텍스트가 길 경우 생략 기호 표시
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        subtitle: Text(review.content), // 리뷰 내용
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                review.isLiked ? Icons.favorite : Icons.favorite_border, // 좋아요 아이콘 변경
                color: review.isLiked ? Colors.red : Colors.grey, // 좋아요 아이콘 색상 변경
                size: 20.0,
              ),
              onPressed: onLike, // 좋아요 버튼 클릭 시 onLike 콜백 함수 호출
            ),
            SizedBox(width: 4.0), // 좋아요 아이콘과 좋아요 수 사이의 간격
            Text(review.likes.toString()), // 좋아요 수 출력
          ],
        ),
      ),
    );
  }
}