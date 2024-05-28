import 'package:findit/features/app/splash_screen/splash_screen.dart';
import 'package:findit/features/user_auth/presentation/pages/login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options: const FirebaseOptions(
      apiKey: "AIzaSyDev_ka_jtMTM7PLYkqFNnp--YnrIZPzkk",
      appId: "1:824275229257:web:6c3d39dc6fbc3273d6fd98", 
      messagingSenderId: "824275229257", 
      projectId: "findit-cb8ed",
      )
      );
  }

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(  
      debugShowCheckedModeBanner: false,    
      home: SplashScreen(
        child: LoginPage(),
      )
    );
  }
}

