import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_demo/Demo_App/controller/cart_controller.dart';
import '../controller/cart_controller.dart';


class cart_Screen extends StatelessWidget {
  static const routeName = '/cartScreen';
  final cartController = Get.put(Cart_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
            onPressed: () =>
                Navigator.of(context).pop()

        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Demo_cart')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      QueryDocumentSnapshot<Object?>? documentSnapshot =
                      snapshot.data?.docs[index];

                      return Dismissible(
                          key: Key(index.toString()),


                          child:
                          Container(
                              height: 100,
                              child: Card(
                                  child: ListTile(
                                    leading: Image.network(
                                        documentSnapshot!['image']),
                                    title: Text(documentSnapshot['name'],
                                      style: TextStyle(fontSize: 12),),
                                    subtitle: Container(
                                      height: 250,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(onPressed: () {
                                            DocumentReference collection = FirebaseFirestore
                                                .instance.collection(
                                                "Demo_cart")
                                                .doc(
                                                documentSnapshot.id.toString());
                                            collection.update({
                                              "quantity": FieldValue.increment(
                                                  -1)
                                            });
                                          },
                                            icon: Icon(Icons.arrow_back_ios),
                                            iconSize: 10,),
                                          Text(documentSnapshot['quantity']
                                              .toString(),
                                            style: TextStyle(fontSize: 12),),
                                          IconButton(onPressed: () {
                                            DocumentReference collection = FirebaseFirestore
                                                .instance.collection(
                                                "Demo_cart")
                                                .doc(
                                                documentSnapshot.id.toString());
                                            collection.update({
                                              "quantity": FieldValue.increment(
                                                  1)
                                            });
                                          },
                                            icon: Icon(Icons.arrow_forward_ios),
                                            iconSize: 10,),
                                        ],
                                      ),
                                    ),
                                    trailing: Text(
                                        '\$${documentSnapshot['price'] *
                                            documentSnapshot['quantity']}'),

                                  )
                              )
                          ));
                    }
                );
              },
            ),
          ),
          SizedBox(height: 10,),

          Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.red
                ),
                onPressed: () {


                },

                child: Obx(() =>
                    Text('Total Amount: ${cartController.data.value
                        .toString()}')),


              )
            //Text("Total Amount:$data"),


          )


        ],
      ),
    );
  }
}


//   Future getTotal() async {
//     double? sum = 0;
//     FirebaseFirestore.instance.collection('Demo_cart').get().then(
//           (querySnapshot) {
//         querySnapshot.docs.forEach((result) {
//           for (var i = 1; i < result.data()['price'].toString().length; i++) {
//             sum = (sum! + result.data()['price']) as double?;
//           }
//         });
//         print('total : $sum');
//         return sum;
//       },
//     );
//   }
// }

//Text(document['id'].toString())
//Image.network(document['image'])
