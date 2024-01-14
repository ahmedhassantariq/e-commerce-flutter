import 'package:business_flutter/components/cartCard.dart';
import 'package:business_flutter/components/checkoutCard.dart';
import 'package:business_flutter/components/textField.dart';
import 'package:business_flutter/models/productModel.dart';
import 'package:business_flutter/pages/completion.dart';
import 'package:business_flutter/services/database/firebase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getInfo(String key) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString(key);
}
 setInfo(String key, String value) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.setString(key, value);
}


class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isEnable = true;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController= TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  String buttonText = "Confirm Order";


  List<ProductModel> getList() {
    final FirebaseService firebaseService = Provider.of<FirebaseService>(context, listen: false);
    return firebaseService.productList;
  }

   Future<void> confirmOrder() async{
    final FirebaseService firebaseService = Provider.of<FirebaseService>(context, listen: false);
    if(
    firstNameController.text.isEmpty&&lastNameController.text.isEmpty&&
        streetController.text.isEmpty&&stateController.text.isEmpty&&countryController.text.isEmpty
    ) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(milliseconds: 250),
          content: Text("Fill all Fields")));
    } else {
      saveUserInfo();
      String name = "${firstNameController.text}  ${lastNameController.text}";
      String address = "${streetController.text} ${stateController
          .text} ${countryController.text}";
      firebaseService.confirmOrder(name, address).then((value)
      {

        if(value!=null) {
          saveUserInfo();
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => OrderCompletion(trackingID: value)));
          setState(() {
            buttonText = "Order Confirmed";
            isEnable = false;
          });
        }
      });


    }

  }

  @override
  void initState() {
      getInfo("firstName").then((value) => value!=null ? firstNameController.text = value! : {});
      getInfo("lastName").then((value) => value!=null ? lastNameController.text = value! : {});
      getInfo("phoneNumber").then((value) => value!=null ? phoneNumberController.text = value! : {});
      getInfo("street").then((value) => value!=null ? streetController.text = value! : {});
      getInfo("state").then((value) => value!=null ? stateController.text = value! : {});
      getInfo("country").then((value) => value!=null ? countryController.text = value! : {});

    super.initState();
  }

  saveUserInfo(){
     setInfo("firstName", firstNameController.text);
     setInfo("lastName", lastNameController.text);
     setInfo("phoneNumber",  phoneNumberController.text);
     setInfo("street", streetController.text);
     setInfo("state", stateController.text);
     setInfo("country", countryController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F6F6F6"),
      appBar: AppBar(
        backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          leading: IconButton(onPressed: (){Navigator.pop(context);},icon: Icon(Icons.arrow_back, color: HexColor("#38C1CE"),)),
          title: Text("Checkout", style: TextStyle(color: HexColor("#38C1CE")))),
      bottomNavigationBar: BottomAppBar(
          child: GestureDetector(onTap: (){
            if(isEnable) {
              confirmOrder();
            }
          },
            child: Container(
                decoration: BoxDecoration(
                    color: HexColor("#38C1CE")
                ),
                height: 70,
                width: double.infinity,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(CupertinoIcons.cart, color: Colors.white, size: 30,),
                    Text(buttonText, style: const TextStyle(color: Colors.white,fontSize: 18),)
                  ],)
            ),
          )
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Order Items", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: getList().length,
                itemBuilder: (BuildContext context, int index) {
                  return CheckoutCard(productModel: getList()[index]);
                }),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Personal Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    CustomTextField(controller: firstNameController, hintText: "First Name", obscureText: false),
                    const SizedBox(height: 8.0),
                    CustomTextField(controller: lastNameController, hintText: "Last Name", obscureText: false),
                    const SizedBox(height: 8.0),
                    CustomTextField(controller: phoneNumberController, hintText: "Phone Number", obscureText: false),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Address Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomTextField(controller: streetController, hintText: "Street", obscureText: false),
                    const SizedBox(height: 8.0),
                    CustomTextField(controller: stateController, hintText: "State", obscureText: false),
                    const SizedBox(height: 8.0),
                    CustomTextField(controller: countryController, hintText: "Country", obscureText: false),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
