import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestiontiendas/pantallas/pantalla_2.dart';
import 'package:gestiontiendas/widgets/Circle.dart';
import 'package:gestiontiendas/widgets/input_text.dart';

import 'formulario.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  final contrasena=TextEditingController();
  final usuario=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Container(
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
                            SizedBox(height: 30),
                            Text(
                              "Bienvenido", textAlign: TextAlign.center,
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
                                        InputText(label: "Usuario", controller: usuario),
                                        SizedBox(height: 30),
                                        InputText(label: "Contraseña", controller: contrasena,)
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 40),
                                  ConstrainedBox(constraints: BoxConstraints(
                                    maxWidth: 300,
                                    minWidth: 300,
                                  ),
                                      child: CupertinoButton(
                                          color: Colors.pink,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 17),
                                          borderRadius: BorderRadius.circular(
                                              6),
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        pantalla_2()));
                                          },
                                          child: Text("Sing in",
                                            style: TextStyle(fontSize: 20),
                                          )
                                      )
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CupertinoButton(
                                        onPressed: () {},
                                        child: Text("Sing up", style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.deepPurple)),
                                      )
                                    ],
                                  ),
                                ]
                            )
                          ],
                        ),
                      )
                  ),
                )
              ]
          )
      ),
    );
  }
}

class menu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.amberAccent
                ),
                child: Image.network('https://www.lifeder.com/wp-content/uploads/2018/06/mercado-negocios-empresas-630x420.jpg')
            ),
            Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.account_circle_outlined, size: 30, color: Colors.green),
                    title: Text("Consultar Personas"),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>pantalla_2()));
                    },
                  ),
                  ListTile(
                    trailing: Icon(Icons.account_box,size: 30, color: Colors.green),
                    title: Text("Registrar Cliente"),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> formulario()));
                    },
                  ),
                  ListTile(
                    trailing: Icon(Icons.account_box,size: 30, color: Colors.green),
                    enabled: true,
                    title: Text("Actualizar Datos"),
                    onTap: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>));
                    },
                  ),
                  ListTile(
                    trailing: Icon(Icons.account_box,size: 30, color: Colors.green),
                    enabled: true,
                    title: Text("Registrar Pedido"),
                    onTap: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>));
                    },
                  )
                ]
            )
          ],
        )
    );
  }
}