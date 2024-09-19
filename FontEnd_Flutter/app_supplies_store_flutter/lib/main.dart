import 'package:app_supplies_store_flutter/pages/home.dart';
import 'package:app_supplies_store_flutter/pages/login.dart';
import 'package:app_supplies_store_flutter/pages/signup.dart';
import 'package:app_supplies_store_flutter/pages/welcome_page.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const SuppliesStore());
}

class SuppliesStore extends StatelessWidget {
  const SuppliesStore({super.key});

  @override
  Widget build(BuildContext context) {
 
    return MaterialApp(
      //Mặc định trang login
     initialRoute: '/login',
     routes: {
        
        '/login': (context) => const WelcomePage(),
        '/home': (context) => const HomeScreen(),
        '/logup': (context) => const LogupScreen(),
      },
    );
  }
}





class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: const Center(
        child: Text('This is the Login Screen'),
      ),
    );
  }
}

class LogupScreen extends StatelessWidget {
  const LogupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logup Screen'),
      ),
      body: const Center(
        child: Text('This is the Logup Screen'),
      ),
    );
  }
}


