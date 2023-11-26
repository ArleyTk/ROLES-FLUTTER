import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Roleseditar extends StatefulWidget {
  const Roleseditar({Key? key}) : super(key: key);

  @override
  State<Roleseditar> createState() => _RoleseditarState();
}

class _RoleseditarState extends State<Roleseditar> {
  var respuesta;

  Future<void> sendData(String _id, String idrol, String nombrerol,
      String descrol, String permisosrol) async {
    final apiUrl = Uri.parse('https://rolesxd.onrender.com/api/usuario');

    final response = await http.put(
      apiUrl,
      body: jsonEncode({
        '_id': _id,
        'idrol': idrol,
        'nombrerol': nombrerol,
        'descrol': descrol,
        'permisosrol': permisosrol
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Respuesta de la API: ${response.body}');
    } else {
      print('Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formUsuario = GlobalKey<FormState>();
    final _id = TextEditingController();
    final idrol = TextEditingController();
    final nombrerol = TextEditingController();
    final descrol = TextEditingController();
    final permisosrol = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 221, 58, 58),
                    title: Row(
            children: [
              Image.network(
                'lib/assets/logo.png', // Aquí va la URL de la imagen
                width: 60, // Ancho de la imagen
                height: 60, // Alto de la imagen
              ),
              const SizedBox(width: 30), // Espacio entre la imagen y el texto
              const Text('Editar rol'),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Form(
          key: formUsuario,
          child: Column(children: [
            TextFormField(
              controller: idrol,
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                labelText: 'idrol',
                icon: Icon(Icons.text_fields),
                iconColor: Color.fromARGB(255, 221, 58, 58),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Este campo es requerido';
                }
                return null;
              },
            ),
            TextFormField(
              controller: nombrerol,
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                labelText: 'nombrerol',
                icon: Icon(Icons.key),
                iconColor: Color.fromARGB(255, 221, 58, 58),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Este campo es requerido';
                }
                return null;
              },
            ),
            TextFormField(
              controller: descrol,
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                labelText: 'descrol',
                icon: Icon(Icons.person),
                iconColor: Color.fromARGB(255, 221, 58, 58),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Este campo es requerido';
                }
                return null;
              },
            ),
            TextFormField(
              controller: permisosrol,
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                labelText: 'permisosrol',
                icon: Icon(Icons.bolt_outlined),
                iconColor: Color.fromARGB(255, 221, 58, 58),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Este campo es requerido';
                }
                return null;
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 205, 37, 37))),
              onPressed: () {
                if (!formUsuario.currentState!.validate()) {
                  print('Formulario no válido');
                  return;
                } else {
                  sendData(_id.text, idrol.text, nombrerol.text, descrol.text,
                      permisosrol.text);
                }
              },
              child: const Text('Guardar',
                  style: TextStyle(
                      color: Colors.white)), // Cambio de color a blanco
            ),
          ]),
        )));
  }
}
