import 'package:flutter/material.dart';
import 'package:flutterapplication/services/constants.dart';

import '../services/FirestoreHelper.dart';
import 'DashBoard.dart';

class Inscription extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InscriptionState();
  }
}

class InscriptionState extends State<Inscription> {
  late String mail;
  late String pseudo;
  late String password;
  DateTime time = DateTime.now();
  late DateTime birthday;

  //Methode interne à la page
  openCalendar() async {
    DateTime? dateSeleted = await showDatePicker(
        context: context,
        initialDate: time,
        firstDate: DateTime(1940),
        lastDate: time
    );
    if(dateSeleted != null && dateSeleted != time){
      setState(() {
        time = dateSeleted;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text("Inscription page"),
        ),
        body: Padding(
          child: bodyPage(),
          padding: EdgeInsets.all(15),
        )

    );

  }
    Widget bodyPage() {

      return Column(
        children: [

          //Pseudo
          const SizedBox(height: 10),
          TextField(
              onChanged: (value) {
                setState(() {
                  pseudo = value;
                });
              },
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Entrer votre pseudo",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  )
              )
          ),

          //date de naissance
          const SizedBox(height: 10),
          TextField(
              onChanged: (value) {
                setState(() {
                  birthday = value as DateTime;
                });
              },
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Entrer votre pseudo",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  )
              )
          ),

          //mail
          const SizedBox(height: 10),
          TextField(
              onChanged: (value) {
                setState(() {
                  pseudo = value;
                });
              },
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Entrer votre pseudo",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  )
              )
          ),

          //mot de passe
          const SizedBox(height: 10),
          TextField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              obscureText: true,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Entrer votre mot de passe",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  )
              )
          ),

          const SizedBox(height: 10),

          ElevatedButton.icon(
            icon: Icon(Icons.watch_later_rounded),
              onPressed: (){
                openCalendar();
              },
              label: Text("${time.day}/${time.month}/${time.year}"),
          ),
          const SizedBox(height: 10,),
          TextButton(
              onPressed: (){
                FirestoreHelper().inscription(mail, password, pseudo, birthday).then((value) {
                  MyAccount = value;
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return DashBoard(mail: mail,password: password,);
                      }
                  ));
                }).catchError((onError){
                  print("Erreur de saisie");
                });
    },
              child: const Text("Enregistrer")
          ),
          TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text("Retour")
          )

        ],
      );

  }
}
