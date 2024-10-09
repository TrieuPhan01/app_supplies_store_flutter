import 'package:app_supplies_store_flutter/fields/indent_dield.dart';
import 'package:app_supplies_store_flutter/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class DetailProductPage extends StatefulWidget {
  const DetailProductPage({super.key});

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  int _count = 1;
  String formatCurrency(double amount) {
    final formatCurrency =
        NumberFormat.currency(locale: 'vi_VN', symbol: '₫', decimalDigits: 0);
    return formatCurrency.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final Producta detailProduct =
        ModalRoute.of(context)!.settings.arguments as Producta;

    return Scaffold(
      backgroundColor: const Color(0xfff1f4f8),
      appBar: AppBar(
        backgroundColor: const Color(0xfff1f4f8),
        title: const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
          child: Text(
            'Chi tiết sản phẩm',
            style: TextStyle(
              fontFamily: 'SourceSans',
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(100),
                  topLeft: Radius.circular(100),
                  topRight: Radius.circular(0),
                ),
                child: Image.network(
                  '${detailProduct.picture}',
                  width: double.infinity,
                  height: 280,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            IndentField(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${detailProduct.productName}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceSans',
                      color: Color(0xFF034C5F),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Mô Tả: ${detailProduct.description}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'MontserratSemiBold',
                      color: Colors.black,
                    ),
                  ),
                   const SizedBox(height: 5),
                  Text(
                    'Số lượng: ${detailProduct.stockQuantity}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'MontserratSemiBold',
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    thickness: 1,
                    color: Color(0xFF407F3E),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
                          child: Text(
                              'Số lượng ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'MontserratSemiBold',
                                color: Color(0xff59546c),
                              ),
                            ),),
                          Container(
                            width: 130,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: _count > 1 ? _decrement : null,
                                  icon: FaIcon(
                                    FontAwesomeIcons.minus,
                                    color:
                                        _count > 1 ? Colors.black : Colors.grey,
                                    size: 16,
                                  ),
                                ),
                                Text(
                                  _count.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: _count < detailProduct.stockQuantity! ? _increment: null,
                                  icon: const FaIcon(
                                    FontAwesomeIcons.plus,
                                    color: Colors.black,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 4),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Tổng giá tiền',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'MontserratSemiBold',
                                color: Colors.black,
                              ),
                            ),
                            Wrap(
                              alignment: WrapAlignment.end,
                              children: [
                                Text(
                                  formatCurrency(
                                      detailProduct.price!.toDouble() * _count),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'MontserratSemiBold',
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                 Padding(
                   padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                   child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 70, 161, 236),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 15),
                              ),
                      onPressed: () {
                        // Thêm logic xử lý đặt hàng ở đây
                        print(
                            'Đặt hàng: ${detailProduct.productName}, Số lượng: $_count, Tổng tiền: ${detailProduct.price!.toDouble() * _count}');
                      },
                      child: const Text('Đặt hàng',style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      letterSpacing: 0.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),),
                    ),
                   ),
                 )
                ],
                
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _increment() {
    setState(() {
      _count++;
    });
  }

  void _decrement() {
    setState(() {
      _count--;
    });
  }
}
