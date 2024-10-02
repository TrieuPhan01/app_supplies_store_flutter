import 'package:app_supplies_store_flutter/fields/indent_dield.dart';
import 'package:app_supplies_store_flutter/pages/home.dart';
import 'package:app_supplies_store_flutter/providers/user_povider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidget();
}

class _LoginWidget extends State<LoginWidget> {
  final String apiUrl = dotenv.env['API_URL'] ?? 'No API URL Found';
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Ẩn bàn phím
      FocusScope.of(context).unfocus();

      try {
        print('$apiUrl/SignIn/');
        final response = await http.post(
           Uri.parse('$apiUrl/SignIn/'),
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: {
            'PhoneNumber': _phoneController.text,
            'Password': _passwordController.text,
          },
        );

        if (response.statusCode == 200) {
          final token = response.body;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Đăng nhập thành công'),
            ),
          );

          final user_response = await http.get(
            Uri.parse('$apiUrl/api/User/GetByToken/'),
            headers: <String, String>{
              'Content-Type': 'application/x-www-form-urlencoded',
              'Authorization': 'Bearer $token',
            },
          );

          final userData =
              jsonDecode(user_response.body) as Map<String, dynamic>;
          print(userData);

          User user = User(
            id: userData['id'] as String,
            name: userData['userName'] as String?, 
            roles: userData['roles'] as String?,
            userName: userData['userName'] as String?,
            firstName: userData['firstName'] as String?,
            lastName: userData['lastName'] as String?,
            email: userData['email'] as String?,
            phoneNumber: userData['phoneNumber'] as String?,
            avata: userData['avata'] as String?,
          );
          final userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.setUser(user);

          // Navigator.pushReplacementNamed(context, '/home');
          Navigator.pushNamed(context, '/viewapp');

        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Tên đăng nhập hoặc mật khẩu không đúng')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Có lỗi xảy ra. Vui lòng thử lại sau.')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          automaticallyImplyLeading: false,
          leading: IndentField(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.pop(context); // Quay về màn hình trước
                },
              ),
            ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const IndentField(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                    child: Text(
                      'Đăng nhập bằng số điện thoại',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'SourceSans',
                        letterSpacing: 0.0,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const IndentField(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                      'Nhập số điện thoại và mật khẩu tài khoản của bạn. Nếu chưa có tài khoản hãy đăng ký',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0.0,
                      ),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: IndentField(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 5),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _phoneController,
                            focusNode: _phoneFocusNode,
                            autofillHints: const [
                              AutofillHints.telephoneNumber
                            ],
                            autofocus: false,
                            obscureText: false,
                            decoration: const InputDecoration(
                              labelText: 'Số điện thoại',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập số điện thoại';
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) => _submitForm(),
                          ),
                          const SizedBox(height: 35),
                          TextFormField(
                            controller: _passwordController,
                            focusNode: _passwordFocusNode,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              labelText: 'Mật khẩu',
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(_obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập mật khẩu';
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) => _submitForm(),
                          ),
                          const SizedBox(height: 70),
                          ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 70, 161, 236),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text(
                                    'Đăng nhập',
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      letterSpacing: 0.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
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
      ),
    );
  }
}
