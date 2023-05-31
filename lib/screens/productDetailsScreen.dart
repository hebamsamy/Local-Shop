import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_shop/models/product.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String ID = "";
  Product prd = Product(
      id: "", name: "", categoryID: "", price: 1, quantity: 1, description: "");
  getDoc() async {
    print(ID);
    var document = await FirebaseFirestore.instance
        .collection('products')
        .doc(ID)
        .snapshots()
        .first;
    setState(() {
      prd.categoryID = document.get('categoryId');
      prd.id = document.id;
      prd.name = document.get('name');
      prd.description = document.get('description') ?? "";
      prd.quantity = document.get('quantity');
      prd.price = document.get('price');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      ID = ModalRoute.of(context)?.settings.arguments as String;
      print(ID);
      getDoc();
    }
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.orangeAccent,
        title: Text(prd.name),
      ),
      body: Center(
        child: Column(children: [
          Text(prd.description),
          Text('the available Quantity :  ${prd.quantity}'),
          Text('it Cost ${prd.description} \$'),
        ]),
      ),
    );
  }
}
