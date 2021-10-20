import 'models/Auth.dart';
import 'package:chatapppart1/Providers/UserProvider.dart';
import 'package:chatapppart1/Screens/AuthScreen.dart';
import 'package:chatapppart1/Screens/firstSignupScreen.dart';
import 'package:chatapppart1/Screens/HomeScreen.dart';
import 'package:chatapppart1/Screens/TestPage.dart';
import 'package:provider/provider.dart';
import './Providers/Question.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(
      MyApp()
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(_)=>AuthProvider() ),
//        ChangeNotifierProxyProvider<AuthProvider,UserProvider>(
//          create:(BuildContext ctx)=>UserProvider(),
//          update:(BuildContext ctx,auth,prevUser)=>UserProvider()..setToken(auth.getToken)
//        ),

        ],

        child: Consumer<AuthProvider>(
          builder: (ctx,auth,_ )
          => MaterialApp(

          debugShowCheckedModeBanner: false,

          home: AuthScreen(),
              routes: {
              TestPage.Route:(_)=>TestPage(),
              HomeScreen.route:(_)=>HomeScreen(),
                AuthScreen.routeName:(_)=>AuthScreen(),
                FirstSignUpPage.route:(_)=>FirstSignUpPage(),
              },
          ),)

    );
  }
}
