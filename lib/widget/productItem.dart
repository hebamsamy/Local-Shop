import 'package:flutter/material.dart';
import 'package:local_shop/models/product.dart';

class ProductItem extends StatelessWidget {
  Product product;
  ProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed("/product/details", arguments: product.id);
          },
          child: Image.network(
            "https://picsum.photos/200",
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(Icons.shopping_bag),
            onPressed: () {},
          ),
          title: Text(product.name),
          backgroundColor: Color.fromARGB(159, 28, 17, 17),
        ),
      ),
    );
  }
}
