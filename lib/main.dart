import 'package:capricon_story_app/view/story_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");  // Load the .env file
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Story Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StoryPage(),
    );
  }
}

// class MainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Story Generator')),
//       body: Row(
//         children: [
//           // Sidebar for previous chats
//           StoryApp(),
//           // Main Story Page
//           Expanded(child: StoryPage()),
//         ],
//       ),
//     );
//   }
//}
