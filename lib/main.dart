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
import 'Screens/agreement_page.dart';
import 'Screens/existing_user_page.dart';
import 'Screens/new_user_page.dart';
import '../widgets/page_route.dart';

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
      // routes: {
      //   '/': (context) => SplashScreen(),
      //   '/agreement': (context) => AgreementPage(),
      //   '/login': (context) => LoginPage(),
      //   '/phrase':(context) => PhrasePage(),
      //   '/userid': (context) => UserId(),
      //   '/regenerate': (context) => GeneratePhrasePage(),
      //   '/username': (context) => UserName(),
      //   '/messages':(context) => MessagesList(),
      //   '/contacts': (context) => SavedContacts(),

      // },

      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => SplashScreen());
          case '/agreement':
            return SlideLeftRoute(page: AgreementPage());
          case '/login':
            return SlideLeftRoute(page: LoginPage());
          case '/existinguser':
            return SlideLeftRoute(page: WelcomeBackPage());
          case '/phrase':
            return SlideLeftRoute(page: PhrasePage());
          case '/userid':
            return SlideLeftRoute(page: UserId());
          case '/regenerate':
            return SlideLeftRoute(page: GeneratePhrasePage());
          case '/username':
            return SlideLeftRoute(page: UserName());
          case '/newuser':
            return SlideLeftRoute(page: WelcomePage());
          case '/messages':
            return SlideLeftRoute(page: MessagesList());
          case '/contacts':
            return SlideLeftRoute(page: SavedContacts());
          default:
            return null;
        }
      },
    );
  }
}
