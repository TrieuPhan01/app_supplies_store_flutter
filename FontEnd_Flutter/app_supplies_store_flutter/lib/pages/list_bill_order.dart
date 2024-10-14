import 'dart:async';
import 'package:app_supplies_store_flutter/fields/indent_dield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListBillOrdersWidget extends StatefulWidget {
  const ListBillOrdersWidget({super.key});

  @override
  State<ListBillOrdersWidget> createState() => _ListBillOrdersWidgetState();
}

Widget _buidBillOrderList() {
  return Padding(
    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
    child: ButtonBar(),
  );
}

Future<void> _order() async {}

class _ListBillOrdersWidgetState extends State<ListBillOrdersWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          excludeHeaderSemantics: true,
          title: Text("Lich su mua hang"),
        ),
        body: SingleChildScrollView(
          child: IndentField(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          print("aaaa");
                        },
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          height: 110,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 247, 241, 241),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      child: Text(
                                        '20/10/2016',
                                        style: TextStyle(
                                          fontFamily: 'SourceSans',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      child: Text(
                                        'Thanh toans Online',
                                        style: TextStyle(
                                          fontFamily: 'SourceSans',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 30, 10, 0),
                                      child: Text('So tien: 20000 VND',
                                      style: TextStyle(
                                          fontFamily: 'SourceSans',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      child: Text('Cua hang Phan Dinh Du',
                                      style: TextStyle(
                                          fontFamily: 'SourceSans',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: const Divider(
                          thickness: 1,
                          color: Color.fromARGB(255, 214, 219, 214),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
