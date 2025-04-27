import 'package:chatapp/components/my_drawer.dart';
import 'package:chatapp/components/user_list.dart';
import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat App By Kwanzzx'), backgroundColor: Color(0xFFFF7643)),
      drawer: MyDrawer(), //memaggil class drawer di components
      body: buildUserList(), //memanggil function buildUserList()
    );
  }

  Widget buildUserList(){
    return StreamBuilder(
      stream: chatService.getUserStream(), //memanggil class ChatService dan function getUserStream
      builder: (context, snapshot){ //snapshot sama seperti index Grid/ListBuilder
        if(snapshot.hasError){ //jika datanya snapshot error
          return Text("Error");
        }

        if(snapshot.connectionState == ConnectionState.waiting){ //jika snapshot sedang menghubungkan
          return Center(child: CircularProgressIndicator(),);
        }

        return ListView( //menampilkan data user berupa list
          children: snapshot.data!.map<Widget>((userData) => buildUserListItem(userData, context)).toList(),
        );
      }
    );
  }

  Widget buildUserListItem(Map<String, dynamic> userData, BuildContext context){
    if(userData["email"] != authService.getUser()!.email){ //tidak akan menampilkan user yg menggunakan email yg sedang login
        return UserList( //memanggil class UserList di components
          //text tipe String| userData["email"] tipe dynamic isi email contoh test@gmail.com
          text: userData["email"], //menampilkan email user
          onTap: (){ //diklik mengarahkan ke ChatPage
            Navigator.push(
              context, MaterialPageRoute(builder: (context) => ChatPage(
                penerimaID: userData["uid"],
                penerimaEmail: userData["email"])));
        },
      );
    }else{
      return Container();
    }
  }
}
