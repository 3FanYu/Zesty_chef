import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final String img;

  const MenuCard({Key key, this.img}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Image.network(
          img,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
