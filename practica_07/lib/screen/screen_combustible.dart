import 'package:flutter/material.dart';
import '../controllers/combustible_controller.dart';

class ScreenCombustible extends StatefulWidget {
  const ScreenCombustible({super.key});

  @override
  State<ScreenCombustible> createState() => _ScreenCombustibleState();
}

class _ScreenCombustibleState extends State<ScreenCombustible> {
  // Controlador lógico
  final CombustibleController _combustibleController = CombustibleController();

  // Controladores de texto para los 3 campos (Sesión 7)
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _distanciaController = TextEditingController();
  final TextEditingController _combustibleTextController =
      TextEditingController();

  // Variables de estado para actualizar la interfaz
  String _mensajeAdvertencia = '';
  String _marcaVehiculo = '';
  String _rendimientoResultado = '';
  String _estadoRendimiento = '';
  bool _buenRendimiento = false;

  @override
  void initState() {
    super.initState();
  }

  // Liberamos recursos al cerrar la pantalla (Sesión 7)
  @override
  void dispose() {
    _marcaController.dispose();
    _distanciaController.dispose();
    _combustibleTextController.dispose();
    super.dispose();
  }

  void _calcular() {
    bool valido = _combustibleController.calcularRendimiento(
      _marcaController.text,
      _distanciaController.text,
      _combustibleTextController.text,
    );

    // Actualizamos la pantalla con setState() (Sesión 6 y 7)
    setState(() {
      if (valido) {
        _mensajeAdvertencia = '';
        _marcaVehiculo = _marcaController.text;
        _rendimientoResultado = _combustibleController.rendimientoFormateado;
        _estadoRendimiento = _combustibleController.mensajeRendimiento;
        _buenRendimiento = _combustibleController.esBuenRendimiento;
      } else {
        _mensajeAdvertencia = _combustibleController.mensajeError;
        _marcaVehiculo = '';
        _rendimientoResultado = '';
        _estadoRendimiento = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumo de Combustible'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Campo para ingresar la marca del vehículo
            TextField(
              controller: _marcaController,
              decoration: const InputDecoration(
                labelText: 'Marca del vehículo',
                prefixIcon: Icon(Icons.edit),
              ),
            ),
            const SizedBox(height: 12),

            // 2. Campo para ingresar la distancia recorrida en kilómetros
            TextField(
              controller: _distanciaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Distancia recorrida (km)',
                prefixIcon: Icon(Icons.edit),
              ),
            ),
            const SizedBox(height: 12),

            // 3. Campo para ingresar la cantidad de combustible utilizado en litros
            TextField(
              controller: _combustibleTextController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Combustible utilizado (litros)',
                prefixIcon: Icon(Icons.edit),
              ),
            ),
            const SizedBox(height: 20),

            // 4. Botón Calcular rendimiento
            ElevatedButton(
              onPressed: _calcular,
              child: const Text('Calcular rendimiento'),
            ),
            const SizedBox(height: 20),

            // Mensaje de advertencia si hay campos vacíos o valores <= 0 (Condición 4)
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

            // 5, 6 y 7. Mostrar marca, rendimiento en km/l y mensaje de rendimiento
            if (_rendimientoResultado.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                color: _buenRendimiento ? Colors.green : Colors.red,
                child: Column(
                  children: [
                    Text(
                      'Vehículo: $_marcaVehiculo',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Rendimiento: $_rendimientoResultado',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _estadoRendimiento,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
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