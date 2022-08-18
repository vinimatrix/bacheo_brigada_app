class Asignacion {
  final int? id;
  final int idBrigada;
  final double lat;
  final double lon;
  final String? direccion;
  final String? referencia;
  final String? status;

  Asignacion(
      {this.id,
      required this.idBrigada,
      required this.lat,
      required this.lon,
      this.direccion,
      this.referencia,
      this.status});
}
