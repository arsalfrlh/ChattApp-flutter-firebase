import 'package:chatapp/models/pesan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance; //menyimpan Firebase Firestore di variabel ini
  final FirebaseAuth auth = FirebaseAuth.instance; //menyimpan Firebase Auth di variabel ini

  /*
  contoh List<Map<String, dynamic>
  [   //ini di dalama List
  {   //ini di dalam Map
    'email': test@gmail.com', //email tipe data String| test@gmail.com tipe data dynamic
    'id': ''
  },
  {
    'email': test@gmail.com',
    'id': ''
  },
  ]
  */
  Stream<List<Map<String, dynamic>>> getUserStream() { //function utk menampilkan data list user di home page
    return firebaseFirestore.collection("Users").snapshots().map((item) {
      return item.docs.map((doc) {
        final user = doc.data();

        return user;
      }).toList();
    });
  }

  Future<void> mengirimPesan(String penerimaID, dynamic pesan)async{ //function utk mengirim pesan
    //mengambil info user saat ini
    final String userIDSaatIni = auth.currentUser!.uid;
    final String userEmailSaatIni = auth.currentUser!.email!;
    final Timestamp waktuIni = Timestamp.now();

    Pesan newPesan = Pesan( //class Pesan
      pengirimID: userIDSaatIni,
      pengirimEmail: userEmailSaatIni,
      penerimaID: penerimaID,
      pesan: pesan,
      waktuIni: waktuIni,
    );

    List<String> ids = [userIDSaatIni, penerimaID];
    ids.sort(); //ini utk chatroomid yg sama utk 2 orang
    String chatRoomID = ids.join('_');

    await firebaseFirestore.collection("chat_rooms").doc(chatRoomID).collection("messages").add(newPesan.toFireBase()); //relasi tabel chat_rooms dan tabel messages

  }

    Stream<QuerySnapshot> getPesan(String userID, dynamic otherUserID){
      List<String> ids = [userID, otherUserID];
      ids.sort();
      String chatRoomID = ids.join('_');
      return firebaseFirestore.collection("chat_rooms").doc(chatRoomID).collection("messages").orderBy("waktu_ini", descending: false).snapshots();
    }
}
