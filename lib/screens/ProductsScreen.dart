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
              ? GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2 / 3,
                  ),
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (ctx, i) {
                    print("item");
                    print(snapshot.data?.docs[i].data()["categoryId"]);
                    if (categoryId ==
                        snapshot.data?.docs[i].data()["categoryId"]) {
                      return ProductItem(
                        product: Product(
                          id: snapshot.data?.docs[i].id ?? "",
                          categoryID:
                              snapshot.data?.docs[i].data()["categoryId"],
                          name: snapshot.data?.docs[i].data()["name"],
                          quantity: snapshot.data?.docs[i].data()["quantity"],
                          price: snapshot.data?.docs[i].data()["price"],
                          description:
                              snapshot.data?.docs[i].data()["description"] ??
                                  "",
                        ),
                      );
                    }
                  })

              //   CategoryItem(
              //       category: Category(
              //           id: snapshot.data?.docs[i].id ?? "",
              //           name: snapshot.data?.docs[i].data()["name"]));
              // })
              : CircularProgressIndicator(color: Colors.black),
        );
      },
    );
  }
}
