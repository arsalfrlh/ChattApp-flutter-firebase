import 'package:chatapp/components/chat_bubble.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String penerimaID;
  final String penerimaEmail;
  ChatPage({required this.penerimaID, required this.penerimaEmail});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();
  final pesanController = TextEditingController();

  void _mengirimPesan() async {
    if (pesanController.text.isNotEmpty) {
      await chatService.mengirimPesan(widget.penerimaID, pesanController.text);

      pesanController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.penerimaEmail),
        backgroundColor: Color(0xFFFF7643),
      ),
      body: Column(
        children: [
          //menampilkan pesan
          Expanded(
            child: buildPesanList(),
          ),

          //user input
          buildUserInput(),
        ],
      ),
    );
  }

  Widget buildPesanList() {
    String pengirimID = authService.getUser()!.uid;
    return StreamBuilder(
        stream: chatService.getPesan(widget.penerimaID, pengirimID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children:
                snapshot.data!.docs.map((doc) => buildPesanItem(doc)).toList(),
          );
        });
  }

  Widget buildPesanItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool userSaatIni = data["pengirim_id"] == authService.getUser()!.uid;
    var alignment = userSaatIni 
    ? Alignment.centerRight 
    : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: userSaatIni 
        ? CrossAxisAlignment.end 
        : CrossAxisAlignment.start,
        children: [
          ChatBubble(pesan: data["pesan"], userSaatIni: userSaatIni),
        ],
      ));
  }

  Widget buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          Expanded(
              child: TextFormField(
              controller: pesanController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  hintText: "Kirim sebuah pesan",
                  labelText: "Pesan",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: const TextStyle(color: Color(0xFF757575)),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF757575)),
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF757575)),
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF757575)),
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ).copyWith(
                        borderSide: const BorderSide(color: Color(0xFFFF7643)))),
            ),),
      
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFFF7643),
              shape: BoxShape.circle),
              margin: EdgeInsets.only(left: 10, right: 10),
            child: IconButton(
              onPressed: _mengirimPesan, 
              icon: Icon(Icons.arrow_upward, color: Colors.white,)))
        ],
      ),
    );
  }
}
