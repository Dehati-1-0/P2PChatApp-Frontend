import 'package:flutter/material.dart';
import 'Screens/splash_screen.dart';
import 'Screens/user_id.dart';
import 'Screens/user_name.dart';
import 'Screens/messages_list.dart';
import 'Screens/saved_contacts.dart';
import 'Screens/chat_page.dart';
import 'Screens/login.dart';
import 'Screens/phrase.dart';
import 'Screens/regenerate.dart';
// import 'screens/contacts_page.dart';
// import 'screens/messages_page.dart';
// import 'screens/saved_contacts_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Dehati UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Lato',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),
        '/phrase':(context) => PhrasePage(),
        '/userid': (context) => UserId(),
        '/regenerate': (context) => GeneratePhrasePage(),
        '/username': (context) => UserName(),
        '/messages':(context) => MessagesList(),
        '/contacts': (context) => SavedContacts(),
        // '/chat': (context) => ChatPage(),
        // '/contacts': (context) => ContactsPage(),
        // '/messages': (context) => MessagesPage(),
        // '/saved_contacts': (context) => SavedContactsPage(),
      },
    );
  }
}
