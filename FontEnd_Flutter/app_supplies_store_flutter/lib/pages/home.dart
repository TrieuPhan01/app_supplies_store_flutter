import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _onMenuPressed() {
    print("button menu");
  }

  void _onCartPressed() {
    print("button shop-cart ");
  }

  void _onSearchPressed() {
    print("button srearch");
  }

  void _onChatPressed() {
    print("button chat");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            // color: Colors.red,
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 5, color: const Color.fromARGB(66, 53, 6, 221)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  // top: MediaQuery.of(context).size.height * 0.1,
                  top: 3,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    // ignore: sort_child_properties_last
                    child: const Center(
                      child: Text(
                        'container số 2',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    color: Colors.blue,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Container(
                    // ignore: sort_child_properties_last
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                            onPressed: _onMenuPressed,
                            icon: const Icon(Icons.menu)),
                        IconButton(
                            onPressed: _onCartPressed,
                            icon: const Icon(Icons.shopping_cart)),
                        Expanded(
                          child: Container(
                            color: Colors.amber,
                            child: TextField(
                              decoration: InputDecoration(
                                prefixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: _onSearchPressed,
                                ),
                                hintText: 'Tìm kiếm...',
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                        bottomLeft:
                            Radius.circular(55.0), // Bo góc dưới bên trái
                        bottomRight:
                            Radius.circular(55.0), // Bo góc dưới bên phải
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.1,
                  left: 20,
                  right: 20,
                  height: 110,
                  child: Container(
                    // ignore: sort_child_properties_last
                    child: const Center(
                      child: Text(
                        'container số 3',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 244, 247, 244),
                        borderRadius: BorderRadius.circular(7)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
