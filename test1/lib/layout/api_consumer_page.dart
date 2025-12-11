import 'package:flutter/material.dart';
import '../modelo/personaje.dart';
import 'package:dio/dio.dart';
import '../Widgets/Appbar.dart';

class ApiConsumerPage extends StatefulWidget {
  const ApiConsumerPage({super.key});

  @override
  State<ApiConsumerPage> createState() => _ApiConsumerPageState();
}

class _ApiConsumerPageState extends State<ApiConsumerPage> {
  late Future<List<Personaje>> Futurama_pjs;

  @override
  void initState(){
    super.initState();
    Futurama_pjs = fetch_pjs();
  }

  Future <List<Personaje>> fetch_pjs() async {
    final dio = Dio();
    final response = await dio.get('https://api.sampleapis.com/futurama/characters/');
    print(response.data);
    return personajeFromJson(response.data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Consumo de Api")),
      body:
      FutureBuilder<List<Personaje>>(
          future: Futurama_pjs,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No se encontraron personajes'));
            }
            final personajes = snapshot.data!;
      return Column(crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 10,),
        ListView.builder(
            itemBuilder: (context,index)
            {
              final personaje = personajes[index];

              return Card(
                elevation: 5,
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/edit', arguments: personaje);
                  },
                  leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(personaje.images.main),

                ),
                  title: Text(personaje.name.first),
                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ocupación: ${personaje.occupation}'),
                        Text('Especie: ${personaje.species}'),
                        Text('Edad: ${personaje.age}'),
                        Text('Género: ${personaje.gender.name}'),
                      ],
                  ),

                ),

              );
            },
            ),
      ]
    );

  })
    );
}
}
