import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestiontiendas/pantallas/pantalla_2.dart';
import 'moduloPedido.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'registrarPedidos.dart';
//import 'package:mivecindad/pantalla1.dart';
import 'main.dart';

class listaNegocios extends StatefulWidget {
  final String cedula;

  const listaNegocios({required this.cedula});

  @override
  _listaNegociosState createState() => _listaNegociosState();
}

class _listaNegociosState extends State<listaNegocios> {
  List negocios = [];
  List codigos = [];

  void initState() {
    super.initState();
    getNegocios();
  }

  void getNegocios() async {
    CollectionReference negocio =
    FirebaseFirestore.instance.collection('Tiendas');
    String id;
    QuerySnapshot datos = await negocio.get();
    if (datos.docs.length > 0) {
      for (var doc in datos.docs) {
        id = doc.id.toString();
        codigos.add(id);
        print(id);
        negocios.add(doc.data());
      }
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado Negocios'),
      ),
      drawer: menu(),
      body: ListView.builder(
          itemCount: negocios.length,
          itemBuilder: (BuildContext context, i) {
            return ListTile(
              //padding: EdgeInsets.all(27),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => registrarPedido(
                              id: codigos[i], cedula: widget.cedula)));
                  // Navigator.push(context, MaterialPageRoute(builder:
                  //    (context)=>registrarPedido(id: codigos[i], cedula: widget.cedula)));
                },
                title: miCardImage(
                    url: negocios[i]['Foto'],
                    texto: negocios[i]['Nombre'] +
                        " \n ✆ :  " + negocios[i]['Telefono'] +
                        ' \n ➤ :  ' + negocios[i]['Direccion']));
          }),
      floatingActionButton: FloatingActionButton(
        // BOTON NAVEGACION  A HOME
        onPressed: () {
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>comprobarCliente()));
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
        },
        child: Icon(Icons.home, size: 30, color: Colors.white),
      ),
    );
  }
}
