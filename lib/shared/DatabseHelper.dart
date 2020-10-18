import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHelper {
  final CollectionReference customerList =
      Firestore.instance.collection("UserInfo");

  Future geUser(String mobile) async {
    List user = [];
    try {
      await customerList
          .where("mobile", isEqualTo: mobile)
          .getDocuments()
          .then((querySnapshot) {
        querySnapshot.documents.forEach((element) {
          user.add(element.data);
        });
      });
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future gePassword(String password) async {
    List pass = [];
    try {
      await customerList
          .where("password", isEqualTo: password)
          .getDocuments()
          .then((querySnapshot) {
        querySnapshot.documents.forEach((element) {
          pass.add(element.data);
        });
      });
      return pass;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
