import 'package:app_supplies_store_flutter/main.dart';
import 'package:app_supplies_store_flutter/pages/home.dart';
import 'package:app_supplies_store_flutter/pages/productListPage.dart';
import 'package:flutter/material.dart';

class ViewAppScreen extends StatefulWidget {
  const ViewAppScreen({super.key});

  @override
  State<ViewAppScreen> createState() => _ViewAppScreen();
}

class _ViewAppScreen extends State<ViewAppScreen> {
  int _currentIndex = 0;
  List<Widget> _pages = [];
  @override
  void initState() {
    super.initState();

    _pages = [
      const HomeScreenPage(), // Trang Home
      const Productlistpage(), // Trang Sản phẩm
      const Productlistpage(), // Trang Thông tin cá nhân
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // appBar: _buildAppBar(),
        appBar: AppBar(
          toolbarHeight: 6,
          backgroundColor: Colors.green,
        ),
        body: SafeArea(
          child: IndexedStack(
            index: _currentIndex, // Trang hiện tại được hiển thị
            children: _pages, // Danh sách các trang
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex, // Trang hiện tại
          onTap: (int index) {
            setState(() {
              _currentIndex = index; // Cập nhật trang khi nhấn vào mục khác
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Sản phẩm',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Thông tin cá nhân',
            ),
          ],
        ),
      ),
    );
  } 
}
