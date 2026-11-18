class DescuentoController {
  String mensajeError = '';
  String descuentoAplicadoFormateado = '';
  String precioFinalFormateado = '';
  String tipoDescuento = '';
  bool esDescuentoEspecial = false;

  bool calcularDescuento(
    String nombreProducto,
    String txtPrecio,
    String txtPorcentaje,
  ) {
    // Limpiamos variables anteriores
    mensajeError = '';
    descuentoAplicadoFormateado = '';
    precioFinalFormateado = '';
    tipoDescuento = '';

    // Validar que ningún campo esté vacío
    if (nombreProducto.isEmpty || txtPrecio.isEmpty || txtPorcentaje.isEmpty) {
      mensajeError = 'Advertencia: Todos los campos son obligatorios.';
      return false;
    }

    // Convertir textos a números decimales (double)
    double? precio = double.tryParse(txtPrecio);
    double? porcentaje = double.tryParse(txtPorcentaje);

    if (precio == null || porcentaje == null) {
      mensajeError = 'Advertencia: Ingrese valores numéricos válidos.';
      return false;
    }

    // Condición 4: El precio del producto debe ser mayor que cero
    if (precio <= 0) {
      mensajeError = 'Advertencia: El precio del producto debe ser mayor que cero.';
      return false;
    }

    // Condición 3: El descuento debe estar entre 0 % y 100 %
    if (porcentaje < 0 || porcentaje > 100) {
      mensajeError = 'Advertencia: El porcentaje de descuento debe estar entre 0 % y 100 %.';
      return false;
    }

    // Cálculos matemáticos
    double montoDescuento = precio * (porcentaje / 100);
    double precioFinal = precio - montoDescuento;

    // Formateo a dos decimales
    descuentoAplicadoFormateado = 'S/ ${montoDescuento.toStringAsFixed(2)}';
    precioFinalFormateado = 'S/ ${precioFinal.toStringAsFixed(2)}';

    // Condición 1 y 2: Descuento especial (>= 20%) o Descuento regular (< 20%)
    if (porcentaje >= 20) {
      esDescuentoEspecial = true;
      tipoDescuento = 'Descuento especial';
    } else {
      esDescuentoEspecial = false;
      tipoDescuento = 'Descuento regular';
    }

    return true;
  }
}