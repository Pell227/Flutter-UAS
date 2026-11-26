
import 'package:flutter/material.dart';
import 'post_card.dart';

class FeedList extends StatelessWidget {
  const FeedList({super.key});

  // Data dummy postingan
  final List<Map<String, dynamic>> posts = const [
    {
      'username': 'Windriew',
      'initial': 'W',
      'timeAgo': '2 hours ago',
      'postImage':
          'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=800',
      'caption': 'Pemandangan hari ini bagus banget!',
      'likes': 120,
      'comments': 15,
    },
    {
      'username': 'Felisia',
      'initial': 'F',
      'timeAgo': '3 hours ago',
      'postImage':
          'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?w=800',
      'caption': 'Enjoying my weekend!',
      'likes': 85,
      'comments': 12,
    },
    {
      'username': 'Yael',
      'initial': 'Y',
      'timeAgo': '5 hours ago',
      'postImage':
          'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=800',
      'caption': 'Nature always makes me happy.',
      'likes': 210,
      'comments': 24,
    },
    {
      'username': 'Azzarqy',
      'initial': 'A',
      'timeAgo': '1 day ago',
      'postImage':
          'https://images.unsplash.com/photo-1470252649378-9c29740c9fa8?w=800',
      'caption': 'Beautiful morning!',
      'likes': 95,
      'comments': 8,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];

        return PostCard(
          username: post['username'],
          initial: post['initial'],
          timeAgo: post['timeAgo'],
          postImage: post['postImage'],
          caption: post['caption'],
          likes: post['likes'],
          comments: post['comments'],
        );
      },
    );
  }
}
