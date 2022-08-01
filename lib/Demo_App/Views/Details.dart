import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getx_demo/Demo_App/Views/myhomepage.dart';
import 'package:provider/provider.dart';
import '../model/cart_Model.dart';
import '../model/postmodel.dart';

import 'Cart_Screen.dart';

class Details extends StatelessWidget {
  final item;

  Details(this.item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () =>
                  Navigator.of(context).pushNamed(MyHomePage.routeName)),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 250,
                  child: Image.network(item.image),
                ),
              ),
              Row(
                children: [
                  Expanded(child: Text('')),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.favorite_border))
                ],
              ),
              Divider(
                thickness: 1,
              ),
              Text(
                item.title,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                item.description,
                maxLines: 3,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Divider(
                thickness: 1,
              ),
              Row(
                children: [
                  Text('Total Amount'),
                  Text('  \$${item.price}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  SizedBox(
                    width: 80,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('Demo_cart')
                            .doc(item.id.toString())
                            .set({
                          'id': item.id,
                          'name': item.title,
                          'price': item.price,
                          'image': item.image,
                          'quantity': 1,
                        });
                      },
                      //=> Navigator.of(context).pushNamed(Cart_Screen.routeName),
                      child: Text("Add to Cart"))
                ],
              )
            ],
          ),
        ));
  }
}
