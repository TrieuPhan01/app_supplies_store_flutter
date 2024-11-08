import 'dart:convert';
import 'dart:io';

import 'package:app_supplies_store_flutter/fields/indent_dield.dart';
import 'package:app_supplies_store_flutter/providers/customer_povider.dart';
import 'package:app_supplies_store_flutter/providers/user_povider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UpdateProfileWidget extends StatefulWidget {
  const UpdateProfileWidget({super.key});

  @override
  State<UpdateProfileWidget> createState() => _UpdateProfileWidgetState();
}

class _UpdateProfileWidgetState extends State<UpdateProfileWidget> {
  File? _image;
  int? _gender;
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();

  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('Không có hình ảnh nào được chọn.');
      }
    });
  }

  Future<void> _updateProfile() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    final String apiUrl = dotenv.env['API_URL'] ?? 'No API URL Found';
    try {
      final dataReponse = await http.patch(
        Uri.parse(
            '$apiUrl/api/Customers/UpdateProfile/${customerProvider.customer?.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user?.token}',
        },
        body: jsonEncode({
          "age": int.parse(_ageController.text),
          "sex": _gender,
          "address": _addressController.text.toString(),
          "avatar": "string"
        }),
      );
     
        print(dataReponse.body);
        if (dataReponse.statusCode == 204) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sửa thành công!')));
         Navigator.pop(context, true);
        
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Vui lòng thử lại sau 1 vài phút')),
          );
        }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Sửa thông tin người dùng',
            style: TextStyle(
              fontFamily: 'SourceSans',
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: IndentField(
                child: Form(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                        child: Text("Chỉnh sửa thông tin cá nhân người dùng"),
                      ),
                      if (_image != null)
                        Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 20),
                            child: ClipOval(
                              child: SizedBox(
                                width: 150.0,
                                height: 150.0,
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                      ElevatedButton.icon(
                        onPressed: getImage,
                        icon: const Icon(Icons.image),
                        label: const Text('Thêm ảnh đại diện'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                        child: TextFormField(
                          controller: _ageController,
                          decoration: const InputDecoration(
                            labelText: 'Tuổi',
                            border: UnderlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                        child: DropdownButtonFormField<int>(
                          value: _gender,
                          onChanged: (int? newValue) {
                            setState(() {
                              _gender =
                                  newValue; // Cập nhật giá trị khi người dùng chọn
                            });
                          },
                          items: const [
                            DropdownMenuItem<int>(
                              value: 0,
                              child: Text('Nam'),
                            ),
                            DropdownMenuItem<int>(
                              value: 1,
                              child: Text('Nữ'),
                            ),
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Giới tính',
                            border: UnderlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                        child: TextFormField(
                          controller: _addressController,
                          decoration: const InputDecoration(
                            labelText: 'Địa chỉ',
                            border: UnderlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _updateProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 70, 161, 236),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 15),
                        ),
                        child: const Text(
                          'Cập nhật thông tin',
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
              )),
        ),
      ),
    );
  }
}
