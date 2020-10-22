import 'package:flutter/material.dart';
import 'package:marquee_flutter/marquee_flutter.dart';
import 'package:user_panel/pages/ProblemList.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("দ্বীপ ক্যবল ভিশন"),
        centerTitle: true,
      ),
      body: homeBody(),
    );
  }

  Widget homeBody() {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height*.1,
          child:Center(
            child: new MarqueeWidget(
              text:
              "২৪ ঘন্টা সার্ভিস পেতে ০১৮২৩৪৮১২৩ নাম্বারে কল করুন । দ্বীপ ক্যাবল ভিশন এর সাথে থাকার জন্য ধন্যবাদ ।",
              textStyle: TextStyle(color: Colors.green[900], fontSize: 18),
              scrollAxis: Axis.horizontal,
            ),
          )
        ),
        Container(
          height: (MediaQuery.of(context).size.height*.70),
          child: GridView(
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: [
              GestureDetector(
                onTap: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewCustomer()));
                },
                child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.person_outline, size: 50.0, color: Colors.green),
                      Text(
                        "প্রোফাইল",
                        style: TextStyle(fontSize: 18.0, color: Colors.green),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>AllCustomerList()));
                },
                child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.payment_outlined, size: 50.0, color: Colors.green),
                      Text(
                        "বিলের তথ্য",
                        style: TextStyle(fontSize: 18.0, color: Colors.green),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>ArrearsCustomerList()));
                },
                child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.monetization_on_outlined, size: 50.0, color: Colors.green),
                      Text(
                        "বিল পরিশোধ করুন",
                        style: TextStyle(fontSize: 18.0, color: Colors.green),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Problem()));
                },
                child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.report_problem_outlined,
                          size: 50.0, color: Colors.green),
                      Text(
                        "আপনার সমস্যা জানান",
                        style: TextStyle(fontSize: 18.0, color: Colors.green),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>ArrearsCustomerList()));
                },
                child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.work_outline, size: 50.0, color: Colors.green),
                      Text(
                        "আমাদের সার্ভিস সমূহ",
                        style: TextStyle(fontSize: 18.0, color: Colors.green),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>PaidCustomerList()));
                },
                child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.sms_outlined,
                          size: 50.0, color: Colors.green),
                      Text(
                        "যোগাযোগ করুন",
                        style: TextStyle(fontSize: 18.0, color: Colors.green),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
