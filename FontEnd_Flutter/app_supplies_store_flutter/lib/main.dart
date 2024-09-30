import 'package:app_supplies_store_flutter/pages/login.dart';
import 'package:app_supplies_store_flutter/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  // Đảm bảo Flutter framework đã được khởi tạo trước khi tải .env
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const SuppliesStore());
}

class SuppliesStore extends StatelessWidget {
  const SuppliesStore({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Mặc định trang login
      initialRoute: '/home',
      routes: {
        '/login': (context) => const WelcomePage(),
        '/home': (context) => const LoginWidget(),
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
