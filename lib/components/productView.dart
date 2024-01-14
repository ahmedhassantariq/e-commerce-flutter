import 'dart:core';
import 'package:business_flutter/models/productModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../services/database/firebase_service.dart';


class ProductView extends StatefulWidget {
  final ProductModel productModel;
  final Function() update;
  const ProductView({
    required this.productModel,
    required this.update,
    super.key
  });

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  String buttonText = "Add to Cart";



  addToCart(){
    final FirebaseService _firebaseService = Provider.of<FirebaseService>(context, listen: false);
    if(_firebaseService.productList.any((element) => element.productID == widget.productModel.productID)){

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Already in Cart")));
    } else{
        _firebaseService.addToCart(widget.productModel);
        widget.update();

    }
  }

  @override
  void initState() {
    final FirebaseService _firebaseService = Provider.of<FirebaseService>(context, listen: false);
    if(_firebaseService.productList.any((element) => element.productID == widget.productModel.productID)){
      setState(() {
        buttonText = "Added to Cart";
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F6F6F6"),
      appBar: AppBar(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        leading: IconButton(onPressed: (){Navigator.pop(context);},icon: Icon(Icons.arrow_back, color: HexColor("#38C1CE"),)),
        title: Text(widget.productModel.productTitle, style: TextStyle(color: HexColor("#38C1CE")))),
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(onTap: (){
          addToCart();
          setState(() {
            buttonText = "Added to Cart";
          });
        },
          child: Container(
              decoration: BoxDecoration(
                color: HexColor("#38C1CE")
              ),
              height: 70,
              width: double.infinity,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add_shopping_cart_outlined, color: Colors.white, size: 30,),
                  Text(buttonText, style: const TextStyle(color: Colors.white,fontSize: 18),)
                ],)
          ),
        )
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Column(
            children: [
              const SizedBox(height: 8.0,),
              Image.network(widget.productModel.imageUrl, fit: BoxFit.fill,),
              const SizedBox(height: 8.0),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            for(int i=0;i<5;i++)
                              widget.productModel.rating>i ?
                              const Icon(Icons.star,size: 20, color: Colors.yellow)
                                  :
                              const Icon(Icons.star_outline,size: 20, color: Colors.grey),

                            const SizedBox(width: 8.0),
                            const Text("| Rating"),
                          ]),
                  ]),
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start
                    ,children: [
                      Text(widget.productModel.productTitle,style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 8.0),
                    Text("Family: ${widget.productModel.family}"),
                    const SizedBox(height: 8.0),
                    Text("Size: ${widget.productModel.size}"),

                    const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("\$ ${widget.productModel.price}",style: const TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough, fontSize: 18),),
                          const SizedBox(width: 8.0),
                          Text("\$ ${widget.productModel.discount}",style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                        ],
                      ),
                  ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
