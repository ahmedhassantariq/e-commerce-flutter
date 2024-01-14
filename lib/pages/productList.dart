import 'dart:async';

import 'package:business_flutter/components/productCard.dart';
import 'package:business_flutter/components/productView.dart';
import 'package:business_flutter/models/productModel.dart';
import 'package:business_flutter/services/database/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/listCard.dart';

class ProductList extends StatefulWidget {
  final List<ProductModel> product;
  const ProductList({
    required this.product,
    super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}



class _ProductListState extends State<ProductList> {
  late FirebaseService firebaseService;

  @override
  void initState() {
    firebaseService = Provider.of<FirebaseService>(context, listen: false);
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }

  updateState(){
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
     // FirebaseService().createPost();
    return Column(
      children: [
        Flexible(
          child: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: widget.product.length,
              itemBuilder: (BuildContext context, int index) {
                bool isAdded = firebaseService.productList.any((element) => element.productID==widget.product[index].productID);
                return GestureDetector(
                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        ProductView(productModel: widget.product[index],update:() {updateState;})));},
                    child: ListCard(productModel: widget.product[index], isAdded: isAdded,));
              }),
        )
      ],
    );
  }
}
