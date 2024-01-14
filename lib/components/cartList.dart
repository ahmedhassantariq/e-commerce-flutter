import 'dart:async';

import 'package:business_flutter/components/productView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../models/productModel.dart';
import '../pages/checkoutPage.dart';
import '../services/database/firebase_service.dart';
import 'cartCard.dart';


class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  late FirebaseService firebaseService;
  @override
  void initState() {
    firebaseService = Provider.of<FirebaseService>(context, listen: false);
    firebaseService.addListener(updateState);
    super.initState();
  }

  @override
  void dispose() {
    firebaseService.removeListener(updateState);
    super.dispose();
  }
  void updateState() => setState(() {});

  @override
  Widget build(BuildContext context) {


    final StreamController<QuerySnapshot<Map<String, dynamic>>> cartStreamController = StreamController<QuerySnapshot<Map<String, dynamic>>>();
    cartStreamController.sink.addStream(Provider.of<FirebaseService>(context, listen: false).getCartData());
    final FirebaseService firebaseService = Provider.of<FirebaseService>(context, listen: false);
    firebaseService.productList.clear();
    updateCartList(ProductModel productModel){
      firebaseService.updateCartList(productModel);
    }

    List<ProductModel> getCartList() {
      final FirebaseService firebaseService = Provider.of<FirebaseService>(context, listen: false);
      return firebaseService.productList;
    }

    removeFromCart() {
      setState(() {

      });

    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: cartStreamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Flexible(
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              ProductModel productModel = ProductModel(
                                productID: snapshot.data!.docs[index].get('productID'),
                                productTitle: snapshot.data!.docs[index].get('productTitle'),
                                family: snapshot.data!.docs[index].get('family'),
                                size: snapshot.data!.docs[index].get('size'),
                                rating: snapshot.data!.docs[index].get('rating'),
                                quantity: snapshot.data!.docs[index].get('quantity'),
                                price: snapshot.data!.docs[index].get('price'),
                                discount: snapshot.data!.docs[index].get('discount'),
                                imageUrl:  snapshot.data!.docs[index].get('imageUrl'),

                              );
                              updateCartList(productModel);
                              return GestureDetector(
                                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                      ProductView(productModel: productModel,update: updateState )));},
                                  child: CartCard(productModel: productModel, removeFromCart: removeFromCart,));
                            }),
                      )],
                  );
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Oops... A problem has occurred.'));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }}),
        ),
        GestureDetector(
          onTap: (){
            if(getCartList().isNotEmpty) {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const CheckoutPage()));
            } else{
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 1),
                      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height-45),
                      content: const Text("Cart is Empty")));
            }

          },
          child: Container(
              height: 60,
              color: HexColor("#38C1CE"),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_checkout_outlined, color: Colors.white,),
                  Text("Checkout", style: TextStyle(color: Colors.white),)
                ],)
          ),
        )
      ],
    );
  }
}
