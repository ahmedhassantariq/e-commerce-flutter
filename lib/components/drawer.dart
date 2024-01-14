import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class FrontDrawer extends StatefulWidget {
  void Function(String?) onDrawerButton;
  FrontDrawer({
    required this.onDrawerButton,
    super.key});

  @override
  State<FrontDrawer> createState() => _FrontDrawerState();
}

class _FrontDrawerState extends State<FrontDrawer> {
  @override
  Widget build(BuildContext context) {
    List<String?> filterList = [null,'indoor','outdoor','other',];
    List<IconData> filterIconList = [Icons.clear,Icons.door_sliding_outlined,Icons.air,Icons.menu];


    return Drawer(
      width: 200,
      backgroundColor: HexColor("#F6F6F6"),
      child: ListView(
        children: [
           const Padding(
            padding: EdgeInsets.all(15),
            child: Center(
                child: Text("MENU", style: TextStyle(color: Colors.grey,fontSize: 18 ),)),
          ),

          for(int i=0;i<filterList.length;i++)
            TextButton.icon(style: TextButton.styleFrom(alignment: Alignment.centerLeft),onPressed: (){widget.onDrawerButton(filterList[i]);Scaffold.of(context).closeDrawer();}, icon: Icon(filterIconList[i], color: HexColor("#38C1CE")), label:  Text(filterList[i]==null ? "CLEAR FILTER": filterList[i]!.toUpperCase() , style: const TextStyle(color: Colors.black))),

        ],
      )
    );
  }
}

