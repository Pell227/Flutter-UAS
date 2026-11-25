import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'storyup.dart';

class Storybar extends StatefulWidget {
  const Storybar({super.key});

  @override
  State<Storybar> createState() => _StorybarState();
}

class _StorybarState extends State<Storybar> {
  final ImagePicker _picker = ImagePicker();

  final List<Map<String, dynamic>> stories = [
    {
      'name': 'Your Story',
      'initial': 'W',
      'isMe': true,
      'isViewed': false,
      'items': [
        {'text': 'Welcome to my story!', 'color': Color(0xFF34495E)},
        {'text': 'Hello everyone!', 'color': Color(0xFF833AB4)},
      ],
    },
    {
      'name': 'Felisia',
      'initial': 'F',
      'isMe': false,
      'isViewed': false,
      'items': [
        {'text': 'Hello!', 'color': Color(0xFF833AB4)},
        {'text': 'Have a nice day!', 'color': Color(0xFFE1306C)},
        {'text': 'See you!', 'color': Color(0xFF405DE6)},
      ],
    },
    {
      'name': 'Yael',
      'initial': 'Y',
      'isMe': false,
      'isViewed': false,
      'items': [
        {'text': 'What a day!', 'color': Color(0xFF2196F3)},
        {'text': 'Keep going!', 'color': Color(0xFF009688)},
      ],
    },
    {
      'name': 'Azzarqy',
      'initial': 'A',
      'isMe': false,
      'isViewed': false,
      'items': [
        {'text': 'Good morning!', 'color': Color(0xFFFF9800)},
      ],
    },
    {
      'name': 'William',
      'initial': 'W',
      'isMe': false,
      'isViewed': false,
      'items': [
        {'text': 'Enjoy your day!', 'color': Color(0xFF673AB7)},
      ],
    },
    {
      'name': 'Windriew',
      'initial': 'W',
      'isMe': false,
      'isViewed': false,
      'items': [
        {'text': 'Stay positive!', 'color': Color(0xFFE91E63)},
      ],
    },
    {
      'name': 'Daniel',
      'initial': 'D',
      'isMe': false,
      'isViewed': false,
      'items': [
        {'text': 'Hello friends!', 'color': Color(0xFF009688)},
      ],
    },
  ];

  // Memilih foto dari galeri HP.
  Future<void> pickStoryImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image == null || !mounted) return;

      setState(() {
        stories[0]['items'].add({
          'type': 'image',
          'imagePath': image.path,
        });
      });

      // Langsung membuka Story setelah foto dipilih.
      await openStory(sortedStories, 0);
    } catch (e) {
      debugPrint('Gagal memilih foto: $e');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal memilih foto dari galeri.'),
        ),
      );
    }
  }

  // Mengurutkan Story yang belum dilihat ke depan.
  List<Map<String, dynamic>> get sortedStories {
    final result = List<Map<String, dynamic>>.from(stories);

    result.sort((a, b) {
      if (a['isMe'] == true) return -1;
      if (b['isMe'] == true) return 1;

      final aViewed = a['isViewed'] == true;
      final bViewed = b['isViewed'] == true;

      if (aViewed == bViewed) return 0;

      return aViewed ? 1 : -1;
    });

    return result;
  }

  // Membuka halaman Story.
  Future<void> openStory(
    List<Map<String, dynamic>> displayedStories,
    int index,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Storyup(
          stories: displayedStories,
          initialIndex: index,
        ),
      ),
    );

    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final displayedStories = sortedStories;

    return SizedBox(
      height: 112,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        itemCount: displayedStories.length,
        itemBuilder: (context, index) {
          final story = displayedStories[index];

          final isMe = story['isMe'] as bool;
          final isViewed = story['isViewed'] as bool;

          return GestureDetector(
            onTap: () {
              if (isMe) {
                pickStoryImage();
              } else {
                openStory(displayedStories, index);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 66,
                        height: 66,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: !isMe && !isViewed
                              ? const LinearGradient(
                                  colors: [
                                    Color(0xFFFFB800),
                                    Color(0xFFFF3040),
                                    Color(0xFFC13584),
                                    Color(0xFF833AB4),
                                  ],
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                )
                              : null,
                          border: isMe || isViewed
                              ? Border.all(
                                  color: Colors.grey.shade400,
                                  width: 1.5,
                                )
                              : null,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.blueGrey.shade100,
                            child: Text(
                              story['initial'] as String,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Tombol tambah Story.
                      if (isMe)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 23,
                            height: 23,
                            decoration: BoxDecoration(
                              color: const Color(0xFF3797EF),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 17,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: 72,
                    child: Text(
                      story['name'] as String,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        color: isViewed ? Colors.grey : Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
