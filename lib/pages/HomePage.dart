import 'dart:async';
import 'package:business_flutter/components/cartList.dart';
import 'package:business_flutter/components/drawer.dart';
import 'package:business_flutter/components/searchTextField.dart';
import 'package:business_flutter/models/productModel.dart';
import 'package:business_flutter/pages/ContactPage.dart';
import 'package:business_flutter/pages/home.dart';
import 'package:business_flutter/pages/productList.dart';
import 'package:business_flutter/pages/profilePage.dart';
import 'package:business_flutter/services/database/firebase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late FirebaseService firebaseService;
  final TextEditingController _searchTextController = TextEditingController();
  final StreamController<Stream<List<ProductModel>>> streamController = StreamController();

  bool isStore = false;

  @override
  void initState() {
    firebaseService = Provider.of<FirebaseService>(context, listen: false);
    firebaseService.getProductList();
    super.initState();
  }

  String searchQuery = "Search query";
  bool _isSearching = false;



  int currentIndex = 0;

  onTapped(int index) {
    setState(() {
      if (index == 2) {
        isStore = true;
      } else {
        isStore = false;
        _isSearching = false;
      }
      if(index == 3) {
        showProfileMenu();
      } else {
        currentIndex = index;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    // streamController.addStream(
    //     Provider.of<FirebaseService>(context, listen: false)
    //         .getFeaturedPostData(null));


    List<String> appBarTitle = [
      "Green Heaven",
      "Contact Us",
      "Store",
      "Profile"
    ];
    final List<Widget> widgets = [
      const Home(),
      const ContactPage(),
      StreamBuilder<List<ProductModel>>(
          stream: Provider.of<FirebaseService>(context, listen: false).getFeaturedPostData(null),
           builder: (builder, snapshot){
            if(snapshot.hasError){
              return const LinearProgressIndicator();
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return const LinearProgressIndicator();
            }
            return ProductList(product: snapshot.requireData);
      }),
      Container()
    ];

    searchFilter() {

          if (_searchTextController.text.isEmpty) {
            streamController.add(
                Provider.of<FirebaseService>(context, listen: false)
                    .getFeaturedPostData(null));
          } else {
            streamController.add(
                Provider.of<FirebaseService>(context, listen: false)
                    .getFeaturedPostData(
                    _searchTextController.text.toString().toLowerCase()));
          }
        print("Searching ${_searchTextController.text}");
          setState(() {
          });
      }

    drawerFilter(String? filterText) {

          if (filterText == null) {
            streamController.add(
                Provider.of<FirebaseService>(context, listen: false)
                    .getFeaturedPostData(null));
          } else {
            streamController.add(
                Provider.of<FirebaseService>(context, listen: false)
                    .getFeaturedPostData(filterText.toString().toLowerCase()));
          }
    }


    Widget _buildTitle(BuildContext context) {
      return Text(appBarTitle[currentIndex],
          style: TextStyle(color: HexColor("#38C1CE")));
    }
    Widget _showLeading(BuildContext context) {
      return Builder(builder: (context) => Padding(padding: EdgeInsets.all(8.0),child: Image.asset("assets/images/main.png", height: 50,width: 50,)));
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
      return SearchTextField(controller: _searchTextController,
          onPressSearch: searchFilter,
          onPressClose: () {
            _stopSearching();
          },
          hintText: "Search for the Products",
          obscureText: false);
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
              // isStore ? IconButton(
              //     icon: Icon(Icons.search, color: HexColor("#38C1CE")),
              //     onPressed: _startSearch) : Container(),
              Builder(builder: (context) =>
                  IconButton(
                      onPressed: () => {showCartMenu()},
                      icon: Icon(Icons.shopping_cart_outlined,
                          color: HexColor("#38C1CE")))),

            ],
          ),
        )

      ];
    }

    return Scaffold(
      appBar: AppBar(
        leading: _showLeading(context),
        title: _isSearching ? _buildSearchField() : _buildTitle(context),
        actions: _buildActions(),
      ),
      // drawer: FrontDrawer(onDrawerButton: drawerFilter),
      body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: IndexedStack(index: currentIndex, children: widgets)
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTapped,
          currentIndex: currentIndex,
          items:
          const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined),
                label: "Home",
                activeIcon: Icon(Icons.home)),
            BottomNavigationBarItem(icon: Icon(Icons.perm_contact_cal_outlined),
                label: "Contact",
                activeIcon: Icon(Icons.perm_contact_cal)),
            BottomNavigationBarItem(icon: Icon(Icons.store_outlined),
                label: "Store",
                activeIcon: Icon(Icons.store)),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline),
                label: "Profile",
                activeIcon: Icon(Icons.person)
            ),
          ]
      ),
    );
  }


  showCartMenu() {
    showModalBottomSheet(
        enableDrag: true,
        showDragHandle: true,
        context: context,
        builder: (BuildContext context) {
          return const CartList();
        });
  }


  showProfileMenu() {
    showModalBottomSheet(
        enableDrag: true,
        showDragHandle: true,
        context: context,
        builder: (BuildContext context) {
          return const ProfilePage();
        });
  }
}
