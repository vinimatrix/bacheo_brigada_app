import 'dart:typed_data';

class ReportFile {
  final int? id;
  final Uint8List file;
  final int reportId;

  ReportFile({
    this.id,
    required this.file,
    required this.reportId,
  });

  factory ReportFile.fromJson(Map<String, dynamic> json) => ReportFile(
        id: json["id"],
        file: json["file"] != null
            ? Uint8List.fromList(json["file"]["data"].cast<int>().toList())
            : Uint8List(0),
        reportId: json["reportId"] ?? 0,
      );

  toJson() => {
        "id": id,
        "file": file,
        "reportId": reportId,
      };
}
