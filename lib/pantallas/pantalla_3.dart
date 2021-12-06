import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        drawer: menu(),
        appBar: AppBar(
          title: Image.network("https://img.freepik.com/vector-gratis/personas-pie-cola-tienda_23-2148594615.jpg?size=626&ext=jpg", height: 90, width: 60),
          actions: const <Widget>[
            InkWell(
            child: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: 16.0),
            child:Icon(Icons.search),
            ),
            ),
          ],
            ),
        body: Column(
          children: [
              SingleChildScrollView(
              child: SafeArea(
              child: Container(
                width: size.width,
                height: size.height,
              child: Column(
              children: <Widget>[
              Container(
              width: 90,
              height: 90,
              margin: EdgeInsets.only(top: size.width * 0.3),
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
              BoxShadow(
              color: Colors.black26, blurRadius: 25
              )
              ]

              ),
              ),
              SizedBox(height: 1),
              Text(
              "Consultar", textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black),
              ),
                Column(
                children: [
                ConstrainedBox(constraints: BoxConstraints(
                maxWidth: 300,
                minWidth: 300,
                ),
                child: Column(
                children: <Widget>[
                  TextField(
                    controller: dato,
                    decoration: InputDecoration(
                    hintText: "Producto",
                    )
                    ),
                    SizedBox(height: 20),
                    ConstrainedBox(constraints: BoxConstraints(
                    maxWidth: 300,
                    minWidth: 300,
                    ),
                    child: CupertinoButton(
                    color: Colors.pink,
                    padding: EdgeInsets.symmetric(
                    vertical: 1),
                    borderRadius: BorderRadius.circular(
                    6),
                    onPressed: () {
                    Navigator.push(context,
                    MaterialPageRoute(
                    builder: (context) =>
                    pantalla_4(dato.text)));
                    },
                    child: Text("Consultar",
                    style: TextStyle(fontSize: 20),
                    )
                )
                ),
              ],
        )
    )
        ],
    ),
  ],
    ),
        ),
    )
    )
  ],
    ),
    );
  }
}