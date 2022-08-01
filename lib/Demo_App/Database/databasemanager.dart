import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future <void> addBloodGroup(String patientname,String medicalCenter
    ,String requestdate,String blood,String number) async{
  CollectionReference users=FirebaseFirestore.instance.collection("Demo_cart");
  FirebaseAuth auth= FirebaseAuth.instance;
  String? uid =auth.currentUser?.uid.toString();
  users.add({"Patient_Name":patientname,"Medical_Center": medicalCenter,"Request_Rate"
      :requestdate,"Blood_Group":blood,"Phone_Number":number });
  return;
}