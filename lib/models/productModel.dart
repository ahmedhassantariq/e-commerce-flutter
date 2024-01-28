import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  late String productID;
  late String productTitle;
  late String family;
  late String size;
  late int price;
  late int rating;
  late int quantity;
  late int discount;
  late String imageUrl;
  ProductModel({
    required this.productID,
    required this.productTitle,
    required this.family,
    required this.size,
    required this.rating,
    required this.quantity,
    required this.price,
    required this.discount,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap(){
    return ({
      "productID":productID,
      "productTitle":productTitle,
      "family":family,
      "size":size,
      "rating":rating,
      "quantity":1,
      "price":price,
      "discount":discount,
      "imageUrl":imageUrl,
    });
  }

  factory ProductModel.fromMap(QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot){
    return(ProductModel(
        productID: documentSnapshot.get('productID'),
        productTitle: documentSnapshot.get('productTitle'),
        family: documentSnapshot.get('family'),
        size: documentSnapshot.get('size'),
        rating: documentSnapshot.get('rating'),
        quantity: documentSnapshot.get('quantity'),
        price: documentSnapshot.get('price'),
        discount: documentSnapshot.get('discount'),
        imageUrl: documentSnapshot.get('imageUrl'),
        ));
  }

  factory ProductModel.fromDocMap(DocumentSnapshot<Map<String, dynamic>> documentSnapshot){
    return(ProductModel(
      productID: documentSnapshot.get('productID'),
      productTitle: documentSnapshot.get('productTitle'),
      family: documentSnapshot.get('family'),
      size: documentSnapshot.get('size'),
      rating: documentSnapshot.get('rating'),
      quantity: documentSnapshot.get('quantity'),
      price: documentSnapshot.get('price'),
      discount: documentSnapshot.get('discount'),
      imageUrl: documentSnapshot.get('imageUrl'),
    ));
  }


}
