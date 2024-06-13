import 'package:flutter/material.dart';

class MenuItem extends StatefulWidget {
  final String imagePath;
  final String name;
  final String description;
  final String price;
  final int initialLikes;

  MenuItem({
    required this.imagePath,
    required this.name,
    required this.description,
    required this.price,
    required this.initialLikes,
  });

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  late int likes;
  bool isLiked = false; // 좋아요 여부

  @override
  void initState() {
    super.initState();
    likes = widget.initialLikes; // 초기 좋아요 수 설정
  }

  // 좋아요 토글 함수
  void _toggleLike() {
    setState(() {
      isLiked = !isLiked; // 좋아요 여부 토글
      likes += isLiked ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0), // 카드 위젯의 세로 여백 설정
      child: ListTile(
        leading: Image.asset(widget.imagePath,
            width: 50, height: 50, fit: BoxFit.cover), // 이미지 설정
        title: Text(widget.name), // 메뉴 이름
        subtitle: Text(widget.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.price, style: TextStyle(fontWeight: FontWeight.bold)), // 메뉴 가격
            SizedBox(width: 8.0), // 가격과 아이콘 사이의 간격 설정
            IconButton(
              icon: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border, // 좋아요 아이콘 변경
                color: isLiked ? Colors.red : Colors.grey, // 좋아요 아이콘 색상 변경
                size: 20.0,
              ),
              onPressed: _toggleLike, // 아이콘 클릭 시 좋아요 토글 함수 호출
            ),
            SizedBox(width: 4.0),
            Text(likes.toString()),
          ],
        ),
      ),
    );
  }
}
