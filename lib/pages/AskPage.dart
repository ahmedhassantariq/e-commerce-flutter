import 'dart:async';

import 'package:business_flutter/components/steps.dart';
import 'package:business_flutter/models/step.dart';
import 'package:business_flutter/services/database/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../components/searchTextField.dart';


class AskPage extends StatefulWidget {
  const AskPage({super.key});

  @override
  State<AskPage> createState() => _AskPageState();
}

class _AskPageState extends State<AskPage> {
  late FirebaseService firebaseService;
  late List<StepModel> list;
  late Widget showList;

  @override
  void initState() {
    firebaseService = Provider.of<FirebaseService>(context, listen: false);
    list = firebaseService.stepsList;
    super.initState();
  }
  TextEditingController _searchTextController = TextEditingController();
  bool isAsked = true;
  bool _isSearching = false;


  searchQuery(){
    
  }


  Widget _buildTitle(BuildContext context){
    return Text("Frequent Questions", style: TextStyle(color: HexColor("#38C1CE")));
  }
  void _clearSearchQuery() {
    setState(() {
      _searchTextController.clear();
    });
  }
  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }
  void _startSearch() {
    ModalRoute.of(context)
        ?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }
  Widget _buildSearchField() {
    return SearchTextField(controller: _searchTextController, onPressSearch: (){searchQuery();}, onPressClose: (){_stopSearching();}, hintText: "Search for the Products", obscureText: false);
  }
  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
      ];
    }
    return <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            isAsked ? IconButton(icon: Icon(Icons.search, color: HexColor("#38C1CE")), onPressed: _startSearch)
                : Container()
          ],
        ),
      )

    ];
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: _buildTitle(context),
        // actions: _buildActions(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: _renderSteps(),
      )
    );
  }


  Widget _renderSteps() {
    return ExpansionPanelList(
      materialGapSize: 8.0,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          list[index].isExpanded = isExpanded;
        });
      },
      children: list.map<ExpansionPanel>((StepModel step) {
        return ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(step.title),
            );
          },
          body: ListTile(
            title: Text(step.body),
          ),
          isExpanded: step.isExpanded,
        );
      }).toList(),
    );
  }
}

class Step {
  Step(
      this.title,
      this.body,
      [this.isExpanded = false]
      );
  String title;
  String body;
  bool isExpanded;
}