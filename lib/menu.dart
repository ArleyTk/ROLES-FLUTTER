import 'package:acceso/acceso.dart';
import 'package:acceso/editarrol.dart';
import 'package:acceso/home.dart';
import 'package:acceso/registroroles.dart';
import 'package:acceso/listaroles.dart';
import 'package:acceso/usuario.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Menu());
}

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.network(
              'lib/assets/logo.png', // Ruta de la imagen
              width: 60, // Ancho de la imagen
              height: 60, // Alto de la imagen
            ),
            const SizedBox(width: 30), // Espacio entre la imagen y el texto
            const Text('LUCHOSOFT'),
          ],
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        backgroundColor: const Color.fromARGB(255, 221, 58, 58),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 221, 58, 58),
              ),
              accountName: const Text('DONDE LUCHO'),
              accountEmail: const Text('Admin'),
            ),
            ListTile(
              title: const Text('Gestión de roles'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListarUsuarios()));
              },
            ),
            ListTile(
              title: const Text('Gestión de acceso'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
            ),
            ListTile(
              title: const Text('Salir'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Acceso()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
