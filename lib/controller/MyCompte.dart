import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutterapplication/services/FirestoreHelper.dart';
import 'package:flutterapplication/services/constants.dart';

class MonCompte extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MonCompteState();
  }

}

class MonCompteState extends State<MonCompte>{
  //Variable pour créer l'image
  Uint8List? dataImage;
  String? nameImage;
  String? cheminImage;
  
  //Fonction internes
  selectionImage() async {
    FilePickerResult? resultat = await FilePicker.platform.pickFiles(
      withData: true
    );
    if(resultat !=null){
      dataImage = resultat.files.first.bytes;
      nameImage = resultat.files.first.name;
      showImage();
    }
  }
  
  showImage(){
    showDialog(
        context: context, 
        builder: (context){
          return AlertDialog(
            title: const Text("Choix de l'image"),
            content: Image.memory(dataImage!),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text("Annuler")
              ),
              TextButton(
                  onPressed: (){
                    FirestoreHelper().stockageImage(nameImage!, dataImage!).then((value){
                      setState((){
                        cheminImage = value;
                        MyAccount.avatar = value;
                      });
                      Map<String,dynamic> map = {
                        "AVATAR" : cheminImage
                      };
                      FirestoreHelper().UpdateUser(MyAccount.id, map);
                      Navigator.pop(context);
                    });
                  },
                  child: const Text("Enregistrer")
              ),
            ],

          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: bodyPage(),
      ),
    );
  }

  Widget bodyPage(){
    return Column(
      children: [
        //avatar cliquable
        InkWell(
          child: CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(MyAccount.avatar!),
          ),
          onTap: (){
            print("j'ai cliqué l'image");
            selectionImage();
        },
    ),


        //Pseudo
        Text(
          MyAccount.pseudo,
          style: const TextStyle(
            fontSize: 35,
            color: Colors.purple,
            fontWeight: FontWeight.bold,
          ),
        ),
        //adresse mail
        Text(MyAccount.mail),
        //nom prenom
        Text(MyAccount.fullName)
      ],
    );
  }

}