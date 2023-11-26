import 'dart:convert';
import 'dart:async';
import 'package:acceso/menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var respuesta;

  Future<void> sendData(
      String nombre, String password, String rol, bool estado) async {
    final apiUrl = Uri.parse('https://api-3xoy.onrender.com/api/usuario');

    final response = await http.post(
      apiUrl,
      body: jsonEncode({
        'nombre': nombre,
        'password': password,
        'rol': rol,
        'estado': estado
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
    final nombre = TextEditingController();
    final password = TextEditingController();
    final rol = TextEditingController();
    final estado = TextEditingController();
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
              const Text('Agregar usuario'),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Form(
          key: formUsuario,
          child: Column(children: [
            TextFormField(
              controller: nombre,
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                label: Text('Nombre'),
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
              controller: password,
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                label: Text('Contraseña'),
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
              controller: rol,
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                label: Text('Rol'),
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
              controller: estado,
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                label: Text('Estado'),
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
            Row(
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 221, 58, 58))),
                    onPressed: () {
                      if (!formUsuario.currentState!.validate()) {
                        print('Formulario no valido');
                        return;
                      } else {
                        //postUsuarios("Dora", "123", "Admin", true);
                        sendData(nombre.text, password.text, rol.text,
                            bool.parse(estado.text));
                      }
                    },
                    child: const Text('Guardar',
                        style: TextStyle(color: Colors.white))),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 221, 58, 58))),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Menu()),
                    );
                  },
                  child: const Text(
                    'Atràs',
                    style: TextStyle(
                        color: Colors.white), // Cambio de color a blanco
                  ),
                ),
              ],
            )
          ]),
        )));
  }
}
