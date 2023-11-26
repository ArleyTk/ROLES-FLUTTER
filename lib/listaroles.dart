import 'dart:convert';
import 'package:acceso/editarrol.dart';
import 'package:acceso/registroroles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: ListarUsuarios(),
  ));
}

class ListarUsuarios extends StatefulWidget {
  const ListarUsuarios({Key? key}) : super(key: key);

  @override
  State<ListarUsuarios> createState() => _ListarUsuariosState();
}

class _ListarUsuariosState extends State<ListarUsuarios> {
  List<dynamic> data = [];
  List<dynamic> filteredData = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUsuarios();
  }

  Future<void> getUsuarios() async {
    final response =
        await http.get(Uri.parse('https://rolesxd.onrender.com/api/usuario'));

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedData = json.decode(response.body);

      setState(() {
        data = decodedData['permisos'] ?? [];
        filteredData = data;
      });
    } else {
      print('Failed to load data');
    }
  }

  void filterSearchResults(String query) {
    List<dynamic> dummySearchList = List.from(data);
    if (query.isNotEmpty) {
      List<dynamic> tempList = [];
      dummySearchList.forEach((item) {
        if (item['nombrerol'].toLowerCase().contains(query.toLowerCase())) {
          tempList.add(item);
        }
      });
      setState(() {
        filteredData = tempList;
      });
      return;
    } else {
      setState(() {
        filteredData = data;
      });
    }
  }

  Future<void> eliminarUsuario(int idrol) async {
    final apiUrl =
        Uri.parse('https://rolesxd.onrender.com/api/usuario?idrol=$idrol');

    try {
      final response = await http.delete(
        apiUrl,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        setState(() {
          filteredData.removeWhere((element) => element['idrol'] == idrol);
        });
        Navigator.pop(context);
        getUsuarios(); // Refrescar la lista después de eliminar
      } else {
        print('Error al eliminar el rol');
      }
    } catch (error) {
      print('Error inesperado al intentar eliminar el rol: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
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
              const Text('Listado de roles'),
            ],
          ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                filterSearchResults(value);
              },
              decoration: InputDecoration(
                labelText: 'Buscar usuario',
                hintText: 'Escribe el nombre del usuario',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Color.fromARGB(
                      255, 240, 240, 240), // Color de fondo de la tarjeta
                  child: ListTile(
                    title: Text(
                      filteredData[index]['nombrerol'],
                      style: TextStyle(color: Color.fromARGB(255, 170, 0, 0)),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ID: ${filteredData[index]['idrol']}'),
                        Text('Descripción: ${filteredData[index]['descrol']}'),
                        Text('Permisos: ${filteredData[index]['permisosrol']}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Roleseditar()),
                            );
                          },
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 255, 217, 0),
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: CircleAvatar(
                            backgroundColor:
                                Colors.red, // Color de fondo del botón delete

                            child: Icon(Icons.delete,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                      '¿Estás seguro de eliminar este rol?'),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        eliminarUsuario(
                                            filteredData[index]['idrol']);
                                      },
                                      child: const Text('Sí'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancelar'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 221, 58, 58),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('¿Estás seguro de agregar un nuevo rol?'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Roles()),
                      );
                    },
                    child: const Text('Estoy seguro'),
                  ),
                ],
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white, // Cambiar el color del icono a blanco
        ),
      ),
    );
  }
}
