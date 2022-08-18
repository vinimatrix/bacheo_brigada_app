import 'dart:typed_data';

class User {
  final int? id;
  final String? nombre;
  final String? phone;
  final String? codigo_brigada;
  final String? placa;
  final String? token;

  User({
    this.id,
    this.nombre,
    this.codigo_brigada,
    this.placa,
    this.phone,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      nombre: json["nombre"],
      codigo_brigada: json["codigo_brigada"],
      placa: json["placa"],
      phone: json["phone"],
      token: json["token"],
    );
  }
  factory User.fromSharedPreferences(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      phone: json["phone"],
      token: json["token"],
      nombre: json["nombre"],
      codigo_brigada: json["codigo_brigada"],
      placa: json["placa"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "token": token,
        "nombre": nombre,
        "codigo_brigada": codigo_brigada,
        "placa": placa,
      };
}
