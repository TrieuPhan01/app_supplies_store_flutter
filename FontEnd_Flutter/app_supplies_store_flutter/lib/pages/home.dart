import 'package:app_supplies_store_flutter/fields/indent_dield.dart';
import 'package:app_supplies_store_flutter/providers/user_povider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Product {
  final String imageUrl;
  final String title;
  final String location;

  Product(
      {required this.imageUrl, required this.title, required this.location});
}

class Category {
  final String name;
  final List<Product> products;

  Category({required this.name, required this.products});
}

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  late TextEditingController _searchController;
  List<Category> _categories = [];
  late String _selectedCategory;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _initializeCategories();
    _selectedCategory = _categories.first.name;
  }

  void _initializeCategories() {
    _categories = [
      Category(
        name: 'Phân bón',
        products: [
          Product(
            imageUrl:
                'https://images.unsplash.com/photo-1486299267070-83823f5448dd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw1fHxsb25kb258ZW58MHx8fHwxNzA2NjI3NjE0fDA&ixlib=rb-4.0.3&q=80&w=400',
            title: 'Phân NPK',
            location: 'Kho A',
          ),
          Product(
            imageUrl:
                'https://images.unsplash.com/photo-1486299267070-83823f5448dd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw1fHxsb25kb258ZW58MHx8fHwxNzA2NjI3NjE0fDA&ixlib=rb-4.0.3&q=80&w=400',
            title: 'Phân đạm',
            location: 'Kho B',
          ),
          Product(
            imageUrl:
                'https://images.unsplash.com/photo-1486299267070-83823f5448dd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw1fHxsb25kb258ZW58MHx8fHwxNzA2NjI3NjE0fDA&ixlib=rb-4.0.3&q=80&w=400',
            title: 'Phân lân',
            location: 'Kho C',
          ),
          Product(
            imageUrl:
                'https://images.unsplash.com/photo-1486299267070-83823f5448dd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw1fHxsb25kb258ZW58MHx8fHwxNzA2NjI3NjE0fDA&ixlib=rb-4.0.3&q=80&w=400',
            title: 'Phân kali',
            location: 'Kho D',
          ),
          Product(
            imageUrl:
                'https://images.unsplash.com/photo-1486299267070-83823f5448dd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw1fHxsb25kb258ZW58MHx8fHwxNzA2NjI3NjE0fDA&ixlib=rb-4.0.3&q=80&w=400',
            title: 'Phân tổng hợp',
            location: 'Kho E',
          ),
        ],
      ),

      Category(
        name: 'Thuốc BVTV',
        products: [
          Product(
            imageUrl:
                'https://images.unsplash.com/photo-1486299267070-83823f5448dd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw1fHxsb25kb258ZW58MHx8fHwxNzA2NjI3NjE0fDA&ixlib=rb-4.0.3&q=80&w=400',
            title: 'Thuốc Rầy',
            location: 'Kho A',
          ),
          Product(
            imageUrl:
                'https://images.unsplash.com/photo-1486299267070-83823f5448dd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw1fHxsb25kb258ZW58MHx8fHwxNzA2NjI3NjE0fDA&ixlib=rb-4.0.3&q=80&w=400',
            title: 'Thuốc Trừ sâu',
            location: 'Kho A',
          ),
          Product(
            imageUrl:
                'https://images.unsplash.com/photo-1486299267070-83823f5448dd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw1fHxsb25kb258ZW58MHx8fHwxNzA2NjI3NjE0fDA&ixlib=rb-4.0.3&q=80&w=400',
            title: 'Thuốc chuột',
            location: 'Kho A',
          ),
        ],
      ),
      Category(
        name: 'Cám heo',
        products: [
          Product(
            imageUrl:
                'https://images.unsplash.com/photo-1486299267070-83823f5448dd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw1fHxsb25kb258ZW58MHx8fHwxNzA2NjI3NjE0fDA&ixlib=rb-4.0.3&q=80&w=400',
            title: 'Cám Heo đẻ',
            location: 'Kho A',
          ),
          Product(
            imageUrl:
                'https://images.unsplash.com/photo-1486299267070-83823f5448dd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw1fHxsb25kb258ZW58MHx8fHwxNzA2NjI3NjE0fDA&ixlib=rb-4.0.3&q=80&w=400',
            title: '  Cám heo 365',
            location: 'Kho A',
          ),
          Product(
            imageUrl:
                'https://images.unsplash.com/photo-1486299267070-83823f5448dd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw1fHxsb25kb258ZW58MHx8fHwxNzA2NjI3NjE0fDA&ixlib=rb-4.0.3&q=80&w=400',
            title: 'Cám heo 1134',
            location: 'Kho A',
          ),
        ],
      ),

      // các danh mục khác
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
       backgroundColor: const Color(0xfff1f4f8),
        appBar: _buildAppBar(),
        body: SafeArea(
          child: HomeScreen(),
        ),
      ),
    );
  }

  Widget HomeScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          IndentField(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: _buildUserInfoCard(), // Thông tin người dùng
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 35, 0, 0),
            child: _buildCategoriesAndProducts(), // Thể loại và sản phẩm
          ),
          IndentField(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: _buildListcategories(), // Danh sách loại hàng hóa
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      toolbarHeight: 100,
      backgroundColor: Colors.green,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white, size: 26),
        onPressed: () {},
      ),
      title: _buildSearchField(),
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart, color: Colors.white, size: 26),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.white, size: 26),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Tìm kiếm',
        hintStyle:
            const TextStyle(color: Colors.white, fontFamily: 'SourceSans'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 62, 126, 64),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        prefixIcon: const Icon(Icons.search, color: Colors.white),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildUserInfoCard() {
    return Container(
      width: double.infinity,
      height: 125,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 224, 241, 245),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Color.fromARGB(255, 223, 221, 219), width: 2),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.qr_code_scanner_sharp,
                      color: Colors.green, size: 26),
                  onPressed: () {},
                ),
                Container(
                  width: 2,
                  height: 26,
                  color: const Color.fromARGB(255, 223, 221, 219),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                ),
                Consumer<UserProvider>(
                  builder: (context, userProvider, child) {
                   
                    return Text(
                      'Chào ${userProvider.user!.firstName?? ' '} ${userProvider.user!.lastName?? userProvider.user!.userName ?? 'bạn'} ',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 103, 5, 184),
                        fontSize: 18,
                        fontFamily: 'SourceSans',
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildInfoItem(Icons.history_sharp, 'Hóa đơn'),
              _buildInfoItem(Icons.library_books, 'Ghi nợ'),
              _buildInfoItem(Icons.storefront_sharp, 'Cửa hàng'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.black, size: 30),
          onPressed: () {},
        ),
        Text(label, style: const TextStyle(color: Colors.black)),
      ],
    );
  }

  Widget _buildCategoriesAndProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _categories
                .map((category) => _buildChoiceChip(category.name))
                .toList(),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _getSelectedCategoryProducts().length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, categories) {
              final product = _getSelectedCategoryProducts()[categories];
              return _buildProductItem(product);
            },
          ),
        ),
        const IndentField(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 35, 0, 12),
            child: Text(
              'Thông tin ưu đãi',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'SourceSans',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          child: Image.asset(
            'assets/images/imageDiscount.png',
            width: double.infinity,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildListcategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 35, 0, 5),
          child: Text(
            'Danh sách hàng hóa',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'SourceSans',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: ElevatedButton.icon(
            onPressed: () {},
            label: const Text(
              'Phân bón',
              style: TextStyle(
                fontFamily: 'SourceSans',
                letterSpacing: 0.0,
                fontSize: 17,
                color: Colors.black,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F8FC0),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              minimumSize: const Size(390, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: ElevatedButton.icon(
            onPressed: () {},
            label: const Text(
              'Thuốc BVTV',
              style: TextStyle(
                fontFamily: 'SourceSans',
                letterSpacing: 0.0,
                fontSize: 17,
                color: Colors.black,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F8FC0),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              minimumSize: const Size(390, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: ElevatedButton.icon(
            onPressed: () {},
            label: const Text(
              'Cám Heo',
              style: TextStyle(
                fontFamily: 'SourceSans',
                letterSpacing: 0.0,
                fontSize: 17,
                color: Colors.black,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F8FC0),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              minimumSize: const Size(390, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: ElevatedButton.icon(
            onPressed: () {},
            label: const Text(
              'Vật tư nông nghiệp',
              style: TextStyle(
                fontFamily: 'SourceSans',
                letterSpacing: 0.0,
                fontSize: 17,
                color: Colors.black,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F8FC0),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              minimumSize: const Size(390, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
          child: ElevatedButton.icon(
            onPressed: () {},
            label: const Text(
              'Các loại hạt giống',
              style: TextStyle(
                fontFamily: 'SourceSans',
                letterSpacing: 0.0,
                fontSize: 17,
                color: Colors.black,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F8FC0),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              minimumSize: const Size(390, 50), // Đặt kích thước cố định
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChoiceChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(
          label,
          style: TextStyle(
            fontFamily: 'SourceSans',
            color: _selectedCategory == label ? Colors.white : Colors.black,
          ),
        ),
        selected: _selectedCategory == label,
        onSelected: (bool selected) {
          if (selected) {
            setState(() {
              _selectedCategory = label;
            });
          }
        },
        selectedColor: Colors.lightGreen[400],
        backgroundColor: Colors.grey.shade100,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black12,
            width: _selectedCategory == label ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildProductItem(Product product) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: Image.network(
              product.imageUrl,
              width: 180,
              height: 130,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.location,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 4),
                Text(
                  product.title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Product> _getSelectedCategoryProducts() {
    print(_selectedCategory);
    return _categories
        .firstWhere((category) => category.name == _selectedCategory)
        .products;
  }
}
