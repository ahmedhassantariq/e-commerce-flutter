import 'dart:async';

import 'package:business_flutter/components/featureGrid.dart';
import 'package:business_flutter/components/heroImage.dart';
import 'package:business_flutter/components/listCard.dart';
import 'package:business_flutter/components/productView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../services/database/firebase_service.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {

  updateState(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          FutureBuilder(
              future: FirebaseService().getHeroImage(),
              builder: (builder, snapshot){
                if(snapshot.hasError){
                  return const Center(child: Text("Error"),);
                }
                if(snapshot.connectionState==ConnectionState.waiting){
                  return const LinearProgressIndicator();
                }
                return HeroImage(url: snapshot.data!);
              }),
          Align(alignment: Alignment.centerLeft, child: Padding(padding: const EdgeInsets.all(8.0),child: Text("Featured", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: HexColor("#38C1CE"))))),
          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics() ,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      )]),
                margin: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: FutureBuilder(
                      future: FirebaseService().getFeature1Product(),
                      builder: (builder, snapshot){
                        if(snapshot.hasError){
                          return const Center(child: Text("Error"),);
                        }
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return const SizedBox();
                        }

                        return GestureDetector(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>ProductView(productModel: snapshot.data! , update: updateState)));
                            },
                            child: Image.network(snapshot.data!.imageUrl, fit: BoxFit.fill,));
                      }),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      )]),
                margin: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: FutureBuilder(
                      future: FirebaseService().getFeature2Product(),
                      builder: (builder, snapshot){
                        if(snapshot.hasError){
                          return const Center(child: Text("Error"),);
                        }
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return const SizedBox();
                        }

                        return GestureDetector(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>ProductView(productModel: snapshot.data! , update: updateState)));
                            },
                            child: Image.network(snapshot.data!.imageUrl, fit: BoxFit.fill,));
                      }),
                ),
              )
            ],
          ),
          Align(alignment: Alignment.centerLeft, child: Padding(padding: const EdgeInsets.all(8.0),child: Text("Exclusive Collection", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: HexColor("#38C1CE"))))),
          FutureBuilder(
              future: FirebaseService().getExclusiveCollectionText(),
              builder: (builder, snapshot){
                if(snapshot.hasError){
                  return const Center(child: Text("Error"),);
                }
                if(snapshot.connectionState==ConnectionState.waiting){
                  return const SizedBox();
                }
                return Padding(padding: const EdgeInsets.all(8.0),child: Text(snapshot.data!, style: const TextStyle(color: Colors.blueGrey, fontSize: 14, fontWeight: FontWeight.w600)));
              }),

          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics() ,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      )]),
                margin: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: FutureBuilder(
                      future: FirebaseService().getExclusive1Product(),
                      builder: (builder, snapshot){
                        if(snapshot.hasError){
                          return const Center(child: Text("Error"),);
                        }
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return const SizedBox();
                        }

                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>ProductView(productModel: snapshot.data! , update: updateState)));
                          },
                            child: Image.network(snapshot.data!.imageUrl, fit: BoxFit.fill,));
                      }),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      )]),
                margin: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: FutureBuilder(
                      future: FirebaseService().getExclusive2Product(),
                      builder: (builder, snapshot){
                        if(snapshot.hasError){
                          return const Center(child: Text("Error"),);
                        }
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return const SizedBox();
                        }

                        return GestureDetector(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>ProductView(productModel: snapshot.data! , update: updateState)));
                            },
                            child: Image.network(snapshot.data!.imageUrl, fit: BoxFit.fill,));
                      }),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      )]),
                margin: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: FutureBuilder(
                      future: FirebaseService().getExclusive3Product(),
                      builder: (builder, snapshot){
                        if(snapshot.hasError){
                          return const Center(child: Text("Error"),);
                        }
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return const SizedBox();
                        }

                        return GestureDetector(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>ProductView(productModel: snapshot.data! , update: updateState)));
                            },
                            child: Image.network(snapshot.data!.imageUrl, fit: BoxFit.fill,));
                      }),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      )]),
                margin: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: FutureBuilder(
                      future: FirebaseService().getExclusive4Product(),
                      builder: (builder, snapshot){
                        if(snapshot.hasError){
                          return const Center(child: Text("Error"),);
                        }
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return const SizedBox();
                        }

                        return GestureDetector(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>ProductView(productModel: snapshot.data! , update: updateState)));
                            },
                            child: Image.network(snapshot.data!.imageUrl, fit: BoxFit.fill,));
                      }),
                ),
              ),
            ],
          ),
          Align(alignment: Alignment.centerLeft, child: Padding(padding: const EdgeInsets.all(8.0),child: Text("Customer Deals", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: HexColor("#38C1CE"))))),
          FutureBuilder(
              future: FirebaseService().getCustomerDealsText(),
              builder: (builder, snapshot){
                if(snapshot.hasError){
                  return const Center(child: Text("Error"),);
                }
                if(snapshot.connectionState==ConnectionState.waiting){
                  return const SizedBox();
                }
                return Padding(padding: const EdgeInsets.all(8.0),child: Text(snapshot.data!, style: const TextStyle(color: Colors.blueGrey, fontSize: 14, fontWeight: FontWeight.w600)));
              })
        ],
    );
  }
}
