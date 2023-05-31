import 'dart:math';

import 'package:flutter/material.dart';
import 'package:local_shop/models/category.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem({required this.category});
  Category category;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(30)),
        tileColor: Colors.orange[100],
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            category.name,
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          print(category.id);
          Navigator.of(context).pushNamed("/products",
              arguments: {"id": category.id, "name": category.name});
        },
      ),
    );
  }
}
