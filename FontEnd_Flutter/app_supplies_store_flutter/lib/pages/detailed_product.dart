import 'dart:convert';
import 'dart:ffi';

import 'package:app_supplies_store_flutter/pages/home.dart';
import 'package:app_supplies_store_flutter/providers/user_povider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class DetailProductPage extends StatefulWidget {
  const DetailProductPage({super.key});

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class Product {
  final String ProductID;
  String? productName;
  Int? price;
  Int? stockQuantity;
  String? description;
  String? picture;
  String? discontinued;
  String? storeID;
  String? categoryID;

  Product(
      {required this.ProductID,
      this.productName,
      this.description,
      this.discontinued,
      this.price,
      this.picture,
      this.categoryID,
      this.stockQuantity,
      this.storeID});
}

class _DetailProductPageState extends State<DetailProductPage> {
  List<Product> _products = [];
  // List<Category> _categories = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetProduct();
  }

  Future<void> _fetProduct() async {
    final String categoryId =
        ModalRoute.of(context)!.settings.arguments as String;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    final String apiUrl = dotenv.env['API_URL'] ?? 'No API URL Found';

    try {
      final product_response = await http.get(
        Uri.parse('$apiUrl/api/Products/GetByCategoryID/$categoryId'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer ${user?.token}',
        },
      );
      print('$apiUrl/api/Products/GetByCategoryID/$categoryId');
      print("Product Repons ${product_response.body}");

      if (product_response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(product_response.body);
        setState(() {
          _products = jsonList
              .map((json) => Product(
                    ProductID: json['ProductID'],
                    productName: json['productName'],
                    description: json['description'],
                    discontinued: json['discontinued'],
                    picture: json['picture'],
                    stockQuantity: json['stockQuantity'],
                    price: json['price'],
                    categoryID: json['categoryID'],
                    storeID: json['storeID'],
                  
                  ))
              .toList();
        });
        print("in product $_products");
      } else {
        throw Exception('Không thể lấy dữ liệu');
      }
    } catch (e) {
      throw Exception('Lỗi! Vui lòng thử lại sau ít phút');
    }
  }

  @override
  Widget build(BuildContext context) {
    final String categoryId =
        ModalRoute.of(context)!.settings.arguments as String;
    return GestureDetector(
      child: Scaffold(
        backgroundColor: const Color(0xfff1f4f8),
        appBar: AppBar(
          toolbarHeight: 75,
          backgroundColor: const Color(0xfff1f4f8),
          title: const Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Text(
                'Sản phẩm .....',
                style: TextStyle(
                  fontFamily: 'SourceSans',
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 5, 16, 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
