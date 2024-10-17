import 'dart:convert';

import 'package:app_supplies_store_flutter/fields/indent_dield.dart';
import 'package:app_supplies_store_flutter/providers/user_povider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Product {
   String imageUrl;
   String title;
   String location;
   int? stockQuantity;

  Product({
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.stockQuantity,
  });
}

class Category {
  final String name;
  final List<Product> products;

  Category({
    required this.name,
    required this.products,
  });
}

class SumProductWidget extends StatefulWidget {
  const SumProductWidget({super.key});

  @override
  State<SumProductWidget> createState() => _SumProductWidgetState();
}

class _SumProductWidgetState extends State<SumProductWidget> {
  bool _showFertilizerProducts = false;
  List<Category> _categories = [];
  @override
  void initState() {
    super.initState();
    _fetchListCategoriesProduct();
  }
  

  void _handleUnauthorized(BuildContext context) {
  // Hiển thị thông báo
  Fluttertoast.showToast(
    msg: "Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );

  // Điều hướng về trang đăng nhập
  Navigator.pushReplacementNamed(context, '/login');
}

  Future<void> _fetchListCategoriesProduct() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    final String apiUrl = dotenv.env['API_URL'] ?? 'No API URL Found';
    final responseProduc = await http.get(
      Uri.parse('$apiUrl/api/Categories/categoryProduct'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer ${user?.token}',
      },
    );

    if (responseProduc.statusCode == 200) {
      final List<dynamic> categoryData = jsonDecode(responseProduc.body);
      // Lấy danh mục từ dữ liệu API và ánh xạ sang list _categories
      final List<Category> fetchedCategories = categoryData
          .map((categoryJson) => Category(
                name: categoryJson['name'],
                products: (categoryJson['products'] as List)
                    .map((productJson) => Product(
                          imageUrl: productJson['picture'],
                          title: productJson['productName'],
                          location: productJson['price'] != null
                              ? ('${productJson['price']} đ')
                              : '0',
                          stockQuantity: productJson['stockQuantity'],
                        ))
                    .toList(),
              ))
          .toList();
      if (mounted) {
        setState(() {
          _categories = fetchedCategories;
        });
      }

      print("in categoryDataaaaaaaa $categoryData");
    }
    else if(responseProduc.statusCode == 401){
      _handleUnauthorized(context);

    }
  }
  void _toggleFertilizerProducts() {
    setState(() {
      _showFertilizerProducts = !_showFertilizerProducts;
    });
    print(_showFertilizerProducts);
  }

  List<Product> _getSelectedCategoryProducts(String categoryName) {
    if (_categories.isEmpty) {
      return []; // Trả về danh sách rỗng nếu chưa có danh mục nào hoặc danh mục trống
    }
    return _categories
        .firstWhere(
          (category) => category.name == categoryName,
          orElse: () => Category(name: '', products: []),
        )
        .products;
  }

  Widget _buildProductItem(String categoryName) {
    final _listProduct = _getSelectedCategoryProducts(categoryName);
    return Column(
      children: _listProduct.map((product) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xfff1f4f8),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                Text(
                  product.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SourceSans',
                    color: Color(0xFF034C5F),
                  ),
                ),
                Text(
                  '${product.stockQuantity??'???'}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SourceSans',
                    color: Color.fromARGB(255, 140, 17, 40),
                  ),
                ),
              ],
            
                ),
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Divider(
                  thickness: 1,
                  color: Color.fromARGB(255, 214, 219, 214),
                ),
              )
          ],
        );
      }).toList(),
      
    );
  }

  Widget _buidCategoriesItem() {
    return Column(
      children: _categories.map((categoryMap) {
        return Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _toggleFertilizerProducts,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff2099ae),
                  foregroundColor: Color(0xFF034C5F),
                  minimumSize: Size(MediaQuery.sizeOf(context).width * 0.8,
                      50), // Đặt kích thước tối thiểu
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text(
                  categoryMap.name,
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize:
                        Theme.of(context).textTheme.headlineSmall?.fontSize,
                    letterSpacing: 0.0,
                  ),
                ),
              ),
              if (_showFertilizerProducts)
                 Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: _buildProductItem(categoryMap.name),
                ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Divider(
                  thickness: 1,
                  color: Color.fromARGB(255, 231, 206, 143),
                ),
              )
            ],
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1f4f8),
      appBar: AppBar(
        backgroundColor: const Color(0xfff1f4f8),
        title: const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
          child: Text(
            "Số lượng hàng tồn kho",
            style: TextStyle(
              fontFamily: 'SourceSans',
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: IndentField(
          child: _buidCategoriesItem(),
        ),
      ),
    );
  }
}
