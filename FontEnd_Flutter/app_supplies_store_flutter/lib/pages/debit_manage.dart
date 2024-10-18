import 'dart:convert';
import 'package:app_supplies_store_flutter/providers/debit_provider.dart';
import 'package:app_supplies_store_flutter/providers/user_povider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DebitListPage extends StatefulWidget {
  const DebitListPage({Key? key}) : super(key: key);

  @override
  State<DebitListPage> createState() => _DebitListPageState();
}

class _DebitListPageState extends State<DebitListPage> {
  List<DebitProvider> _debits = [];
  List<DebitProvider> _filteredDebits = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchDebits();
  }

  Future<void> _fetchDebits() async {
    final String apiUrl = dotenv.env['API_URL'] ?? 'No API URL Found';
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    try {
      final debitResponse = await http.get(
        Uri.parse('$apiUrl/api/Debits'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user?.token}',
        },
      );
      if (debitResponse.statusCode == 200) {
        List<dynamic> jsonList = json.decode(debitResponse.body);
        setState(() {
          _debits = jsonList
              .map((json) => DebitProvider(
                    id: json['id'],
                    name: json['name'],
                    note: json['note'],
                    totalMoney: json['totalMoney'],
                    paymentStatus: json['paymentStatus'],
                    debPurchaseDate: json['debPurchaseDate'],
                    customerID: json['customerID'],
                    employeeID: json['employeeID'],
                    storeID: json['storeID'],
                  ))
              .toList();
          _filteredDebits = _debits;
        });
      } else {
        throw Exception('Không thể lấy dữ liệu ghi nợ');
      }
    } catch (e) {
      print(e);
      // Handle error (e.g., show a snackbar)
    }
  }

  void _filterDebits(String query) {
    setState(() {
      _filteredDebits = _debits
          .where((debit) =>
              debit.name?.toLowerCase().contains(query.toLowerCase()) ??
              false || debit.note!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        autofocus: true,
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Tìm kiếm ghi nợ...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: _filterDebits,
      ),
    );
  }

  Widget _buildDebitList() {
    return ListView.builder(
      itemCount: _filteredDebits.length,
      itemBuilder: (context, index) {
        final debit = _filteredDebits[index];
        return Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 16, 8),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 3,
                  color: Colors.white,
                  offset: Offset(0.0, 1),
                ),
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 4, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            debit.name ?? 'Không có tên',
                            style: const TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 4, 8, 0),
                            child: Text(
                              debit.note ?? 'Không có ghi chú',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Tổng tiền: ${NumberFormat('#,###').format(debit.totalMoney ?? 0)} VNĐ',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Ngày mua: ${_formatDate(debit.debPurchaseDate)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
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
                      Chip(
                        label: Text(
                          debit.paymentStatus == true
                              ? 'Đã thanh toán'
                              : 'Chưa thanh toán',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                        backgroundColor: debit.paymentStatus == true
                            ? Colors.green
                            : Colors.red,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.chevron_right_rounded,
                          color: Color(0xFF57636C),
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'Không có ngày';
    final date = DateTime.tryParse(dateString);
    if (date == null) return 'Ngày không hợp lệ';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xfff1f4f8),
        appBar: AppBar(
          toolbarHeight: 75,
          backgroundColor: const Color(0xfff1f4f8),
          title: const Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Text(
              'Ghi nợ',
              style: TextStyle(
                fontFamily: 'SourceSans',
                fontSize: 35,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 14, top: 30),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/createDebit');
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text('Thêm ghi nợ',
                    style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            _buildSearchBar(),
            Expanded(child: _buildDebitList()),
          ],
        ),
      ),
    );
  }
}
