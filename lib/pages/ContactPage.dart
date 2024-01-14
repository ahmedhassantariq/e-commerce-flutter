import 'package:business_flutter/components/authTextField.dart';
import 'package:business_flutter/components/contactTextField.dart';
import 'package:business_flutter/pages/AskPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../services/database/firebase_service.dart';


class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}






class _ContactPageState extends State<ContactPage> {
  TextEditingController _subjectTextEditingController = TextEditingController();
  TextEditingController _messageTextEditingController = TextEditingController();
  late FirebaseService firebaseService;

  @override
  void initState() {
    firebaseService = Provider.of<FirebaseService>(context, listen: false);
    firebaseService.getFrequentQuestions();
    super.initState();
  }


  sendEmail(){
    if(_messageTextEditingController.text.isNotEmpty) {
      firebaseService.sendEmail(_subjectTextEditingController.text, _messageTextEditingController.text).then((value) {
      _subjectTextEditingController.clear();
      _messageTextEditingController.clear();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(duration: Duration(milliseconds: 500), content: Text("Message Sent")));});
    } else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(milliseconds: 500),
          content: Text("Message is Empty")));
    }
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(alignment: Alignment.centerLeft,child: Text("Talk to Us", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: HexColor("#38C1CE")))),
                FloatingActionButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const AskPage()));},backgroundColor: Colors.white,child: Icon(Icons.question_mark, color: HexColor("#38C1CE"), size: 35,),)
              ],
            ),
            const SizedBox(height: 8.0,),
            Align(alignment: Alignment.centerLeft, child: Padding(padding: EdgeInsets.all(8.0),child: Text("Email Support", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: HexColor("#38C1CE"))))),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                    style: TextStyle(color: Colors.blueGrey, fontSize: 14, fontWeight: FontWeight.w600),
                    "Drop us a line anytime at support@greenheaven.com. Our dedicated support team is here to assist you with any inquiries, from plant care tips to order assistance. Expect a prompt and personalized response to nurture your experience with Green Heaven."
                    )),
            const SizedBox(height: 8.0,),
            Align(alignment: Alignment.centerLeft, child: Padding(padding: EdgeInsets.all(8.0),child: Text("Phone Support", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: HexColor("#38C1CE"))))),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                    style: TextStyle(color: Colors.blueGrey, fontSize: 14, fontWeight: FontWeight.w600),
                    "Prefer to speak with a friendly voice? Our customer service hotline is open during business hours to provide immediate assistance. Call us at 1-800-GREEN-LOVE to connect with a knowledgeable representative who is passionate about helping you cultivate your personal paradise."
                )),
            const SizedBox(height: 8.0,),
            Align(alignment: Alignment.centerLeft, child: Padding(padding: EdgeInsets.all(8.0),child: Text("Visit our Heaven", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: HexColor("#38C1CE"))))),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                    style: TextStyle(color: Colors.blueGrey, fontSize: 14, fontWeight: FontWeight.w600),
                    "If you find yourself in the neighborhood, we welcome you to visit our physical store located at [Street Address, City, State, Zip Code]. Immerse yourself in the lush atmosphere, seek personalized advice, and explore our curated plant collections firsthand."
                )),
            const SizedBox(height: 8.0,),
            Align(alignment: Alignment.centerLeft, child: Padding(padding: EdgeInsets.all(8.0),child: Text("Message Us", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600, color: HexColor("#38C1CE"))))),

            const SizedBox(height: 8.0,),
            ContactTextField(controller: _subjectTextEditingController, hintText: "Subject"),
            const SizedBox(height: 8.0,),
            ContactTextField(controller: _messageTextEditingController, hintText: "Message"),
            const SizedBox(height: 12.0,),
            GestureDetector(
              onTap: (){sendEmail();},
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: HexColor("#38C1CE"),
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.send, color: Colors.white,),
                    SizedBox(width: 8.0),
                    Text("Send Message",style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ) ;
  }

}
