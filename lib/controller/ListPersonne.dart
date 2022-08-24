import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapplication/model/Utilisateur.dart';
import 'package:flutterapplication/services/FirestoreHelper.dart';

class ListPersonne extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}

class ListPersonneState extends State<ListPersonne>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return bodyPage();
  }

  Widget bodyPage() {
    //Récupérer la liste des utilisateurs
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreHelper().fireUsers.snapshots(),
        builder: (context, snapchot){
        if(!snapchot.hasData){
          //La base de donnée n'a aucun snapchot
          return Center(
            //Widget en forme de cercle qui tourne sur lui même
            child: CircularProgressIndicator(),
          );
        }


        else{
          //La base de donnée a un ou plusieurs snapchot
          List documents = snapchot.data!.docs;
          print(documents.length);
          return ListView.builder(
            itemCount: documents.length,
              itemBuilder: (context, index){
                return Text("Image");
              }
          );
        }
      }
    );

  }

}