import 'dart:convert';
import 'dart:async';
import 'package:acceso/menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

void main() {
  runApp(const Acceso());
}

class Acceso extends StatefulWidget {
  const Acceso({super.key});

  @override
  State<Acceso> createState() => _MainAppState();
}

class _MainAppState extends State<Acceso> {
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    getUsuarios();
  }

  Future<void> getUsuarios() async {
    final response =
        await http.get(Uri.parse('https://api-3xoy.onrender.com/api/usuario'));

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedData = json.decode(response.body);

      setState(() {
        data = decodedData['usuario'] ?? [];
      });
    } else {
      print('Error al cargar los datos: ${response.statusCode}');
    }
  }

  Widget build(BuildContext context) {
    final GlobalKey<FormState> formUsuario = GlobalKey<FormState>();
    final usuarioIngresado = TextEditingController();
    final contrasenaIngresada = TextEditingController();
    return MaterialApp(
      home: Scaffold(
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
              const Text('Acceso'),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(100),
            child: Form(
              key: formUsuario,
              child: Column(
                children: [
                  TextFormField(
                    controller: usuarioIngresado,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        iconColor: Color.fromARGB(255, 221, 58, 58),
                        labelText: 'Usuario'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'El Usuario es requerido!';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: contrasenaIngresada,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.password),
                        iconColor: Color.fromARGB(255, 221, 58, 58),
                        labelText: 'Contraseña'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'La contraseña es requerida!';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 221, 58, 58))),
                    onPressed: () {
                      if (!formUsuario.currentState!.validate()) {
                        print('Formulario no válido');
                      } else {
                        // Buscar el usuario ingresado en los datos obtenidos de la API
                        final usuario = usuarioIngresado.text;
                        final contrasena = contrasenaIngresada.text;

                        final usuarioEncontrado = data.firstWhere(
                          (user) =>
                              user['nombre'] == usuario &&
                              user['password'] == contrasena,
                          orElse: () => null,
                        );

                        if (usuarioEncontrado != null) {
                          // El usuario y la contraseña coinciden con los datos de la API
                          final route = MaterialPageRoute(
                              builder: (context) => const Menu());
                          Navigator.push(context, route);
                        } else {
                          // Usuario o contraseña incorrectos
                          print('Usuario o contraseña incorrecto');
                        }
                      }
                    },
                    child: const Text('Ingresar',
                        style: TextStyle(
                            color: Colors.white)), // Cambio de color a blanco
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
