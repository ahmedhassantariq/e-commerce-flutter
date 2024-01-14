import 'package:business_flutter/models/productModel.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../services/database/firebase_service.dart';

class ProductCard extends StatefulWidget {
  final ProductModel productModel;
  late bool isAdded;
  ProductCard({
    required this.productModel,
    required this.isAdded,
    super.key
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {




  addToCart(){
    final FirebaseService _firebaseService = Provider.of<FirebaseService>(context, listen: false);
    if(_firebaseService.productList.any((element) => element.productID == widget.productModel.productID)){

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Already in Cart")));
    } else{
      _firebaseService.addToCart(widget.productModel);
      setState(() {
        widget.isAdded = true;
      });
    }
  }

  removeFromCart() {
    final FirebaseService _firebaseService = Provider.of<FirebaseService>(context, listen: false);
    _firebaseService.removeFromCart(widget.productModel);
    setState(() {
      widget.isAdded = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      margin: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(

            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                child: Container(
                  height: 110,
                  width: 115,
                  color: Colors.black,
                  child: Image.network(widget.productModel.imageUrl,
                    fit: BoxFit.fill,
                  ),
                )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.productModel.productTitle, style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                    const SizedBox(height: 3.0),
                    Text(widget.productModel.family, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),
                    const SizedBox(height: 3.0),
                    Text("${widget.productModel.size.substring(0,60)}...", style: const TextStyle(fontSize: 12),maxLines: 2,),
                    const SizedBox(height: 3.0),
                    Text("\$ ${widget.productModel.price}", style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600, letterSpacing: 0),),
                  ],
                ),
              ),

          ]),
          GestureDetector(
            onTap: (){widget.isAdded ? removeFromCart() : addToCart(); },
            child: Container(
              decoration: BoxDecoration(
                  color: widget.isAdded ? Colors.white : HexColor("#38C1CE"),
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  border: widget.isAdded ? Border.all(width: 2, color: HexColor("#38C1CE")) : Border.all(width: 0, color: Colors.transparent)
              ),
              height: 110,
              width: 50,
              child: widget.isAdded ? Icon(Icons.remove, color: HexColor("#38C1CE"),): const Icon(Icons.add, color: Colors.white,) ,
            ),
          ),
        ],

      ),
    );
  }
}
