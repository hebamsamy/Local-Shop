import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_shop/models/product.dart';
import 'package:local_shop/widget/productItem.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String categoryId = "";
  String categoryName = "category";
  List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      var arg =
          ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
      categoryId = arg['id'] as String;
      categoryName = arg['name'] as String;
    }

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("products").snapshots(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.orangeAccent,
            title: Text(categoryName),
          ),
          body: (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done)
              ? GridView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2 / 3,
                  ),
                  children: snapshot.data?.docs
                          .where((element) =>
                              categoryId == element.data()["categoryId"])
                          .map((item) => ProductItem(
                                product: Product(
                                  id: item.id,
                                  categoryID: item.data()["categoryId"],
                                  name: item.data()["name"],
                                  quantity: item.data()["quantity"],
                                  price: item.data()["price"],
                                  description: item.data()["description"] ?? "",
                                ),
                              ))
                          .toList() ??
                      [])
              : Center(child: CircularProgressIndicator(color: Colors.black)),
        );
      },
    );
  }
}
