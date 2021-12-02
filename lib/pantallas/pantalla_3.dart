import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gestiontiendas/pantallas/pantalla_4.dart';
import 'main.dart';

class pantalla_3 extends StatefulWidget {
  const pantalla_3({Key? key}) : super(key: key);


  @override
  State<pantalla_3> createState() => _pantalla_3State();
}

class _pantalla_3State extends State<pantalla_3> {
  TextEditingController dato = TextEditingController();
  List datos_negocios=[];

  void initState(){
    super.initState();
    getNegocios();
    menu();
  }

  void getNegocios() async {
    CollectionReference datos= FirebaseFirestore.instance.collection("Tiendas") ;
    QuerySnapshot negocios= await datos.get();

    if(negocios.docs.length>0){
      print("tiene datos");
      for(var doc in negocios.docs){
        print(doc.data());
        datos_negocios.add(doc.data());
      }
    }else{
      print("Ha fallado.....");
    }
  }

//class pantalla_3 extends StatelessWidget {
  //TextEditingController dato = TextEditingController();
  //pantalla_3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Drawer: menu();
    return Scaffold(
        appBar: AppBar(
          title: Text("Consultar Negocios"),
        ),
        body: Column(
          children: [
            Container(
              child:
              TextField(controller: dato,),
            ),
            Container(
              child: ElevatedButton(onPressed: () {
                print(dato.text);
                Navigator.push(context, MaterialPageRoute(builder: (context) => pantalla_4(dato.text)));
              }, child: Text("Consultar"),),
            ),
          ],
        )
    );
  }
}