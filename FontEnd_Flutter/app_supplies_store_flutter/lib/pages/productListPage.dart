import 'package:flutter/material.dart';

class Productlistpage extends StatefulWidget {
  const Productlistpage({super.key});

  @override
  State<Productlistpage> createState() => _Productlistpage();
}

class _Productlistpage extends State<Productlistpage> {
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
                'Danh sách hàng hóa',
                style: TextStyle(
                  fontFamily: 'MontserratSemiBold',
                  fontSize: 26,
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 5, 16, 0),
                child:
                    Text(
                      'Chào mừng quý khách đến với cửa hàng chúng tôi',
                      style: TextStyle(
                        fontFamily: 'SourceSans',
                        fontSize: 14,
                        letterSpacing: 0.0,
                      ),
                    ),
                 
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 8),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary, // Thay thế FlutterFlowTheme
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x411D2429),
                        offset: Offset(0.0, 1),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 1, 1, 1),
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
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 4, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Title',
                                  style: TextStyle(
                                    fontFamily: 'Outfit', // Thay thế font
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.fontSize,
                                    letterSpacing: 0.0,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 4, 8, 0),
                                  child: Text(
                                    'Subtext',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro', // Thay thế font
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
                                  EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                              child: Icon(
                                Icons.chevron_right_rounded,
                                color: Color(0xFF57636C),
                                size: 24,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 12, 4, 8),
                              child: Text(
                                '\$11.00',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontFamily: 'Readex Pro', // Thay thế font
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.fontSize,
                                  letterSpacing: 0.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
