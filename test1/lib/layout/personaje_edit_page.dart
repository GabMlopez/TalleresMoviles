import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Para Firebase Firestore
import '../modelo/personaje.dart';

class PersonajeEditPage extends StatefulWidget {
  static const String routeName = '/edit';
  const PersonajeEditPage({super.key});

  @override
  State<PersonajeEditPage> createState() => _PersonajeEditPageState();
}

class _PersonajeEditPageState extends State<PersonajeEditPage> {
  late Personaje personaje;

  late TextEditingController _nombreController;
  late TextEditingController _ocupacionController;
  late TextEditingController _especieController;
  late TextEditingController _edadController;

  late Gender _generoSeleccionado;

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)!.settings.arguments as Personaje;

    if (!mounted) return;

    personaje = args;

    _nombreController = TextEditingController(
      text: '${personaje.name.first} ${personaje.name.middle} ${personaje.name.last}'.trim(),
    );
    _ocupacionController = TextEditingController(text: personaje.occupation);
    _especieController = TextEditingController(text: personaje.species);
    _edadController = TextEditingController(text: personaje.age);
    _generoSeleccionado = personaje.gender;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _ocupacionController.dispose();
    _especieController.dispose();
    _edadController.dispose();
    super.dispose();
  }

  Future<void> _guardarEnFirebase() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {

      final nombreParts = _nombreController.text.trim().split(' ');
      final firstName = nombreParts.isNotEmpty ? nombreParts[0] : '';
      final middleName = nombreParts.length > 1 ? nombreParts[1] : '';
      final lastName = nombreParts.length > 2 ? nombreParts.sublist(2).join(' ') : '';

      final firestore = FirebaseFirestore.instance;
      await firestore.collection('personajes').doc(personaje.id.toString()).set({
        'name': {
          'first': firstName,
          'middle': middleName,
          'last': lastName,
        },
        'occupation': _ocupacionController.text.trim(),
        'species': _especieController.text.trim(),
        'age': _edadController.text.trim(),
        'gender': _generoSeleccionado.name,
      }, SetOptions(merge: true));

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Personaje guardado correctamente')),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar ${personaje.name.first}'),
        actions: [
          IconButton(
            icon: _isLoading ? const CircularProgressIndicator() : const Icon(Icons.save),
            onPressed: _isLoading ? null : _guardarEnFirebase,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(personaje.images.main),
                ),
              ),
              const SizedBox(height: 20),

              // Nombre completo
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre completo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El nombre no puede estar vacío';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Ocupación
              TextFormField(
                controller: _ocupacionController,
                decoration: const InputDecoration(
                  labelText: 'Ocupación',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'La ocupación no puede estar vacía';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Especie
              TextFormField(
                controller: _especieController,
                decoration: const InputDecoration(
                  labelText: 'Especie',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'La especie no puede estar vacía';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Edad
              TextFormField(
                controller: _edadController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Edad',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'La edad no puede estar vacía';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Género (Dropdown)
              DropdownButtonFormField<Gender>(
                value: _generoSeleccionado,
                decoration: const InputDecoration(
                  labelText: 'Género',
                  border: OutlineInputBorder(),
                ),
                items: Gender.values.map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender.name.toUpperCase()),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _generoSeleccionado = value;
                    });
                  }
                },
                validator: (value) {
                  if (value == null) {
                    return 'Selecciona un género';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _isLoading ? null : _guardarEnFirebase,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Guardar cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
