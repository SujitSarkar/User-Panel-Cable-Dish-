import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_panel/shared/FormDecoration.dart';
import 'package:user_panel/shared/LoadingPage.dart';

class SubmitProblem extends StatefulWidget {
  @override
  _SubmitProblemState createState() => _SubmitProblemState();
}

class _SubmitProblemState extends State<SubmitProblem> {
  bool isLoading =false;
  final _formKey = GlobalKey<FormState>();
  String name,address,mobile,problem;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreferencesData();
  }

  Future getPreferencesData() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    name = await preferences.get('name');
    address = await preferences.get('address');
    mobile = await preferences.get('mobile');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("দ্বীপ ক্যবল ভিশন"),
        centerTitle: true,
      ),
      body: problemForm(),

    );
  }

  Widget problemForm(){
    return isLoading
        ? Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            greenLoadingBar(),
            Text(
              "আপনার মমস্যা সংরক্ষন করা হচ্ছে, অপেক্ষা করুন",
              style: TextStyle(color: Colors.grey[700]),
            ),
          ],
        ),
      ),
      color: Colors.transparent,
    )
        : Form(
      key: _formKey,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "গ্রাহকের সমস্যা প্রদান ফরম",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.green[700], fontSize: 25.0),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),

                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.multiline,
                    maxLines: 7,
                    decoration: textInputDecoration.copyWith(hintText: "আপনানার সমস্যা লিখুন"),
                    validator: (value) =>
                    value.isEmpty ? "আপনানার সমস্যা লিখুন" : null,
                    onChanged: (value) {
                      setState(() => problem = value);
                    },
                  ),
                  SizedBox(
                    height: 40.0,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlineButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            setState(() => isLoading = true);
                            submitProblemToDatabase();
                          }
                        },
                        highlightedBorderColor: Colors.green,
                        focusColor: Colors.green,
                        splashColor: Colors.green[200],
                        borderSide:
                        BorderSide(color: Colors.green, width: 2.0),
                        child: Text(
                          "সংরক্ষণ করুন",
                          style: TextStyle(
                            color: Colors.green[700],
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30.0,
                      ),
                      OutlineButton(
                        onPressed: () => Navigator.of(context).pop(),
                        highlightedBorderColor: Colors.red,
                        focusColor: Colors.red,
                        splashColor: Colors.red[200],
                        borderSide:
                        BorderSide(color: Colors.red, width: 2.0),
                        child: Text(
                          "বাতিল করুন",
                          style: TextStyle(
                            color: Colors.red[700],
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future submitProblemToDatabase() async{
    String submittedDate = DateTime.now().millisecondsSinceEpoch.toString();

    Firestore.instance.collection("ComplainList").document(mobile).setData({
      "name": name,
      "mobile": mobile,
      "address": address,
      "problem": problem,
      "submitted date": submittedDate,
    }).then((value) async {
      this.setState(() => isLoading = false);
      Fluttertoast.showToast(msg: "আপনার সমস্যা কর্তৃপক্ষের কাছে জানানো হয়েছে");
      //Navigator.of(context).pop();
    }, onError: (errorMgs) {
      setState(() => isLoading = false);
      Fluttertoast.showToast(msg: errorMgs.toString());
    });
  }
}
