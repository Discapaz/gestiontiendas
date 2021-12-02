import 'package:flutter/material.dart';
import 'package:gestiontiendas/pantallas/formulario.dart';
import 'package:gestiontiendas/pantallas/pantalla_4.dart';
import 'package:url_launcher/url_launcher.dart';

class pantalla_5 extends StatelessWidget {
  final datosTienda tienda;
  const pantalla_5({required this.tienda});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Datos detallados: " + tienda.Nombre),
      ),
      body: ListView(
        children: [
          myCardImage(
              url: tienda.Foto,
              texto: tienda.Nombre +
                  '\n' +
                  tienda.Direccion +
                  '\n' +
                  tienda.Celular +
                  ' ' +
                  '-' +
                  ' ' +
                  tienda.Telefono +
                  '\n' +
                  tienda.PaginaWeb),
          Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: ElevatedButton(
                  onPressed: () {
                    launch(tienda.PaginaWeb);
                  },
                  child: Text("Sitio web"),

                )
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => formulario()));
                  },
                  child: Text("Registrar Cliente", ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
