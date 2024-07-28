import 'package:flutter/material.dart';
import 'Screens/splash_screen.dart';
import 'Screens/user_name.dart';
import 'Screens/description_page.dart';
import 'Screens/messages_list.dart';
import 'Screens/saved_contacts.dart';
import 'Screens/chat_page.dart';
import 'Screens/login.dart';
import 'Screens/phrase.dart';
import 'Screens/regenerate.dart';
import 'Screens/agreement_page.dart';
import 'Screens/key_phrase_page.dart';
import 'Screens/existing_user_page.dart';
import 'Screens/new_user_page.dart';
import 'Screens/generated_id_page.dart';
import 'Screens/welcome_page.dart';
import 'Screens/settings.dart';
import '../widgets/page_route.dart';
import 'Screens/discover_page.dart';

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
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => SplashScreen());
          case '/welcome':
            return SlideLeftRoute(page: WelcomeUserPage());
          case '/agreement':
            return SlideLeftRoute(page: AgreementPage());
          case '/login':
            return SlideLeftRoute(page: LoginPage()); 
          case '/phrase':
            return SlideLeftRoute(page: PhrasePage());
          case '/keyphrase':
            return SlideLeftRoute(page: KeyPhrasePage());
          case '/existinguser':
            return SlideLeftRoute(page: WelcomeBackPage());
          case '/username':
            return SlideLeftRoute(page: UserName());
          case '/description':
            return SlideLeftRoute(page: DescriptionPage());
          case '/regenerate':
            return SlideLeftRoute(page: GeneratePhrasePage());
          case '/newuser':
            return SlideLeftRoute(page: WelcomePage());
          case '/messages':
            return SlideLeftRoute(page: MessagesList());
          case '/contacts':
            return SlideLeftRoute(page: SavedContacts());
          case '/generatedid':
            return SlideLeftRoute(page: GeneratedIdPage());
<<<<<<< HEAD
          case '/settings':
            return SlideLeftRoute(page: SettingsPage());
=======
          case '/discover':
            return SlideLeftRoute(page: DiscoverPage());
>>>>>>> 3d8045cb826df8b394456e42bdc81ca883e21273
          default:
            return null;
        }
      },
    );
  }
}
