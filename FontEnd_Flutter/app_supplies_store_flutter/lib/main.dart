import 'package:app_supplies_store_flutter/pages/home.dart';
import 'package:app_supplies_store_flutter/pages/login.dart';
import 'package:app_supplies_store_flutter/pages/profile.dart';
import 'package:app_supplies_store_flutter/pages/signup.dart';
import 'package:app_supplies_store_flutter/pages/viewApp.dart';
import 'package:app_supplies_store_flutter/pages/welcome_page.dart';
import 'package:app_supplies_store_flutter/providers/user_povider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Đảm bảo Flutter framework đã được khởi tạo trước khi tải .env
  await dotenv.load(fileName: ".env");
  runApp(const SuppliesStore());
}

class SuppliesStore extends StatelessWidget {
  const SuppliesStore({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Đăng ký Provider
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Supplies Store',
        initialRoute: '/welcome', // Mặc định trang welcome
        routes: {
          '/welcome': (context) => const WelcomePage(),
          '/login': (context) => const LoginWidget(),
          '/home': (context) => const HomeScreenPage(),
          '/signup': (context) => const SignupWidget(),
          '/viewapp': (context) => const ViewAppScreen(),
          '/profile': (context) => const ProfileWidget(),
        },
      ),
    );
  }
}
