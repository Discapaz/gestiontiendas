import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class crud extends StatefulWidget {
  const crud({Key? key}) : super(key: key);

  @override
  _crudState createState() => _crudState();
}

class _crudState extends State<crud> {
  final cedula=TextEditingController();
  final celular=TextEditingController();
  final direccion=TextEditingController();
  final nombre=TextEditingController();
  final telefono=TextEditingController();

  void limpiar(){
    cedula.text="";celular.text="";direccion.text="";nombre.text="";telefono.text="";
  }
  CollectionReference clientes=FirebaseFirestore.instance.collection('Clientes');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Clientes'),
      ),
      body: ListView(
        children: [
          Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top:20.0),
              child: TextField(
                controller: cedula,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    icon: Icon(Icons.pin_outlined,size: 25),
                    hintText: "Digite numero de cedula",
                    hintStyle: TextStyle(color: Colors.black38)

                ),
              )
          ),
          Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: celular,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    icon: Icon(Icons.call_outlined,size: 25),
                    hintText: "Digite numero de celular",
                    hintStyle: TextStyle(color: Colors.black38)

                ),
              )
          ),
          Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: direccion,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    icon: Icon(Icons.assignment_rounded,size: 25),
                    hintText: "Digite direccion",
                    hintStyle: TextStyle(color: Colors.black38)

                ),
              )
          ),
          Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: nombre,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    icon: Icon(Icons.badge_outlined,size: 25),
                    hintText: "Digite nombre",
                    hintStyle: TextStyle(color: Colors.black38)
                ),
              )
          ),
          Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: telefono,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    icon: Icon(Icons.call_outlined,size: 25),
                    hintText: "Digite telefono",
                    hintStyle: TextStyle(color: Colors.black38)
                ),
              )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    if(cedula.text.isEmpty || celular.text.isEmpty || direccion.text.isEmpty || nombre.text.isEmpty || telefono.text.isEmpty){
                      print("Campos Vacios");
                      Fluttertoast.showToast(msg:"Campos vacios", toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.BOTTOM );
                    }else{
                      QuerySnapshot existe = await clientes.where(FieldPath.documentId, isEqualTo: cedula.text).get();
                      if(existe.docs.length>0){
                        Fluttertoast.showToast(msg:"El cliente ya Existe", toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.BOTTOM );
                        limpiar();
                      }else{
                        clientes.doc(cedula.text).set({
                          "celular": celular.text,
                          "direccion":direccion.text,
                          "nombre":nombre.text,
                          "telefono":telefono.text,
                        });
                        QuerySnapshot inserto = await clientes.where(FieldPath.documentId, isEqualTo: cedula.text).get();
                        limpiar();
                        if(inserto.docs.length>0){
                          Fluttertoast.showToast(msg:"El cliente se registró exitosamente", toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.BOTTOM );
                        }else{
                          Fluttertoast.showToast(msg:"El cliente no se registró exitosamente", toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.BOTTOM );
                        }
                      }
                    }
                    setState(() {

                    });
                  },
                  child: Text("Registrar", style: TextStyle(color: Colors.white,fontSize:25)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top:20.0),
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    if(cedula.text.isEmpty){
                      Fluttertoast.showToast(msg:"Digite la cedula",fontSize: 20,backgroundColor: Colors.red, textColor: Colors.lightGreen, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                    }else{
                      List lista=[];
                      //var id;
                      var ced=cedula.text;
                      QuerySnapshot consulta = await clientes.where(FieldPath.documentId, isEqualTo: cedula.text).get();
                      if(consulta.docs.length>0){
                        for(var doc in consulta.docs){
                          //id=FieldPath.documentId;
                          lista.add(doc.data());
                        }
                        Fluttertoast.showToast(msg:"Cargando Datos",fontSize: 20,backgroundColor: Colors.red, textColor: Colors.lightGreen, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                        cedula.text=ced;
                        direccion.text=lista[0]['direccion'];
                        nombre.text=lista[0]['nombre'];
                        telefono.text=lista[0]['telefono'];
                      }else{
                        limpiar();
                        Fluttertoast.showToast(msg:"El cliente no se encontró",fontSize: 20,backgroundColor: Colors.red, textColor: Colors.lightGreen, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                      }
                    }
                  },
                  child: Text("Consultar", style: TextStyle(color: Colors.white,fontSize:25)),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom:20.0),
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: (){
                    if(cedula.text.isEmpty || direccion.text.isEmpty || nombre.text.isEmpty || telefono.text.isEmpty){
                      Fluttertoast.showToast(msg:"Campos vacíos",fontSize: 20,backgroundColor: Colors.red, textColor: Colors.white, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                    }else{
                      clientes.doc(cedula.text).update({
                        "celular": celular.text,
                        "direccion":direccion.text,
                        "nombre":nombre.text,
                        "telefono":telefono.text,
                      });
                      limpiar();
                      Fluttertoast.showToast(msg:"Datos actualizados correctamente",fontSize: 20,backgroundColor: Colors.red, textColor: Colors.white, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                    }

                  },
                  child: Text("Actualizar", style: TextStyle(color: Colors.white,fontSize:25)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom:20.0),
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: (){
                    if(cedula.text.isEmpty || direccion.text.isEmpty || nombre.text.isEmpty || telefono.text.isEmpty){
                      Fluttertoast.showToast(msg:"Campos vacíos",fontSize: 20,backgroundColor: Colors.red, textColor: Colors.white, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                    }else{
                      clientes.doc(cedula.text).delete();
                      limpiar();
                      Fluttertoast.showToast(msg:"Cliente eliminado exitosamente",fontSize: 20,backgroundColor: Colors.red, textColor: Colors.white, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                    }

                  },
                  child: Text("Eliminar", style: TextStyle(color: Colors.white,fontSize:25)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}