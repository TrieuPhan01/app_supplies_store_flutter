import 'package:app_supplies_store_flutter/providers/product_provider.dart';
import 'package:flutter/material.dart';

class DetailProductPage extends StatefulWidget {
  const DetailProductPage({super.key});

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {

  @override
  Widget build(BuildContext context) {
     final Producta detailProduct = ModalRoute.of(context)!.settings.arguments as Producta;
     print(detailProduct);
    return GestureDetector(
      child: Scaffold(
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
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1593692557859-b209f9f4ced4?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxOXx8c291dGglMjBhbWVyaWNhfGVufDB8fHx8MTcwNjYyNTU2N3ww&ixlib=rb-4.0.3&q=80&w=400',
                    width: double.infinity,
                    height: 280,
                    fit: BoxFit.cover,
                  ),
                ),
              )

              
            ],
          ),
        ),
      ),
    );
  }
}
