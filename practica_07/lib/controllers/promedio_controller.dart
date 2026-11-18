class PromedioController {
  String mensajeError = '';
  String resultadoPromedio = '';
  String estadoEstudiante = '';
  bool esAprobado = false;

  bool calcularPromedio(
    String nombre,
    String txtNota1,
    String txtNota2,
    String txtNota3,
  ) {
    // Limpiamos valores anteriores
    mensajeError = '';
    resultadoPromedio = '';
    estadoEstudiante = '';

    // Condición 4: Validar que ningún campo esté vacío
    if (nombre.isEmpty ||
        txtNota1.isEmpty ||
        txtNota2.isEmpty ||
        txtNota3.isEmpty) {
      mensajeError = 'Advertencia: Todos los campos son obligatorios.';
      return false;
    }

    // Convertimos los textos a números decimales (double)
    double? n1 = double.tryParse(txtNota1);
    double? n2 = double.tryParse(txtNota2);
    double? n3 = double.tryParse(txtNota3);

    if (n1 == null || n2 == null || n3 == null) {
      mensajeError = 'Advertencia: Ingrese solo valores numéricos.';
      return false;
    }

    // Condición 2: Las notas deben estar comprendidas entre 0 y 20
    if (n1 < 0 || n1 > 20 || n2 < 0 || n2 > 20 || n3 < 0 || n3 > 20) {
      mensajeError = 'Advertencia: Las notas deben estar entre 0 y 20.';
      return false;
    }

    // Cálculo del promedio
    double promedio = (n1 + n2 + n3) / 3;

    // Condición 3: El promedio debe mostrarse con dos decimales
    resultadoPromedio = promedio.toStringAsFixed(2);

    // Condición 1: La nota mínima aprobatoria es 13
    if (promedio >= 13) {
      esAprobado = true;
      estadoEstudiante = 'Aprobado';
    } else {
      esAprobado = false;
      estadoEstudiante = 'Desaprobado';
    }

    return true;
  }
}