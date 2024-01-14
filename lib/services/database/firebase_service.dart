import 'dart:async';
import 'package:business_flutter/models/productModel.dart';
import 'package:business_flutter/models/step.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FirebaseService with ChangeNotifier {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late List<ProductModel> productList = [];
  late List<String> notificationList = [];
  late List<StepModel> stepsList = [];


  Future<void> createPost() async {
    String productID = _firestore
        .collection("business")
        .doc("products")
        .collection("featuredProducts")
        .doc()
        .id;
    String userID = FirebaseAuth.instance.currentUser!.uid;

    await _firestore.collection("business").doc("products").collection(
        "featuredProducts")
        .doc(productID).set({
      "UploadedBy": userID,
      "UploadedOn": Timestamp.now(),
      "category": "indoor",
      "price": 123,
      "imageUrl": "https://media.istockphoto.com/id/1288385045/photo/snowcapped-k2-peak.jpg?s=612x612&w=0&k=20&c=sfA4jU8kXKZZqQiy0pHlQ4CeDR0DxCxXhtuTDEW81oo=",
      "productTitle": "Abelia",
      "discount": 122,
      "productDescription": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      "rating": 3,
      "quantity": 25,
      "productID": productID,
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String userUID) async {
    DocumentSnapshot<Map<String, dynamic>> userCredentials = await _firestore
        .collection('reddit').doc('users').collection('user_credentials').doc(
        userUID).get();
    return userCredentials;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getHomePostData(String? filter) {
    Stream<QuerySnapshot<Map<String, dynamic>>> data = _firestore.collection(
        'business').doc('products').collection('allProducts')
        .where('category', isGreaterThanOrEqualTo: filter)
        .where('category', isLessThanOrEqualTo: filter)
        .get().asStream();
    return data;
  }

  Stream<QuerySnapshot> searchProduct(String filter) {
    return _firestore.collection('business').doc('products').collection('featuredProducts').snapshots();

  }

  Stream<List<ProductModel>> getFeaturedPostData(String? filter) {
    Stream<QuerySnapshot<Map<String, dynamic>>> data = _firestore.collection('business').doc('products').collection('featuredProducts').get().asStream();
    Stream<List<ProductModel>> list = data.map((event) => event.docs.map((e) =>
        ProductModel.fromMap(e) ).toList());
    return list;
  }


  Stream<QuerySnapshot<Map<String, dynamic>>> getCartData() {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    Stream<QuerySnapshot<Map<String, dynamic>>> data = _firestore.collection(
        'business').doc('users').collection(userID).doc('cart').collection(
        'cartData')
        .get().asStream();
    return data;
  }

  void updateCartList(ProductModel productModel) {
    productList.add(productModel);
  }


  addToCart(ProductModel productModel) async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    await _firestore.collection('business').doc('users').collection(userID).doc('cart').collection('cartData').doc(productModel.productID).set(productModel.toMap());
    productList.add(productModel);
    notifyListeners();
  }


  Future<void>getFrequentQuestions() async{
    if(stepsList.isEmpty){
      await _firestore.collection('business').doc('queries').collection("frequentQuestions").get()
          .then((querySnapshot) => {
        for (var docSnapshot in querySnapshot.docs) {
          stepsList.add(StepModel(docSnapshot.data()['question'], docSnapshot.data()['answer']))}
      });
    }
    print(stepsList.length);
    notifyListeners();
  }

  Future<void> sendEmail(String emailSubject, String emailBody) async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    await _firestore
        .collection("business")
        .doc("queries")
        .collection("emails").add({
      "userID":userID,
      "emailSubject":emailSubject,
      "emailBody":emailBody,
      "uploadedOn": Timestamp.now()
    });
  }

  getProductList() async{
    String userID = FirebaseAuth.instance.currentUser!.uid;
    if(productList.isEmpty){
      await _firestore.collection('business').doc('users').collection(userID).doc('cart').collection('cartData').get()
          .then((querySnapshot) => {
            for (var docSnapshot in querySnapshot.docs) {
              productList.add(
                  ProductModel(
                      productID: docSnapshot.data()['productID'],
                      productTitle: docSnapshot.data()['productTitle'],
                      family: docSnapshot.data()['family'],
                      size: docSnapshot.data()['size'],
                      rating: docSnapshot.data()['rating'],
                      quantity: docSnapshot.data()['quantity'],
                      price: docSnapshot.data()['price'],
                      discount: docSnapshot.data()['discount'],
                      imageUrl: docSnapshot.data()['imageUrl']))
            }
      });
    }
    notifyListeners();
  }

  increaseCartQty(ProductModel productModel, int quantity) async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    await _firestore.collection('business').doc('users').collection(userID).doc(
        'cart')
        .collection('cartData').doc(productModel.productID)
        .update(
        {"quantity": quantity}
    );
  }

  decreaseCartQty(ProductModel productModel, int quantity) async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    await _firestore.collection('business').doc('users').collection(userID).doc(
        'cart')
        .collection('cartData').doc(productModel.productID)
        .update(
        {"quantity": quantity}
    );
  }


  removeFromCart(ProductModel productModel) async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    await _firestore.collection('business').doc('users').collection(userID).doc(
        'cart').collection('cartData').doc(productModel.productID).delete();
    productList.removeWhere((element) =>
    element.productID == productModel.productID);
    notifyListeners();
  }

  clearCart() async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    List<String> checkoutList = [];
    for (int i = 0; i < productList.length; i++) {
      await _firestore.collection('business').doc('users').collection(userID)
          .doc('cart').collection('cartData').doc(productList[i].productID)
          .delete();
    }
    final SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();

    productList.clear();
    checkoutList.clear();
  }

  Future<String> confirmOrder(String name, String address) async {
    List<String> checkoutList = [];
    for (int i = 0; i < productList.length; i++) {
      checkoutList.add(
          "${productList[i].productID} : ${productList[i].quantity}");
    }
    String orderID = _firestore
        .collection('business')
        .doc('orders')
        .collection('customerOrder')
        .doc()
        .id;
    String userID = FirebaseAuth.instance.currentUser!.uid;
    await _firestore.collection('business').doc('orders').collection(
        'customerOrder').doc(orderID)
        .set({
      'customerID': userID,
      'orderID': orderID,
      'orderItems': checkoutList,
      'name': name,
      'address': address,
      'orderedOn': Timestamp.now(),
    });
    clearCart();
    return orderID;
  }

  Future<void> getLocalStorage() async {

  }


  Future<void> setLocalStorage(ProductModel productModel) async {

  }

}