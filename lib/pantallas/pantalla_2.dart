import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestiontiendas/pantallas/pantalla_3.dart';
import 'main.dart';




class pantalla_2 extends StatefulWidget {
  const pantalla_2 ({Key? key}) : super(key: key);

  @override
  _pantalla_2State createState() => _pantalla_2State();
}

class _pantalla_2State extends State<pantalla_2> {
  List datos_tiendas = [];
  void initState() {
    super.initState();
    getTiendas();
  }
  void getTiendas() async {
    CollectionReference datos  = FirebaseFirestore.instance.collection("Tiendas"); //Conexión a la colección
    QuerySnapshot tiendas = await datos.get(); //Traer todas las tiendas
    if(tiendas.docs.length > 0) { //Trae datos
      print("Trae datos");
      for(var doc in tiendas.docs) {
        print(doc.data());
        setState(() {
          datos_tiendas.add(doc.data());
        });
      }
    } else {
      print("Ha fallado...");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Listado"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: datos_tiendas.length,
          itemBuilder: (BuildContext context,i) {
            return ListTile(
              title: Text("Negocio:  " + i.toString()+" - "+datos_tiendas[i]['Categoria'].toString()),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => pantalla_3()));
          }, label: Text("Siguiente"),
          icon: Icon(Icons.arrow_forward)
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


