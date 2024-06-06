import 'package:flutter/material.dart';
import '../widgets/menu_item.dart';

class MenuTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8.0),
      children: [
        MenuItem(
          imagePath: 'assets/images/bulgogi_pizza.png',
          name: '불고기 피자',
          description: '불고기 맛나는 피자',
          price: '7,000원',
          initialLikes: 105,
        ),
        MenuItem(
          imagePath: 'assets/images/pepperoni_pizza.png',
          name: '페페로니 피자',
          description: '짭짤한 페페로니가 잔뜩 들어간 피자',
          price: '8,500원',
          initialLikes: 99,
        ),
        MenuItem(
          imagePath: 'assets/images/mexican_pizza.png',
          name: '멕시칸 피자',
          description: '톡톡 튀는 토마토의 풍미를 더한 피자',
          price: '8,500원',
          initialLikes: 45,
        ),
      ],
    );
  }
}
