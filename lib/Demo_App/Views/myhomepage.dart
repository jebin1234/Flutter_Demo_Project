import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:getx_demo/Demo_App/Views/Cart_Screen.dart';
import '../controller/cart_controller.dart';
import 'Details.dart';
import '../controller/appcontroller.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/homescreen';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AppController controller = Get.put(AppController());
  final cartController = Get.put(Cart_Controller());

  // final int data= FirebaseFirestore.instance.collection('Demo_cart').snapshots().length as int;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: [
          Container(
            child: Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pushNamed(cart_Screen.routeName);
                  },
                ),
                Positioned(
                    bottom: 10,
                    right: 10,
                    child: Obx(() => Text(
                          cartController.length.toString(),
                          style: TextStyle(color: Colors.orange),
                        )))
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    "ShopX",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
                  IconButton(
                    icon: Icon(Icons.view_list_rounded),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.grid_view),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 0,
          ),
          Expanded(child: Obx(() {
            return controller.postloading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    itemCount: controller.getposts.length,
                    itemBuilder: (context, index) {
                      var item = controller.getposts[index];
                      return Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Details(item)));
                                  print(item.id);
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 180,
                                      width: double.infinity,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Image.network(
                                        item.image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                item.title,
                                maxLines: 2,
                                style: TextStyle(
                                    fontFamily: 'avenir',
                                    fontWeight: FontWeight.w800),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8),
                              if (item.rating != null)
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        item.rating.rate.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              SizedBox(height: 8),
                              Text('\$${item.price}',
                                  style: TextStyle(
                                      fontSize: 24, fontFamily: 'avenir')),
                            ],
                          ),
                        ),
                      );
                    },
                    staggeredTileBuilder: (index) => StaggeredTile.fit(1));

            // : ListView.builder(
            //     itemCount: controller.getposts.length,
            //     itemBuilder: (context, index) {
            //       var item = controller.getposts[index];
            //       return Card(
            //         child: ListTile(
            //           title: Text(item.title),
            //           subtitle: Image.network(item.image),
            //           leading: Text(item.id.toString()),
            //         ),
            //       );
            //     });
          }))
        ],
      ),
    );
  }
}
