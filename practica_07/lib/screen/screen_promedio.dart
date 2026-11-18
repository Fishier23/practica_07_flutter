import 'package:flutter/material.dart';
import '../controllers/promedio_controller.dart';

class ScreenPromedio extends StatefulWidget {
  const ScreenPromedio({super.key});

  @override
  State<ScreenPromedio> createState() => _ScreenPromedioState();
}

class _ScreenPromedioState extends State<ScreenPromedio> {
  // Controlador de lógica
  final PromedioController _promedioController = PromedioController();

  // TextEditingController para cada campo (Sesión 7)
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _nota1Controller = TextEditingController();
  final TextEditingController _nota2Controller = TextEditingController();
  final TextEditingController _nota3Controller = TextEditingController();

  // Variables de estado para actualizar la interfaz
  String _mensajeAdvertencia = '';
  String _textoPromedio = '';
  String _textoEstado = '';
  bool _aprobado = false;

  @override
  void initState() {
    super.initState();
  }

  // Liberamos recursos para evitar fugas de memoria (Sesión 7)
  @override
  void dispose() {
    _nombreController.dispose();
    _nota1Controller.dispose();
    _nota2Controller.dispose();
    _nota3Controller.dispose();
    super.dispose();
  }

  void _calcular() {
    bool valido = _promedioController.calcularPromedio(
      _nombreController.text,
      _nota1Controller.text,
      _nota2Controller.text,
      _nota3Controller.text,
    );

    // Actualizamos la pantalla con setState() (Sesión 6 y 7)
    setState(() {
      if (valido) {
        _mensajeAdvertencia = '';
        _textoPromedio =
            'Estudiante: ${_nombreController.text}\nPromedio Final: ${_promedioController.resultadoPromedio}';
        _textoEstado = _promedioController.estadoEstudiante;
        _aprobado = _promedioController.esAprobado;
      } else {
        _mensajeAdvertencia = _promedioController.mensajeError;
        _textoPromedio = '';
        _textoEstado = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promedio Académico'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo Nombre del estudiante
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre del estudiante',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 12),

            // Campo Nota 1
            TextField(
              controller: _nota1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nota 1 (0 - 20)',
                prefixIcon: Icon(Icons.edit),
              ),
            ),
            const SizedBox(height: 12),

            // Campo Nota 2
            TextField(
              controller: _nota2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nota 2 (0 - 20)',
                prefixIcon: Icon(Icons.edit),
              ),
            ),
            const SizedBox(height: 12),

            // Campo Nota 3
            TextField(
              controller: _nota3Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nota 3 (0 - 20)',
                prefixIcon: Icon(Icons.edit),
              ),
            ),
            const SizedBox(height: 20),

            // Botón Calcular promedio
            ElevatedButton(
              onPressed: _calcular,
              child: const Text('Calcular promedio'),
            ),
            const SizedBox(height: 20),

            // Mensaje de advertencia (Condición 2 y 4)
            if (_mensajeAdvertencia.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                color: Colors.orange,
                child: Text(
                  _mensajeAdvertencia,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),

            // Resultado del promedio y estado Aprobado/Desaprobado (Condición 1 y 3)
            if (_textoPromedio.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                color: _aprobado ? Colors.green : Colors.red,
                child: Column(
                  children: [
                    Text(
                      _textoPromedio,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Estado: $_textoEstado',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}