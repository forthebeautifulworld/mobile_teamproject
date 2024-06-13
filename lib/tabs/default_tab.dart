import 'package:flutter/material.dart';
import '../widgets/menu_item.dart';

class DefaultTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8.0),
      children: [
        MenuItem(
          imagePath: 'assets/images/default_image.png',
          name: '추가해주세요.',
          description: '',
          price: '',
          initialLikes: 0,
        ),
      ],
    );
  }
}
