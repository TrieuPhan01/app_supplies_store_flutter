import 'package:app_supplies_store_flutter/providers/user_povider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
class MomoWidget extends StatefulWidget {
  const MomoWidget({super.key});

  @override
  State<MomoWidget> createState() => _MomoWidgetState();
}

class _MomoWidgetState extends State<MomoWidget> {
   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetMomoPayment();
  }

  Future<void> _fetMomoPayment() async {
    final String categoryId =
        ModalRoute.of(context)!.settings.arguments as String;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    final String apiUrl = dotenv.env['API_URL'] ?? 'No API URL Found';

    try {
      final productResponse = await http.get(
        Uri.parse('$apiUrl/api/Products/GetByCategoryID/$categoryId'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer ${user?.token}',
        },
      );
      if (productResponse.statusCode == 200) {
      } else {
        throw Exception('Không thể lấy dữ liệu');
      }
    } catch (e) {
      print(e);
      throw Exception('Lỗi! Vui lòng thử lại sau ít phút');
    }
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
    
  }
}
