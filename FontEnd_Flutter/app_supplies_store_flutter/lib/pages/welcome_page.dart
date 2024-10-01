import 'package:app_supplies_store_flutter/fields/indent_dield.dart';
import 'package:app_supplies_store_flutter/pages/login.dart';
import 'package:app_supplies_store_flutter/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomeState();
}

class _WelcomeState extends State<WelcomePage> {
  void _onLogin() {
    print("button chat");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.asset(
                      'assets/images/imgbackground.jpg', // Đường dẫn tới ảnh trong thư mục assets
                    ).image,

                  ),
                ),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(26, 125, 187, 223),
                        Colors.white,
                      ],
                      stops: [0, 1],
                      begin: AlignmentDirectional(0, -2),
                      end: AlignmentDirectional(0, 1),
                    ),
                  ),
                  alignment: const AlignmentDirectional(0, 1),
                  child: const Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 70),
                      Icon(
                        Icons.store,
                        color: Colors.green,
                        size: 120,
                      ),
                      IndentField(
                        // padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 25),
                        child: Text(
                          'Chào mừng đến với cửa hàng Vật Tư Nông Nghiệp',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'MontserratBlack',
                            letterSpacing: 0.0,
                            fontSize: 28,
                            // fontWeight: FontWeight.bold,
                            color: Color(0xFF14181B),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(
                maxWidth: 670,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(20, 12, 20, 12),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginWidget()),
                          );
                        },
                        icon: const Icon(
                          Icons.phone,
                          color: Colors.white,
                          size: 26,
                        ),
                        label: const Text(
                          'Đăng nhập bằng Số Điện Thoại',
                          style: TextStyle(
                            fontFamily: 'SourceSans',
                            letterSpacing: 0.0,
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                      child: Text(
                        'Hoặc đăng nhập bằng cách khác',
                        style: TextStyle(
                          fontFamily: 'SourceSans',
                          letterSpacing: 0.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    // Login to Google
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(20, 12, 20, 12),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.google,
                          color: Colors.black,
                          size: 26,
                        ),
                        label: const Text('Đăng nhập bằng google',
                         style: TextStyle(
                            fontFamily: 'SourceSans',
                            letterSpacing: 0.0,
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(20, 12, 20, 64),
                      child: ElevatedButton.icon(
                        onPressed: () {
                           Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupWidget()),
                          );
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.user,
                          color: Colors.white,
                          size: 26,
                        ),
                        label: const Text('Đăng ký tài khoản',
                         style: TextStyle(
                            fontFamily: 'SourceSans',
                            letterSpacing: 0.0,
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
