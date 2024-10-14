import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class MomoWidget extends StatefulWidget {
  const MomoWidget({super.key});

  @override
  State<MomoWidget> createState() => _MomoWidgetState();
}

class _MomoWidgetState extends State<MomoWidget> {
  var uuid = Uuid();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetMomoPayment();
  }

  Future<void> _fetMomoPayment() async {
    final args =
        jsonDecode(ModalRoute.of(context)!.settings.arguments.toString());
    print("args $args");
    // final
    final String apiUrl = dotenv.env['API_URL'] ?? 'No API URL Found';

    try {
      print('$apiUrl/api/Momo/create');
      final momotResponse =
          await http.post(Uri.parse('$apiUrl/api/Momo/create'),
              headers: <String, String>{
                'Content-Type': 'application/json',
              },
              body: jsonEncode({
                "id": "${uuid.v4()}",
                "total": "${args['totalAmount']}",
                "orderID": "${args['OrderId']}"
              }));
      print(jsonEncode({
        "id": "${uuid.v4()}",
        "total": "${args['totalAmount']}",
        "orderID": "${args['OrderId']}"
      }));
      print(momotResponse.statusCode);
      print(momotResponse.body);
      if (momotResponse.statusCode == 200) {
         Map<String, dynamic> data = jsonDecode(momotResponse.body);
         print("in ra data ${data['payUrl']}");
         launchUrl(Uri.parse(data['payUrl']));
      } else {
        throw Exception('Không thể lấy dữ liệu');
      }
    } catch (e) {
      print(e);

    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(child: Text("Đang tiến hành giao dịch"),)
      ),
    );
  }
}
