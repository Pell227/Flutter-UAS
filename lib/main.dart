
import 'package:flutter/material.dart';
import 'widgets/posts/create_post_box.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Facebook Preview',
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: const Color(0xFFF0F2F5),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1877F2),
        ),
      ),
      home: const CreatePostPreview(),
    );
  }
}

class CreatePostPreview extends StatelessWidget {
  const CreatePostPreview({super.key});

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),

      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        title: const Text(
          'Facebook',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            CreatePostBox(
              userName: 'Azzarqy',

              onPost: (content) {
                _showMessage(
                  context,
                  'Post berhasil dibuat: $content',
                );
              },

              onPhotoTap: () {
                _showMessage(context, 'Photo clicked');
              },

              onVideoTap: () {
                _showMessage(context, 'Live video clicked');
              },

              onFeelingTap: () {
                _showMessage(context, 'Feeling clicked');
              },
            ),
          ],
        ),
      ),
    );
  }
}
