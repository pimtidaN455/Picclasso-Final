//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/Backend/Check_User.dart';
//import 'package:project_photo_learn/main.dart';
import 'package:project_photo_learn/page/Start/start_login.dart';

class Start_Register extends StatefulWidget {
  const Start_Register({Key? key}) : super(key: key);
  @override
  _StartRegisterState createState() => _StartRegisterState();
}

class _StartRegisterState extends State<Start_Register> {
  late double screen;

  TextEditingController EmailRe = TextEditingController();
  TextEditingController PasswordRe = TextEditingController();
  TextEditingController ConPasswordRe = TextEditingController();
  TextEditingController FirstNameRe = TextEditingController();
  TextEditingController LastNameRe = TextEditingController();
  //สร้างตัวแปร fromKey
  final _fromKey = GlobalKey<FormState>();

  bool _isObscure = true;

  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Startlogin()));
            },
          ),
          backgroundColor: MyStyle().blackColor,
        ),
        body: SingleChildScrollView(
            child: Container(
                alignment: Alignment.topCenter,
                child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                    child: Form(
                      key: _fromKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 40,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                              //fontStyle: FontStyle.normal,
                              fontFamily: 'Rajdhani',
                            ),
                          ),
                          FirstName(),
                          LastName(),
                          Emailre(),
                          Text(
                            "\n Please enter a password 6-25 characters.",
                            style: TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                              //fontStyle: FontStyle.normal,
                              fontFamily: 'Rajdhani',
                            ),
                          ),
                          PassWordre(),
                          conFP(),
                          NextToHome(),
                        ],
                      ),
                    )))));
    /*return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Startlogin()));
          },
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: SingleChildScrollView(
          child: Container(
              alignment: Alignment.topCenter,
              child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                  child: Form(
                    key: _fromKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 40,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            //fontStyle: FontStyle.normal,
                            fontFamily: 'Rajdhani',
                          ),
                        ),
                        FirstName(),
                        LastName(),
                        Emailre(),
                        Text(
                          "\n Please enter a password 6-25 characters.",
                          style: TextStyle(
                            fontSize: 17,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            //fontStyle: FontStyle.normal,
                            fontFamily: 'Rajdhani',
                          ),
                        ),
                        PassWordre(),
                        conFP(),
                        NextToHome(),
                      ],
                    ),
                  )))),
    );*/
  }

  Container NextToHome() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.75,
      child: ElevatedButton(
        child: Text('Next'),
        onPressed: () async {
          print('--------------- Email and Password ---------------');
          bool validate = _fromKey.currentState!.validate();
          if (validate) {
            check_user user_check = await new check_user();
            var signup = await user_check.signup(EmailRe.text, PasswordRe.text,
                FirstNameRe.text, LastNameRe.text);

            if (await signup['message'] == "Signup Finishes") {
              await showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title:
                      Text('กรุณายืนยัน E-mail เพื่อการสมัครสมาชิกที่สมบูรณ์'),
                ),
              );
              ///////pop up บอกกรุณายืนยัน Email///
              MaterialPageRoute materialPageRoute = MaterialPageRoute(
                  builder: (BuildContext context) => Startlogin());
              Navigator.of(this.context).push(materialPageRoute);
            } else {
              print(signup['message']);
              MaterialPageRoute materialPageRoute = MaterialPageRoute(
                  builder: (BuildContext context) => Start_Register());
              Navigator.of(this.context).push(materialPageRoute);
            }

            print(FirstNameRe.text);
            print(LastNameRe.text);
            print(EmailRe.text);
            print(PasswordRe.text);
            print(ConPasswordRe.text);
          }
        },
        style: ElevatedButton.styleFrom(
            primary: MyStyle().blackColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }

  Container FirstName() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.8,
      child: TextFormField(
        controller: FirstNameRe,
        //maxLength: 30, //รับไม่เกิน 30 ตัว
        decoration: InputDecoration(
            labelText: 'FirstName',
            prefixIcon: Icon(Icons.perm_identity),
            suffixIcon: IconButton(
              onPressed: () {
                FirstNameRe.clear();
              },
              icon: const Icon(Icons.clear),
            ),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter FirstName.";
          } else if (value.length < 3) {
            return "FirstName should be more than 3 characters.";
          } else if (value.length > 30) {
            return "FirstName should not be greater than 30 charecters.";
          } else
            return null;
        },
      ),
    );
  }

  Container LastName() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.8,
      child: TextFormField(
        controller: LastNameRe,
        //maxLength: 30,
        decoration: InputDecoration(
            labelText: 'LastName',
            prefixIcon: Icon(Icons.perm_identity),
            suffixIcon: IconButton(
              onPressed: () {
                LastNameRe.clear();
              },
              icon: const Icon(Icons.clear),
            ),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter LastName.";
          } else if (value.length < 3) {
            return "LastName should be more than 3 characters.";
          } else if (value.length > 30) {
            return "LastName should not be greater than 30 charecters.";
          } else
            return null;
        },
      ),
    );
  }

  Container Emailre() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.8,
      child: TextFormField(
        controller: EmailRe,
        decoration: InputDecoration(
            labelText: 'E-mail',
            prefixIcon: Icon(Icons.email_outlined),
            suffixIcon: IconButton(
              onPressed: () {
                EmailRe.clear();
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
            return "Please enter Email";
          }
          if (emailRegex.hasMatch(value)) {
            return null;
          } else
            return "Please enter a valid email.";
        },
      ),
    );
  }

  Container PassWordre() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.8,
      child: TextFormField(
        controller: PasswordRe,
        //maxLength: 25,
        obscureText: _isObscure,
        decoration: InputDecoration(
            hintText: ("Password"),
            labelText: ('Password'),
            //labelText: ('should be more than 6 charecters.'),
            prefixIcon: Icon(Icons.password),
            suffixIcon: IconButton(
                icon:
                    Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                }),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        validator: (value) {
          final passwordRegex = RegExp('[^A-Za-z0-9_]');
          if (value!.isEmpty) {
            return "Please enter Password";
          }
          if (passwordRegex.hasMatch(value)) {
            return "Please enter a valid password.";
          }
          if (value.length < 6) {
            return "Password should be more than 6 characters.";
          }
          if (value.length > 25) {
            return "Password should not be greater than 25 charecters.";
          } else
            return null;
        },
      ),
    );
  }

  Container conFP() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.8,
      child: TextFormField(
        controller: ConPasswordRe,
        //maxLength: 25,
        obscureText: _isObscure,
        decoration: InputDecoration(
            //hintText: ("Confirm Password"),
            labelText: ("Confirm Password"),
            //labelText: ('Password should be more than 6 charecters.'),
            prefixIcon: Icon(Icons.password),
            suffixIcon: IconButton(
                icon:
                    Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                }),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        validator: (value) {
          final confirmPass = RegExp(PasswordRe.text);
          if (value!.isEmpty) {
            return "Please enter Password.";
          }
          if (value.length < 6) {
            return "Password should be more than 6 characters.";
          }
          if (value.length > 25) {
            return "Password should not be greater than 25 charecters.";
          }
          if (confirmPass.hasMatch(value)) {
            return null;
          } else
            return "Password does not match";
        },
      ),
    );
  }
}
