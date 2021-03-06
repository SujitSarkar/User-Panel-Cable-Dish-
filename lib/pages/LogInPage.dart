import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:marquee_flutter/marquee_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_panel/shared/DatabseHelper.dart';
import 'package:user_panel/shared/FormDecoration.dart';
import 'package:user_panel/shared/LoadingPage.dart';

import 'HomePage.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String mobile = "", password = "";
  List userList = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text("দ্বীপ ক্যাবল ভিশন এ স্বাগতম"),
        centerTitle: true,
      ),
      body: isLoading ? greenLoadingBar() : LogInBody(),
    );
  }

  Widget LogInBody() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 20,
            child: new MarqueeWidget(
              text:
                  "--- দ্বীপ ক্যবল ভিশন --- দ্বীপ ক্যবল ভিশন --- দ্বীপ ক্যবল ভিশন --- দ্বীপ ক্যবল ভিশন --- দ্বীপ ক্যবল ভিশন --- দ্বীপ ক্যবল ভিশন --- দ্বীপ ক্যবল ভিশন ---",
              textStyle: TextStyle(color: Colors.green[900], fontSize: 18),
              scrollAxis: Axis.horizontal,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      TextFormField(
                        //textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.number,
                        decoration: textInputDecoration.copyWith(hintText: "মোবাইল নাম্বার"),
                        controller: mobileController,
                        validator: (value) {
                          fetchUser();
                          if (value.isEmpty) {
                            return "মোবাইল নাম্বার দিন";
                          } else if (userList[0]["mobile"] != mobile) {
                            return "ভুল নাম্বার";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            mobile = value;
                            fetchUser();
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        //textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.text,
                        decoration:
                            textInputDecoration.copyWith(hintText: "পাসওয়ার্ড"),
                        controller: passwordController,
                        validator: (value) {
                          fetchUser();
                          if (value.isEmpty) {
                            return "পাসওয়ার্ড দিন";
                          } else if (userList[0]['password'] != password) {
                            return "ভুল পাসওয়ার্ড";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            password = value;
                            //fetchUser();
                          });
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      OutlineButton(
                        onPressed: () {
                          fetchUser();
                          if (_formKey.currentState.validate()) {
                            if (userList[0]["mobile"]==mobile && userList[0]['password'] == password) {
                              setState(() {
                                isLoading = true;
                              });
                              goToNextPage();
                            }
                          }
                        },
                        highlightedBorderColor: Colors.green,
                        focusColor: Colors.green,
                        splashColor: Colors.green[200],
                        borderSide: BorderSide(color: Colors.green, width: 2.0),
                        child: Text(
                          "সাইন ইন",
                          style: TextStyle(
                            color: Colors.green[700],
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future fetchUser() async {
    dynamic result = await DatabaseHelper().getSearchedCustomer(mobile);
    setState(() {
      userList = result;
    });
    print(userList.length);
    print(mobile);
  }


  Future goToNextPage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("mobile", mobile);
    await preferences.setString("name", userList[0]["name"]);
    await preferences.setString("address", userList[0]["address"]);
    setState(() => isLoading = false);
    Fluttertoast.showToast(msg: "সাইন ইন সফল হয়েছে");
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()), (route) => false);
  }
}
