import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:mivecindad/actualizarCliente.dart';
import 'listadoNegocios.dart';

import 'main.dart';


class moduloPedido extends StatefulWidget {
  const moduloPedido({Key? key}) : super(key: key);

  @override
  _moduloPedidoState createState() => _moduloPedidoState();
}

class _moduloPedidoState extends State<moduloPedido> {
  final cedula = TextEditingController();
  final correo = TextEditingController();
  CollectionReference cliente =
  FirebaseFirestore.instance.collection('Clientes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modulo Pedido'),
      ),
      drawer: menu(),
      body: ListView(children: [
        Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: cedula,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  icon: Icon(Icons.pin_outlined,
                      size:36,color: Colors.blue),
                  hintText: 'digite numero de cedula',
                  hintStyle: TextStyle(color: Colors.black38)
              ),
            )
        ),
        Container(
          padding: EdgeInsets.all(20.0),
          child: TextField(
            controller: correo,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                icon: Icon(Icons.local_post_office_outlined,
                    size: 36,color: Colors.blue),
                hintText: 'digite su nombre',
                hintStyle: TextStyle(color: Colors.black38)
            ),
          ),
        ),
        Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () async {
                QuerySnapshot ingreso = await cliente
                    .where(FieldPath.documentId, isEqualTo: cedula.text)
                    .where('nombre', isEqualTo:  correo.text)
                    .get();
                List listaCliente = [];
                if(ingreso.docs.length > 0){
                  for(var cli in ingreso.docs){
                    listaCliente.add(cli.data());
                  }

                  Navigator.push(context, MaterialPageRoute(
                      builder: (context)=>listaNegocios(cedula: cedula.text)));
                  Fluttertoast.showToast(msg: 'Cargando Datos',
                      fontSize: 20,
                      backgroundColor: Colors.lightBlueAccent,
                      textColor: Colors.white,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER);
                }else{
                  Fluttertoast.showToast(msg: 'Datos Incorrectos',
                      fontSize: 20,
                      backgroundColor: Colors.red,
                      textColor: Colors.lightGreen,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER);
                }
              },
              child: Text('Verificar',
                  style: TextStyle(color: Colors.white,
                      fontSize: 25)),
            )
        )
      ],
      ),
      floatingActionButton: FloatingActionButton(    // BOTON NAVEGACION  A HOME
        onPressed: (){
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>comprobarCliente()));
          Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
        },
        child: Icon(Icons.home, size: 30,color: Colors.white ),
      ),
    );
  }
}

