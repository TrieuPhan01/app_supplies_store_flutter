import 'package:flutter/material.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return (GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xfff1f4f8),
        appBar: AppBar(
          backgroundColor: const Color(0xfff1f4f8),
          automaticallyImplyLeading: false,
          title: const Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
              child: Text(
                'Thông tin cá nhân',
                style: TextStyle(
                  fontFamily: 'SourceSans',
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              )),
        ),
        body: Align(
          alignment: AlignmentDirectional(0, 0),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    ));
  }
}
