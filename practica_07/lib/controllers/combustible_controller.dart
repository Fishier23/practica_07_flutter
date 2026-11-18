class CombustibleController {
  String mensajeError = '';
  String rendimientoFormateado = '';
  String mensajeRendimiento = '';
  bool esBuenRendimiento = false;

  bool calcularRendimiento(
    String marcaVehiculo,
    String txtDistancia,
    String txtCombustible,
  ) {
    // Limpiamos variables anteriores
    mensajeError = '';
    rendimientoFormateado = '';
    mensajeRendimiento = '';

    // Validar que ningún campo esté vacío
    if (marcaVehiculo.isEmpty ||
        txtDistancia.isEmpty ||
        txtCombustible.isEmpty) {
      mensajeError = 'Advertencia: Todos los campos son obligatorios.';
      return false;
    }

    // Convertir textos a números decimales (double)
    double? distancia = double.tryParse(txtDistancia);
    double? combustible = double.tryParse(txtCombustible);

    if (distancia == null || combustible == null) {
      mensajeError = 'Advertencia: Ingrese valores numéricos válidos.';
      return false;
    }

    // Condición 4: La distancia recorrida y la cantidad de combustible deben ser mayores que cero
    if (distancia <= 0 || combustible <= 0) {
      mensajeError =
          'Advertencia: La distancia y el combustible deben ser mayores que cero.';
      return false;
    }

    // Condición 1: Dividir la distancia recorrida entre la cantidad de combustible utilizado
    double rendimiento = distancia / combustible;

    // Formateo a dos decimales en kilómetros por litro
    rendimientoFormateado = '${rendimiento.toStringAsFixed(2)} km/l';

    // Condición 2 y 3: Buen rendimiento (>= 15) o Rendimiento bajo (< 15)
    if (rendimiento >= 15) {
      esBuenRendimiento = true;
      mensajeRendimiento = 'Buen rendimiento';
    } else {
      esBuenRendimiento = false;
      mensajeRendimiento = 'Rendimiento bajo';
    }

    return true;
  }
}