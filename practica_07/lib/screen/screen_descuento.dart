import 'package:flutter/material.dart';
import '../controllers/descuento_controller.dart';

class ScreenDescuento extends StatefulWidget {
  const ScreenDescuento({super.key});

  @override
  State<ScreenDescuento> createState() => _ScreenDescuentoState();
}

class _ScreenDescuentoState extends State<ScreenDescuento> {
  // Controlador lógico
  final DescuentoController _descuentoController = DescuentoController();

  // Controladores de texto para los 3 campos (Sesión 7)
  final TextEditingController _productoController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _porcentajeController = TextEditingController();

  // Variables de estado para actualizar la pantalla
  String _mensajeAdvertencia = '';
  String _nombreProducto = '';
  String _descuentoAplicado = '';
  String _precioFinal = '';
  String _mensajeTipoDescuento = '';
  bool _esEspecial = false;

  @override
  void initState() {
    super.initState();
  }

  // Liberamos memoria al cerrar la pantalla (Sesión 7)
  @override
  void dispose() {
    _productoController.dispose();
    _precioController.dispose();
    _porcentajeController.dispose();
    super.dispose();
  }

  void _calcular() {
    bool valido = _descuentoController.calcularDescuento(
      _productoController.text,
      _precioController.text,
      _porcentajeController.text,
    );

    // Actualizamos la interfaz con setState() (Sesión 6 y 7)
    setState(() {
      if (valido) {
        _mensajeAdvertencia = '';
        _nombreProducto = _productoController.text;
        _descuentoAplicado = _descuentoController.descuentoAplicadoFormateado;
        _precioFinal = _descuentoController.precioFinalFormateado;
        _mensajeTipoDescuento = _descuentoController.tipoDescuento;
        _esEspecial = _descuentoController.esDescuentoEspecial;
      } else {
        _mensajeAdvertencia = _descuentoController.mensajeError;
        _nombreProducto = '';
        _descuentoAplicado = '';
        _precioFinal = '';
        _mensajeTipoDescuento = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Descuento de Productos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Campo Nombre del producto
            TextField(
              controller: _productoController,
              decoration: const InputDecoration(
                labelText: 'Nombre del producto',
                prefixIcon: Icon(Icons.edit),
              ),
            ),
            const SizedBox(height: 12),

            // 2. Campo Precio del producto
            TextField(
              controller: _precioController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Precio del producto (S/)',
                prefixIcon: Icon(Icons.edit),
              ),
            ),
            const SizedBox(height: 12),

            // 3. Campo Porcentaje de descuento
            TextField(
              controller: _porcentajeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Porcentaje de descuento (0 - 100 %)',
                prefixIcon: Icon(Icons.edit),
              ),
            ),
            const SizedBox(height: 20),

            // 4. Botón Calcular descuento
            ElevatedButton(
              onPressed: _calcular,
              child: const Text('Calcular descuento'),
            ),
            const SizedBox(height: 20),

            // Mensaje de advertencia si falla una validación (Condiciones 3 y 4)
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

            // 5 y 6. Resultados: descuento aplicado, precio final y tipo de descuento
            if (_precioFinal.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                color: _esEspecial ? Colors.green : Colors.blue,
                child: Column(
                  children: [
                    Text(
                      'Producto: $_nombreProducto',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Descuento aplicado: $_descuentoAplicado',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Precio final: $_precioFinal',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _mensajeTipoDescuento,
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