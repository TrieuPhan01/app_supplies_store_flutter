import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidget();
}

class _LoginWidget extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  FocusNode _phoneFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
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

  // void _submitForm() {
  //   if (_formKey.currentState!.validate()) {
  //     // Ẩn bàn phím
  //     FocusScope.of(context).unfocus();
  //     // Xử lý dữ liệu form ở đây
  //     print('Số điện thoại đã nhập: ${_phoneController.text}');
  //     print('Mật khẩu đã nhập: ${_passwordController.text}');
  //   }
  // }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      // Ẩn bàn phím
      FocusScope.of(context).unfocus();
      
      try {
        final response = await http.post(
          Uri.parse('https://localhost:7287/SignIn/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'PhoneNumber': _phoneController.text,
            'Password': _passwordController.text,
          }),
        );
        print("post API thành công");

        if (response.statusCode == 200) {
          // Xử lý phản hồi thành công
          final token = jsonDecode(response.body)['token'];
          print("token" + token);
          // TODO: Lưu token vào bộ nhớ an toàn (ví dụ: sử dụng package flutter_secure_storage)
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Đăng nhập thành công')),
          );
          
          // TODO: Chuyển hướng đến trang chính của ứng dụng
        } else {
          // Xử lý lỗi
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Đăng nhập thất bại. Vui lòng thử lại.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Có lỗi xảy ra. Vui lòng thử lại sau.')),
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
          leading: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(4, 12, 6, 0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
                size: 35,
              ),
              onPressed: () {
                Navigator.pop(context); // Quay về màn hình trước
              },
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 1, 5, 1),
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
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                  child: Text(
                    'Nhập số điện thoại và mật khẩu tài khoản của bạn. Nếu chưa có tài khoản hãy đăng ký',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      letterSpacing: 0.0,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 50, 16, 5),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _phoneController,
                          focusNode: _phoneFocusNode,
                          autofillHints: [AutofillHints.telephoneNumber],
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
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
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Mật khẩu',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
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
                        SizedBox(height: 70),
                        ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 70, 161, 236),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(14),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 15
                              ), 
                          ),
                          child: _isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
