import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_panel/pages/SubmitProblemPage.dart';
import 'package:user_panel/shared/DatabseHelper.dart';
import 'package:user_panel/shared/FormDecoration.dart';
import 'package:user_panel/shared/LoadingPage.dart';

class Problem extends StatefulWidget {
  @override
  _ProblemState createState() => _ProblemState();
}

class _ProblemState extends State<Problem> {
  bool isLoading = true;
  List prblmList = [];
  String mobile,newProblem;
  TextEditingController problemEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProblemList();
    getPreferencesData();
  }

  Future getPreferencesData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    mobile = await preferences.get('mobile');
  }

  fetchProblemList() async {
    dynamic result = await DatabaseHelper().geProblemList();

    if (result == null) {
      setState(() => isLoading = false);
    } else {
      setState(() {
        prblmList = result;
        setState(() => isLoading = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("দ্বীপ ক্যবল ভিশন"),
        centerTitle: true,
      ),
      body: isLoading
          ? greenLoadingBar()
          : prblmList.length == 0
              ? noDataFoundMgs(context)
              : mainList(context),
      floatingActionButton: FloatingActionButton(
          tooltip: "আপনার সমস্যা জানান",
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SubmitProblem()));
          },
          backgroundColor: Colors.green,
          child: Icon(Icons.add)),
    );
  }

  noDataFoundMgs(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.report_problem_outlined,
            color: Colors.grey,
            size: 70.0,
          ),
          Text(
            "আপনার কোন সমস্যার তালিকা নেই",
            style: TextStyle(color: Colors.grey, fontSize: 20.0),
          ),
        ],
      ),
    );
  }

  mainList(BuildContext context) {
    fetchProblemList();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListView.builder(
        itemCount: prblmList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                problemEditingController = TextEditingController(text: prblmList[index]["problem"]);
                showAndUpdateModal(context);
              },
              title: Text(prblmList[index]["problem"]),
              subtitle: Text(prblmList[index]["submitted date"]),
              leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.report_problem_outlined,
                    size: 40,
                    color: Colors.yellow[800],
                  )),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    deleteConfirmation(context);
                  });
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void deleteConfirmation(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 115,
            margin: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 30.0),
            decoration: modalDecoration,
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "আপনার সমস্যাটি মুছে ফেলতে চান?",
                        style:
                            TextStyle(fontSize: 18.0, color: Colors.grey[800]),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 30.0,
                        ),
                        onPressed: () {
                          Firestore.instance
                              .collection("ComplainList")
                              .document(mobile)
                              .delete();
                          Fluttertoast.showToast(
                              msg: "আপনার সমস্যাটি মুছে ফেলা হয়েছে");
                          setState(() {
                            fetchProblemList();
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 30.0,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  void showAndUpdateModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 30.0),
            decoration: modalDecoration,
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Stack(
              children:[ SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "আপনার সমস্যার বিবরণ",
                            style:
                            TextStyle(fontSize: 18.0, color: Colors.grey[800]),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.multiline,
                      controller: problemEditingController,
                      maxLines: 7,
                      decoration: textInputDecoration.copyWith(
                          hintText: "গ্রাহকের সমস্যার বিবরণ"),
                      onChanged: (value) {
                        setState(() => newProblem = value);
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlineButton(
                          onPressed: () {
                              Firestore.instance.collection("ComplainList")
                                  .document(mobile)
                                  .updateData({"problem": newProblem})
                                  .then((value) {
                                Fluttertoast.showToast(msg: "সমস্যা আপডেট করা হয়েছে");
                              }, onError: (errorMgs){
                                Fluttertoast.showToast(msg: errorMgs.toString());
                              });
                              Navigator.pop(context);


                          },
                          highlightedBorderColor: Colors.green,
                          focusColor: Colors.green,
                          splashColor: Colors.green[200],
                          borderSide:
                          BorderSide(color: Colors.green, width: 2.0),
                          child: Text(
                            "আপডেট করুন",
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
          ]
            ),
          );
        });
  }
}
