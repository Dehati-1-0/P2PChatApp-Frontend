import 'package:flutter/material.dart';
import 'Screens/splash_screen.dart';
import 'Screens/user_name.dart';
import 'Screens/description_page.dart';
import 'Screens/messages_list.dart';
import 'Screens/saved_contacts.dart';
import 'Screens/chat_page.dart';
import 'Screens/user_profile_page.dart';
import 'Screens/login.dart';
import 'Screens/phrase.dart';
import 'Screens/regenerate.dart';
import 'Screens/agreement_page.dart';
import 'Screens/key_phrase_page.dart';
import 'Screens/existing_user_page.dart';
import 'Screens/new_user_page.dart';
import 'Screens/generated_phrase_page.dart';
import 'Screens/welcome_page.dart';
import 'Screens/settings.dart';
import 'Screens/generated_id_page.dart';
import 'Screens/add_new_contact.dart';
import '../widgets/page_route.dart';
import 'responsive_utils.dart';
import 'Screens/empty_chats_page.dart';
import 'Screens/qrcode_generate_page.dart';
import 'Screens/scan_page.dart';
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
          case '/generatedphrase':
            return SlideLeftRoute(page: GeneratedPhrasePage());
          case '/settings':
            return SlideLeftRoute(page: SettingsPage());
          case '/generatedid':
            return SlideLeftRoute(page: GeneratedIdPage());
          case '/newcontact':
            return SlideLeftRoute(page: AddNewContactPage());
          case '/discover':
            return SlideLeftRoute(page: DiscoverPage());
          case '/qrcode':
            return SlideLeftRoute(page: QRCodeGeneratePage());
          case '/scan':
            return SlideLeftRoute(page: ScanPage());
          case '/userprofile':
            final args = settings.arguments as Map<String, dynamic>;
            return SlideLeftRoute(
                page: UserProfilePage(
              userName: args['userName'], 
              userAvatar: args['userAvatar'],
            ));

          default:
            return null;
        }
      },
    );
  }
}
