import 'package:flutter/material.dart';
import 'package:local_shop/models/category.dart';
import 'package:local_shop/widget/cateroryItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("category").snapshots(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.orangeAccent,
            title: Text("Explore our app"),
          ),
          body: (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done)
              ? ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (ctx, i) {
                    return CategoryItem(
                        category: Category(
                            id: snapshot.data?.docs[i].id ?? "",
                            name: snapshot.data?.docs[i].data()["name"]));
                  })
              : Center(child: CircularProgressIndicator(color: Colors.black)),
        );
      },
    );
  }
}
