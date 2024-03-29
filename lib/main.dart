import 'package:business_flutter/components/theme.dart';
import 'package:business_flutter/services/auth/auth_gate.dart';
import 'package:business_flutter/services/auth/auth_service.dart';
import 'package:business_flutter/services/database/firebase_service.dart';
import 'package:business_flutter/services/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



// -d chrome --web-renderer html
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
      ChangeNotifierProvider(create: (context) => AuthService(),
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FirebaseService>(create: (context)=>FirebaseService(),
        child: MaterialApp(
          theme: myThemeData,
          debugShowCheckedModeBanner: false,
          scrollBehavior: const ScrollBehavior().copyWith(scrollbars: false),
          title: 'Green Heaven',
          home: const AuthGate(),
        ));
  }
}

