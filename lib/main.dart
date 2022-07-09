import 'package:amazon_clone_flutter/constants/global_varaibles.dart';
import 'package:amazon_clone_flutter/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone_flutter/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(
          settings), // will execute every time after we've used push name callback
      home: const AuthScreen(),
    );
  }
}



//  Scaffold(
//         appBar: AppBar(
//           title: const Text("App bar title "),
//         ),
//         body: Column(
//           children: [
//             const Center(
//               child: Text(
//                 'Flutter Demo Home Page',
//               ),
//             ),
//             Builder(builder: (context) {
//               return ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, AuthScreen.routeName);
//                 },
//                 child: const Text(
//                   "Click Here !",
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),