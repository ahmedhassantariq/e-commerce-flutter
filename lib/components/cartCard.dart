import 'package:business_flutter/models/productModel.dart';
import 'package:business_flutter/services/database/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class CartCard extends StatefulWidget {
  final ProductModel productModel;
  final Function removeFromCart;
  const CartCard({
    required this.productModel,
    required this.removeFromCart,
    super.key
  });



  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  removeFromCart() {
    final FirebaseService _firebaseService = Provider.of<FirebaseService>(context, listen: false);
    setState(() {
      _firebaseService.removeFromCart(widget.productModel);
    });
  }
  final FirebaseService firebaseService = FirebaseService();
  @override
  void initState() {
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
    increaseQty(){
      setState(() {
        widget.productModel.quantity++;
        final FirebaseService _firebaseService = Provider.of<FirebaseService>(context, listen: false);
        _firebaseService.increaseCartQty(widget.productModel, widget.productModel.quantity);
      });
    }

    decreaseQty(){
      setState(() {
        if(widget.productModel.quantity>1) {
          widget.productModel.quantity--;
          final FirebaseService _firebaseService = Provider.of<FirebaseService>(context, listen: false);
          _firebaseService.increaseCartQty(widget.productModel, widget.productModel.quantity);
        }
      });
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(widget.productModel.imageUrl,)),
                const SizedBox(width: 8.0,),
                Text(widget.productModel.productTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),

              ],
            ),
            Row(
              children: [
                ElevatedButton(onPressed: (){increaseQty();},style: ElevatedButton.styleFrom(backgroundColor: Colors.white,shape: const CircleBorder()), child: Icon(Icons.add, color: HexColor("#38C1CE"),),),
                Text(widget.productModel.quantity.toString()),
                ElevatedButton(onPressed: (){decreaseQty();},style: ElevatedButton.styleFrom(backgroundColor: Colors.white,shape: const CircleBorder()), child: Icon(Icons.remove, color: HexColor("#38C1CE"),),),
                IconButton(onPressed: (){
                  removeFromCart();
                  widget.removeFromCart();
                }, icon: const Icon(Icons.close, color: Colors.grey,),splashColor: Colors.transparent,highlightColor: Colors.transparent,focusColor: Colors.transparent,hoverColor: Colors.transparent, ),
              ],
            )
          ],),
      ),
    );
  }
}
