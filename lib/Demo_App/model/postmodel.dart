// To parse this JSON data, do
//
//     final postmodel = postmodelFromJson(jsonString);

import 'dart:convert';

List<Postmodel> postmodelFromJson(String str) => List<Postmodel>.from(json.decode(str).map((x) => Postmodel.fromJson(x)));

String postmodelToJson(List<Postmodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Postmodel {
    Postmodel({
        required this.id,
        required this.title,
        required this.price,
        required this.description,
        required this.category,
        required this.image,
        required this.rating,
    });

    int id;
    String title;
    double price;
    String description;
    String category;
    String image;
    Rating rating;

    factory Postmodel.fromJson(Map<String, dynamic> json) => Postmodel(
        id: json["id"],
        title: json["title"],
        price: json["price"].toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        rating: Rating.fromJson(json["rating"]),
    );


    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating.toJson(),
    };


}

class Rating {
    Rating({
        required this.rate,
        required this.count,
    });

    double rate;
    int count;

    factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"].toDouble(),
        count: json["count"],
    );
    Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
    };


}

