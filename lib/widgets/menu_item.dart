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
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    likes = widget.initialLikes;
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likes += isLiked ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: Image.asset(widget.imagePath,
            width: 50, height: 50, fit: BoxFit.cover),
        title: Text(widget.name),
        subtitle: Text(widget.description),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.price, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.grey,
                    size: 20.0,
                  ),
                  onPressed: _toggleLike,
                ),
                SizedBox(width: 4.0),
                Text(likes.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
