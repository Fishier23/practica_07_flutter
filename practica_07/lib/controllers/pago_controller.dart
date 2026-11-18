class PagoController {
  String mensajeError = '';
  String sueldoTotalFormateado = '';
  String detalleHoras = '';

  bool calcularPago(
    String nombre,
    String txtHoras,
    String txtPagoHora,
  ) {
    // Limpiamos mensajes previos
    mensajeError = '';
    sueldoTotalFormateado = '';
    detalleHoras = '';

    // Validar que los campos no estén vacíos
    if (nombre.isEmpty || txtHoras.isEmpty || txtPagoHora.isEmpty) {
      mensajeError = 'Advertencia: Todos los campos son obligatorios.';
      return false;
    }

    // Convertir textos a números decimales (double)
    double? horas = double.tryParse(txtHoras);
    double? pagoHora = double.tryParse(txtPagoHora);

    if (horas == null || pagoHora == null) {
      mensajeError = 'Advertencia: Ingrese valores numéricos válidos.';
      return false;
    }

    // Condición 3: No se deben permitir valores negativos
    if (horas < 0 || pagoHora < 0) {
      mensajeError = 'Advertencia: No se permiten valores negativos.';
      return false;
    }

    double sueldoTotal = 0;

    // Condición 1 y 2: Cálculo hasta 48 horas vs más de 48 horas (+50%)
    if (horas <= 48) {
      sueldoTotal = horas * pagoHora;
      detalleHoras = 'Horas normales: $horas';
    } else {
      double horasExtras = horas - 48;
      double pagoNormal = 48 * pagoHora;
      double pagoExtra = horasExtras * (pagoHora * 1.5);
      sueldoTotal = pagoNormal + pagoExtra;
      detalleHoras = 'Horas normales: 48 | Horas extras (+50%): $horasExtras';
    }

    // Condición 4: El sueldo debe mostrarse en soles (S/)
    sueldoTotalFormateado = 'S/ ${sueldoTotal.toStringAsFixed(2)}';

    return true;
  }
}