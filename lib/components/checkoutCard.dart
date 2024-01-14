import 'package:business_flutter/models/productModel.dart';
import 'package:business_flutter/services/database/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class CheckoutCard extends StatefulWidget {
  final ProductModel productModel;
  const CheckoutCard({
    required this.productModel,
    super.key
  });



  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 8.0),
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
            ]
          ),
          Text(widget.productModel.quantity.toString())
    ])
    );
  }
}
