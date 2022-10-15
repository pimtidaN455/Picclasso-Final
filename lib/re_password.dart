// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/Backend/Use_Api.dart';
import 'package:project_photo_learn/page/PagesF/PagePerson/setting_page.dart';

import 'package:project_photo_learn/page/Start/start_login.dart';

class Resetpassword extends StatefulWidget {
  //const Resetpassword({Key? key}) : super(key: key);
  String pagere;
  var user;
  Resetpassword({required this.pagere, required this.user});
  @override
  _ResetpasswordState createState() =>
      _ResetpasswordState(pagereset: pagere, user: user);
}

class _ResetpasswordState extends State<Resetpassword> {
  String pagereset;
  var user;
  _ResetpasswordState({required this.pagereset, required this.user});

  late double screen;
  TextEditingController Emailrepass = TextEditingController();
  //bool _isObscure = true;
  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              dynamic Request_page = setting_page(user: user);

              if (pagereset == "login") {
                Request_page = Startlogin();
              }
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Request_page));
            },
          ),
          backgroundColor: MyStyle().blackColor,
        ),
        body: Container(
            alignment: Alignment.topCenter,
            child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                child: Form(
                    key: _fromKey,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            'Reset password',
                            style: TextStyle(
                              fontSize: 50,
                              color: MyStyle().blackColor,
                              fontWeight: FontWeight.bold,
                              //fontStyle: FontStyle.normal,
                              fontFamily: 'Rajdhani',
                            ),
                          ),
                          Emailre(),
                          NextToRePassWord(),
                        ],
                      ),
                    )))));
  }

  Container Emailre() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.8,
      child: TextFormField(
        controller: Emailrepass,
        decoration: InputDecoration(
            labelText: 'E-mail',
            prefixIcon: Icon(Icons.email_outlined),
            suffixIcon: IconButton(
              onPressed: () {
                Emailrepass.clear();
              },
              icon: const Icon(Icons.clear),
            ),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        validator: (value) {
          final emailRegex = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
          if (value!.isEmpty) {
            return "Please enter Email for repassword";
          }
          if (emailRegex.hasMatch(value)) {
            return null;
          } else
            return "Please enter a valid email.";
        },
      ),
    );
  }

  Container NextToRePassWord() {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.75,
      child: ElevatedButton(
        /* onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(
                'Application ได้ทำการส่ง Email เพื่อให้ผู้ใข้ทำการเปลี่ยนรหัสผ่านดรียบร้อย'),
          ),
        ),*/
        onPressed: () async {
          bool validate = _fromKey.currentState!.validate();
          dynamic Request_page = setting_page(user: user);
          if (pagereset == "login") {
            Request_page = Startlogin();
          }
          if (validate) {
            use_API APi_use = new use_API();
            var APIre = await APi_use.Reset_password(Emailrepass.text);
            print("-----------EMail--------------");
            print(Emailrepass.text);
            print(APIre);
            print("-----------EMail--------------");
            if (await APIre['message'] == "Success") {
              //if (true) {
              await showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text(
                      'Send an E-mail for the user to change the password successfully.'),
                ),
              );
              MaterialPageRoute materialPageRoute = MaterialPageRoute(
                  builder: (BuildContext context) => Request_page);
              Navigator.of(this.context).push(materialPageRoute);
            } else {
              await showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text('Invalid Email'),
                ),
              );

              MaterialPageRoute materialPageRoute = MaterialPageRoute(
                  builder: (BuildContext context) => Request_page);
              Navigator.of(this.context).push(materialPageRoute);
              /*showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text(' ไม่พบ Email ที่คุณป้อน กรุณาใส่ใหม่'),
                ),
              );*/
            }

            print(Emailrepass.text);
          }
        },
        child: Text(
          'Confirm',
          style: TextStyle(
            fontSize: 20,
            color: MyStyle().whiteColor,
            fontWeight: FontWeight.bold,
            //fontStyle: FontStyle.normal,
            fontFamily: 'Rajdhani',
          ),
        ),
        style: ElevatedButton.styleFrom(
            primary: MyStyle().blackColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
