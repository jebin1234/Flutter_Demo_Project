import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../model/postmodel.dart';

class Services {
  var url = 'https://fakestoreapi.com/products';
  Future<List<Postmodel>?> getallposts() async {
    try {
      var response = await
      http.get(Uri.parse(url))
          .timeout(const Duration(seconds: 20), onTimeout: () {
        throw TimeoutException("connection time out try agian");
      });

      if (response.statusCode == 200) {
        List jsonresponse = convert.jsonDecode(response.body);
        return jsonresponse.map((e) => new Postmodel.fromJson(e)).toList();
      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      print("response time out");
    }
  }



  

}
