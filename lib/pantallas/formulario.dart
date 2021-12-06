import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gestiontiendas/widgets/Circle.dart';
import 'package:gestiontiendas/widgets/input_text.dart';
import 'main.dart';

class formulario extends StatefulWidget {
  const formulario({Key? key}) : super(key: key);

  @override
  _fromularioState createState() => _fromularioState();
}


class _fromularioState extends State<formulario> {
  final cedula=TextEditingController();
  final nombre=TextEditingController();
  final direccion=TextEditingController();
  final telefono=TextEditingController();
  final celular=TextEditingController();
  void limpiar(){
    cedula.text=""; nombre.text=""; direccion.text=""; telefono.text=""; celular.text="";
  }

CollectionReference clientes=FirebaseFirestore.instance.collection('Clientes');
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      drawer: menu(),
      appBar: AppBar(
        title:Image.network("https://img.freepik.com/vector-gratis/personas-pie-cola-tienda_23-2148594615.jpg?size=626&ext=jpg", height: 90, width: 60),
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
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
            children: <Widget>[

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
                            margin: EdgeInsets.only(top: size.width * 0.2),
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
                          SizedBox(height: 20),
                          Text(
                            "Registro Cliente", textAlign: TextAlign.center,
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
                                        controller: cedula,
                                        decoration: InputDecoration(
                                            hintText: "Número de C.C",
                                        )
                                      ),
                                      TextField(
                                          controller: nombre,
                                          decoration: InputDecoration(
                                            hintText: "Nombre",
                                          )
                                      ),
                                      TextField(
                                          controller: direccion,
                                        decoration: InputDecoration(
                                          hintText: "Direccion",
                                        )
                                      ),
                                      TextField(
                                          controller: telefono,
                                          decoration: InputDecoration(
                                          hintText: "Telefono",
                                        )
                                      ),
                                      TextField(
                                          controller: celular,
                                        decoration: InputDecoration(
                                          hintText: "Celular",
                                        )
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 25),
                                ConstrainedBox(constraints: BoxConstraints(
                                  maxWidth: 200,
                                  minWidth: 200,
                                ),
                                    child: CupertinoButton(
                                        color: Colors.pink,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 17),
                                        borderRadius: BorderRadius.circular(
                                            6),
                                        onPressed: () {
                                          if (cedula.text.isEmpty ||nombre.text.isEmpty || direccion.text.isEmpty || telefono.text.isEmpty || celular.text.isEmpty) {
                                            print("Campos vacios");
                                            Fluttertoast.showToast(msg: "Campos Vacios", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                                          } else {
                                          clientes.doc(cedula.text).set({
                                          "nombre": nombre.text,
                                          "direccion": direccion.text,
                                          "telefono": telefono.text,
                                          "celular": celular.text
                                          });
                                          }
                                          },
                                        child: Text("Registrar",
                                          style: TextStyle(fontSize: 20),
                                        )
                                    )
                                ),
                                  ],
                                ),
                              ]
                          )

                      ),
                    )
                ),
            ]
        )
    ),
  );
  }
}


