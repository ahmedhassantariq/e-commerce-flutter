import 'dart:async';

import 'package:business_flutter/components/featureGrid.dart';
import 'package:business_flutter/components/heroImage.dart';
import 'package:business_flutter/components/listCard.dart';
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



  @override
  Widget build(BuildContext context) {
    final StreamController<QuerySnapshot<Map<String, dynamic>>> streamController = StreamController<QuerySnapshot<Map<String, dynamic>>>();
    streamController.sink.addStream(Provider.of<FirebaseService>(context, listen: false).getHomePostData(null));
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  HeroImage(url: snapshot.data!.docs[0].get('heroImageUrl'),),
                  Align(alignment: Alignment.centerLeft, child: Padding(padding: const EdgeInsets.all(8.0),child: Text("Featured", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: HexColor("#38C1CE"))))),
                  FeaturedGrid(count: 2,width: 2,radius: 20,urls: [snapshot.data!.docs[0].get('featureImage1Url'),snapshot.data!.docs[0].get('featureImage2Url')],),
                  Align(alignment: Alignment.centerLeft, child: Padding(padding: const EdgeInsets.all(8.0),child: Text("Exclusive Collection", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: HexColor("#38C1CE"))))),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0), child: Text(snapshot.data!.docs[0].get('exclCollectionText'),style: TextStyle(color: Colors.blueGrey, fontSize: 14, fontWeight: FontWeight.w600))),
                  const SizedBox(height: 8.0),
                  FeaturedGrid(count: 4, width: 4, radius: 15, urls: [
                    snapshot.data!.docs[0].get('exclCollection1Url'),
                    snapshot.data!.docs[0].get('exclCollection2Url'),
                    snapshot.data!.docs[0].get('exclCollection3Url'),
                    snapshot.data!.docs[0].get('exclCollection4Url')
                  ],),
                  Align(alignment: Alignment.center, child: Padding(padding: const EdgeInsets.all(8.0),child: Text("Customer Deals", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: HexColor("#38C1CE"))))),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 8.0), child: Text(snapshot.data!.docs[0].get('customerDealsText'), style: TextStyle(color: Colors.blueGrey, fontSize: 14, fontWeight: FontWeight.w600))),
                ],
              ),
            );
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Oops... A problem has occurred.'));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }});
  }
}
