import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/login_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    String token = '';

    void getToken() async {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      setState(() {
        token = preferences.getString('token')!;
      });
    }

    @override
    void initState() {
      super.initState();
      getToken();
    }

    return token != ""
        ? Scaffold(
            appBar: AppBar(
              title: const Text("CEOSI"),
            ),
            body: const HomeScreen(),
          )
        : const LoginScreen();
  }
}
