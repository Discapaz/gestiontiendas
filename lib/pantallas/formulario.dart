import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

CollectionReference clientes=FirebaseFirestore.instance.collection('Clientes');
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Scaffold(body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
            children: <Widget>[
              Positioned(
                  right: -size.width * 0.18,
                  top: -size.width * 0.36,
                  child: Circle(
                    radius: size.width * 0.45,
                    colors: [
                      Colors.purple,
                      Colors.deepPurpleAccent
                    ],
                    key: null,)
              ),

              Positioned(
                  left: -size.width * 0.15,
                  top: -size.width * 0.34,
                  child: Circle(
                    radius: size.width * 0.35,
                    colors: [
                      Colors.orange,
                      Colors.yellow
                    ],
                    key: null,)
              ),

              SingleChildScrollView(
                child: SafeArea(
                    child: Container(
                      width: size.width,
                      height: size.height,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 90,
                            height: 100,
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
                          SizedBox(height: 25),
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
                                SizedBox(height: 60),
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


