import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {


  final CollectionReference complainList =
  Firestore.instance.collection("ComplainList");

  final CollectionReference customerList =
  Firestore.instance.collection("Customer");

  Future getSearchedCustomer(String searchQuery) async {
    List searchList = [];
    try {
      await customerList
          .where("mobile", isEqualTo: searchQuery)
          .getDocuments()
          .then((querySnapshot) {
        querySnapshot.documents.forEach((element) {
          searchList.add(element.data);
        });
      });
      return searchList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future geProblemList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String mobile = preferences.getString("mobile");

    List problems = [];
    try {
      await complainList
          .where("mobile", isEqualTo: mobile)
          .getDocuments()
          .then((querySnapshot) {
        querySnapshot.documents.forEach((element) {
          problems.add(element.data);
        });
      });
      return problems;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}
