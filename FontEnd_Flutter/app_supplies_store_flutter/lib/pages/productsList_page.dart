import 'dart:convert';
import 'package:app_supplies_store_flutter/pages/home.dart';
import 'package:app_supplies_store_flutter/providers/product_provider.dart';
import 'package:app_supplies_store_flutter/providers/user_povider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

// class Product {
//   final String ProductID;
//   String? productName;
//   int? price;
//   int? stockQuantity;
//   String? description;
//   String? picture;
//   bool? discontinued;
//   String? storeID;
//   String? categoryID;

//   Product({
//     required this.ProductID,
//     this.productName,
//     this.description,
//     this.discontinued,
//     this.price,
//     this.picture,
//     this.categoryID,
//     this.stockQuantity,
//     this.storeID,
//   });
// }

class _ProductListPageState extends State<ProductListPage> {
  late Producta roduct;
  List<Producta> _products = [];
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
      final productResponse = await http.get(
        Uri.parse('$apiUrl/api/Products/GetByCategoryID/$categoryId'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer ${user?.token}',
        },
      );
      if (productResponse.statusCode == 200) {
        List<dynamic> jsonList = json.decode(productResponse.body);
        setState(() {
          _products = jsonList
              .map((json) => Producta(
                    ProductID: json['productID'] ?? '',
                    productName: json['productName'] ?? 'No Name',
                    description: json['description'] ?? 'No Description',
                    discontinued: json['discontinued'] ?? false,
                    picture: json['picture'] ?? '',
                    stockQuantity: json['stockQuantity'] ?? 0,
                    price: json['price'] ?? 0,
                    categoryID: json['categoryID'] ?? '',
                    storeID: json['storeID'] ?? '',
                  ))
              .toList();
        });
        print("in product $_products");
      } else {
        throw Exception('Không thể lấy dữ liệu');
      }
    } catch (e) {
      print(e);
      throw Exception('Lỗi! Vui lòng thử lại sau ít phút');
    }
  }

   Widget _buidProductList() {
    return Column(
      children: _products.map((product) {
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
                            product.productName ?? '',
                            style: const TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 19,
                              letterSpacing: 0.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 4, 8, 0),
                            child: Text(
                              product.description ?? '',
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
                             '/detailProduct',
                               arguments:
                                  product, 
                            );
                          },
                          icon: const Icon(
                            Icons.chevron_right_rounded,
                            color: Color(0xFF57636C),
                            size: 45,
                          ),
                        ),
                      ),
                      Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 0, 4, 8),
                              child: Text(
                                '${product.price} VNĐ',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontFamily: 'Outfit', 
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.fontSize,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold
                                ),
                              ),),
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
                'Các loại sản phẩm',
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
              _buidProductList()
            ],
          ),
        ),
      ),
    );
  }
}
