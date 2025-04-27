import 'package:cloud_firestore/cloud_firestore.dart';

class Pesan {
  final String pengirimID;
  final String pengirimEmail;
  final String penerimaID;
  final String pesan;
  final Timestamp waktuIni;

  Pesan({required this.pengirimID, required this.pengirimEmail, required this.penerimaID, required this.pesan, required this.waktuIni});

  Map<String, dynamic> toFireBase(){
    return{
      'pengirim_id': pengirimID,
      'pengirim_email': pengirimEmail,
      'penerima_id': penerimaID,
      'pesan': pesan,
      'waktu_ini': waktuIni,
    };
  }
}
