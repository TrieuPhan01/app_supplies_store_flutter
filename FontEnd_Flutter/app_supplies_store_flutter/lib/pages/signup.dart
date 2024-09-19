import 'package:flutter/material.dart';

class SignupWidget extends StatefulWidget {
  const SignupWidget({Key? key}) : super(key: key);

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  final _formKey = GlobalKey<FormState>();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _autoValidate = false;

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    setState(() {
      _autoValidate = true;
    });
    if (_formKey.currentState!.validate()) {
      // Xử lý dữ liệu form ở đây
      print('Họ đã nhập: ${_firstnameController.text}');
      print('Tên đã nhập: ${_lastnameController.text}');
      print('Email đã nhập: ${_emailController.text}');
      print('Số điện thoại đã nhập: ${_phoneController.text}');
      print('Mật khẩu đã nhập: ${_passwordController.text}');
    }
  }

  bool _isPasswordValid(String password) {
    if (password.length < 6) return false;
    if (!password.contains(RegExp(r'[0-9]'))) return false;
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: const Padding(
            padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
            child: Text(
              'Đăng ký thông tin người dùng',
              style: TextStyle(
                fontFamily: 'SourceSans',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 30, 20, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 224, 231, 226),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.black,
                    size: 24,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
              child: Form(
                key: _formKey,
                autovalidateMode: _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _firstnameController,
                      decoration: const InputDecoration(
                        labelText: 'Nhập Họ của bạn',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập Họ của bạn';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _lastnameController,
                      decoration: const InputDecoration(
                        labelText: 'Nhập Tên của bạn',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập Tên của bạn';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập Email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Vui lòng nhập một địa chỉ email hợp lệ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Số điện thoại',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập số điện thoại';
                        }
                        if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                          return 'Vui lòng nhập số điện thoại hợp lệ (10 chữ số)';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Mật khẩu',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
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
                        if (!_isPasswordValid(value)) {
                          return 'Mật khẩu phải có ít nhất 6 ký tự, bao gồm chữ hoa, số và ký tự đặc biệt';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      decoration: InputDecoration(
                        labelText: 'Nhập lại mật khẩu',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập lại mật khẩu';
                        }
                        if (value != _passwordController.text) {
                          return 'Mật khẩu không khớp';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 70, 161, 236),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100,
                              vertical: 15
                            ), 
                        ),
                        child: const Text(
                          'Đăng ký tài khoản',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            letterSpacing: 0.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}