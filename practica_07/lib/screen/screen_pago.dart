import 'package:flutter/material.dart';
import '../controllers/pago_controller.dart';

class ScreenPago extends StatefulWidget {
  const ScreenPago({super.key});

  @override
  State<ScreenPago> createState() => _ScreenPagoState();
}

class _ScreenPagoState extends State<ScreenPago> {
  // Controlador lógico
  final PagoController _pagoController = PagoController();

  // Controladores de texto para los 3 campos (Sesión 7)
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _horasController = TextEditingController();
  final TextEditingController _pagoHoraController = TextEditingController();

  // Variables de estado para actualizar la vista
  String _mensajeAdvertencia = '';
  String _nombreTrabajador = '';
  String _sueldoResultado = '';
  String _detalleCalculo = '';

  @override
  void initState() {
    super.initState();
  }

  // Liberación de memoria (Sesión 7)
  @override
  void dispose() {
    _nombreController.dispose();
    _horasController.dispose();
    _pagoHoraController.dispose();
    super.dispose();
  }

  void _calcularSueldo() {
    bool valido = _pagoController.calcularPago(
      _nombreController.text,
      _horasController.text,
      _pagoHoraController.text,
    );

    // Actualiza la pantalla con setState() (Sesión 6 y 7)
    setState(() {
      if (valido) {
        _mensajeAdvertencia = '';
        _nombreTrabajador = _nombreController.text;
        _sueldoResultado = _pagoController.sueldoTotalFormateado;
        _detalleCalculo = _pagoController.detalleHoras;
      } else {
        _mensajeAdvertencia = _pagoController.mensajeError;
        _nombreTrabajador = '';
        _sueldoResultado = '';
        _detalleCalculo = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pago de Trabajador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Campo para ingresar el nombre del trabajador
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre del trabajador',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 12),

            // 2. Campo para ingresar las horas trabajadas durante la semana
            TextField(
              controller: _horasController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Horas trabajadas en la semana',
                prefixIcon: Icon(Icons.edit),
              ),
            ),
            const SizedBox(height: 12),

            // 3. Campo para ingresar cuánto gana por cada hora trabajada
            TextField(
              controller: _pagoHoraController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Pago por hora (S/)',
                prefixIcon: Icon(Icons.edit),
              ),
            ),
            const SizedBox(height: 20),

            // 4. Botón Calcular sueldo
            ElevatedButton(
              onPressed: _calcularSueldo,
              child: const Text('Calcular sueldo'),
            ),
            const SizedBox(height: 20),

            // Mensaje de advertencia si hay error o valores negativos
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

            // 5 y 6. Mostrar nombre del trabajador y sueldo total en soles (S/)
            if (_sueldoResultado.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.blue,
                child: Column(
                  children: [
                    Text(
                      'Trabajador: $_nombreTrabajador',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _detalleCalculo,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sueldo Total: $_sueldoResultado',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
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