import 'dart:convert';

import 'package:app_supplies_store_flutter/providers/user_povider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Productlistpage extends StatefulWidget {
  const Productlistpage({super.key});
  @override
  State<Productlistpage> createState() => _Productlistpage();
}

class Category {
  final String categoryID;
  String? name;
  String? unit;
  String? note;

  Category({required this.categoryID, this.name, this.unit, this.note});
}

class _Productlistpage extends State<Productlistpage> {
  List<Category> _categories = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetCategory();
  }

  Future<void> _fetCategory() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    final String apiUrl = dotenv.env['API_URL'] ?? 'No API URL Found';

    try {
      final cat_response = await http.get(
        Uri.parse('$apiUrl/api/Categories/GetAll'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer ${user?.token}',
        },
      );

      if (cat_response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(cat_response.body);
        setState(() {
          _categories = jsonList
              .map((json) => Category(
                    categoryID: json['categoryID'],
                    name: json['name'],
                    unit: json['unit'],
                    note: json['note'],
                  ))
              .toList();
        });
      } else {
        throw Exception('Không thể lấy dữ liệu');
      }
    } catch (e) {
      throw Exception('Lỗi! Vui lòng thử lại sau ít phút');
    }
  }

  Widget _buidCategoriesList() {
    return Column(
      children: _categories.map((category) {
        return Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 16, 8),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 3,
                  color: Colors.white,
                  offset: Offset(0.0, 1),
                ),
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 1, 1, 1),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1760&q=80',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 4, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.name ?? '',
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.fontSize,
                              letterSpacing: 0.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 4, 8, 0),
                            child: Text(
                              category.note ?? '',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.fontSize,
                                letterSpacing: 0.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                             '/product',
                              arguments:
                                  category.categoryID, 
                            );
                            print(category.categoryID);
                          },
                          icon: const Icon(
                            Icons.chevron_right_rounded,
                            color: Color(0xFF57636C),
                            size: 45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: const Color(0xfff1f4f8),
        appBar: AppBar(
          toolbarHeight: 75,
          backgroundColor: const Color(0xfff1f4f8),
          title: const Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Text(
                'DS Sản Phẩm',
                style: TextStyle(
                  fontFamily: 'SourceSans',
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              )),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 12, 0),
              child: IconButton(
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Color(0xff59646c),
                  size: 26,
                ),
                onPressed: () {
                  print('IconButton pressed ...');
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 5, 16, 0),
                child: Text(
                  'Chào mừng quý khách đến với cửa hàng chúng tôi',
                  style: TextStyle(
                    fontFamily: 'SourceSans',
                    fontSize: 14,
                    letterSpacing: 0.0,
                  ),
                ),
              ),
              _buidCategoriesList()
            ],
          ),
        ),
      ),
    );
  }
}
