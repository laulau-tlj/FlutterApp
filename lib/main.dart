import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterapplication/services/FirestoreHelper.dart';
import 'package:flutterapplication/services/Permission.dart';
import 'package:flutterapplication/services/constants.dart';
import 'package:flutterapplication/view/DashBoard.dart';
import 'package:flutterapplication/view/Inscription.dart';
import '';
import 'firebase_options.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PermissionHandler().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Variable
  late String mail;
  late String password;


  //Fonction interne à la page

  popUp(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            content: Text("Adresse mail ou mot de passe invalide"),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Ok"))
            ]
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: bodyPage(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget bodyPage() {
    return
      Column(
          children: [
            const SizedBox(height: 10),
            TextField(
                onChanged: (value) {
                  setState(() {
                    mail = value;
                  });
                },
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Entrer votre adresse mail",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    )
                )
            ),
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
            ElevatedButton(
                onPressed: () {
                  FirestoreHelper().connected(mail, password).then((value) {
                    MyAccount = value;
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                          return DashBoard(mail: mail,password: password,);
                        }
                    ));
                  }).catchError((onError){
                    popUp();
                    //Afficher popUp
                    print(onError);
                  });
                },
                child: const Text("Connexion"),
            ),
            TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return Inscription();
                      }
                      ));
                },
                child: const Text("Inscription"),
            )
          ]
      );
  }
}

