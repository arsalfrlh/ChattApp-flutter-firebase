import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String pesan;
  final bool userSaatIni;

  const ChatBubble({required this.pesan, required this.userSaatIni});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: userSaatIni
         ? Colors.orange
         : Colors.grey.shade500,
         borderRadius: BorderRadius.circular(12)
      ),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
      child: Text(pesan, style: TextStyle(color: Colors.white),),
    );
  }
}
