
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';


class Cart_Controller extends GetxController {
  RxInt data=0.obs;
  RxInt length=0.obs;

  num sum=0;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTotal();
    getCount();

  }

  Future getTotal( ) async {
    //String sum = 0 as String;
    FirebaseFirestore.instance.collection('Demo_cart').get().then(
            (querySnapshot) {
          querySnapshot.docs.forEach((result) {
              sum=(sum + (result.data()['price']*result.data()['quantity']));
              //sum = (sum + res ult.data()['price'].toString());
          });
          data.value=sum.toInt() ;

        });
}
  Future getCount() async {
    FirebaseFirestore.instance
        .collection('Demo_cart')
        .get()
        .then((value) {
      var count = 0;
      count = value.docs.length;
print('count$count');
length.value=count;
      return count;
    });
  }
}