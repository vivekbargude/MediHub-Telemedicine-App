import 'package:flutter/material.dart';
import 'package:medihub/constants/routes.dart';
import 'package:medihub/features/chat/services/chatData.dart';
import 'package:medihub/features/pharmacy/screens/productSelected.dart';
import 'package:medihub/features/home/screens/home.dart';
import 'package:medihub/features/home/screens/home1.dart';
import 'package:medihub/providers/user_provider.dart';
import 'package:medihub/utils/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart'; // Import the provider package

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  authToken = sharedPreferences.getString('x-auth-token');
  print("Token : $authToken");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductData()),
        ChangeNotifierProvider(create: (context) => ChatData()),
        ChangeNotifierProvider(create: (context) => UserProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.onGenerateRoute,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: authToken == null ? SplashScreen() : HomeScreen(),
    );
  }
}
