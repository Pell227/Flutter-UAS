
import 'package:flutter/material.dart';
import 'storyup.dart';

class Storybar extends StatelessWidget {
  const Storybar({super.key});

  final List<Map<String, dynamic>> stories = const [
    {
      'name': 'Your Story',
      'initial': 'W',
      'isMe': true,
    },
    {
      'name': 'Amanda',
      'initial': 'A',
      'isMe': false,
    },
    {
      'name': 'Kevin',
      'initial': 'K',
      'isMe': false,
    },
    {
      'name': 'Jessica',
      'initial': 'J',
      'isMe': false,
    },
    {
      'name': 'Michael',
      'initial': 'M',
      'isMe': false,
    },
    {
      'name': 'Sarah',
      'initial': 'S',
      'isMe': false,
    },
    {
      'name': 'Daniel',
      'initial': 'D',
      'isMe': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 112,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          final isMe = story['isMe'] as bool;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Storyup(
                    stories: stories,
                    initialIndex: index,
                  ),
                ),
              );
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
                          gradient: isMe
                              ? null
                              : const LinearGradient(
                                  colors: [
                                    Color(0xFFFFB800),
                                    Color(0xFFFF3040),
                                    Color(0xFFC13584),
                                    Color(0xFF833AB4),
                                  ],
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                ),
                          border: isMe
                              ? Border.all(
                                  color: Colors.grey.shade300,
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
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black87,
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
