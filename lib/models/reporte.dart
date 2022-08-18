import 'package:bacheo_brigada/models/report_file.dart';

class Reporte {
  final int? id;
  final double? lat;
  final double? lng;
  final String? report;
  final String? direccion;
  final String? referencia;
  final String? status;
  final String? brigada_feedback;
  final int? userId;
  final List<ReportFile>? files;

  Reporte({
    this.id,
    required this.lat,
    required this.lng,
    this.report,
    this.direccion,
    this.referencia,
    this.status,
    this.userId,
    this.files,
    this.brigada_feedback,
  });

  factory Reporte.fromJson(Map<String, dynamic> json) => Reporte(
        id: json["id"],
        lat: json["lat"] ?? 0.0,
        lng: json["lon"] ?? 0.0,
        report: json["report"] ?? "",
        direccion: json["direccion"] ?? "",
        referencia: json["referencia"] ?? '',
        status: json["status"] ?? '',
        userId: json["userId"],
        brigada_feedback: json['brigada_feedback'],
        files: json["files"] == null
            ? null
            : List<ReportFile>.from(
                json["files"].map((x) => ReportFile.fromJson(x))),
      );
}
