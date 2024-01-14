import 'package:flutter/material.dart';

class FeaturedGrid extends StatefulWidget {
  final int count;
  final int width;
  final double radius;
  final List<String> urls;
  const FeaturedGrid({
    required this.count,
    required this.width,
    required this.radius,
    required this.urls,
    super.key
  });

  @override
  State<FeaturedGrid> createState() => _FeaturedGridState();
}

class _FeaturedGridState extends State<FeaturedGrid> {
  double height  = 10;
  double width = 10;
  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics() ,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: widget.width),
      children: [
        for(int i = 0; i < widget.count; i++)
          Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              )]),
            margin: EdgeInsets.all(8.0),
            child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
            child: Image.network(
              widget.urls[i],
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }
}
