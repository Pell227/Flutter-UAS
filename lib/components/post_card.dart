
import 'package:flutter/material.dart';
import 'post_header.dart';

class PostCard extends StatelessWidget {
  final String username;
  final String initial;
  final String timeAgo;
  final String? profileImage;
  final String? postImage;
  final String caption;
  final int likes;
  final int comments;

  const PostCard({
    super.key,
    required this.username,
    required this.initial,
    required this.timeAgo,
    this.profileImage,
    this.postImage,
    required this.caption,
    this.likes = 0,
    this.comments = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header postingan
          PostHeader(
            username: username,
            timeAgo: timeAgo,
            initial: initial,
            profileImage: profileImage,
            onMenuTap: () {
              _showPostMenu(context);
            },
          ),

          // Foto postingan
          if (postImage != null)
            SizedBox(
              width: double.infinity,
              child: Image.network(
                postImage!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 250,
                    color: Colors.grey.shade200,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.broken_image_outlined,
                      size: 45,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            )
          else
            Container(
              width: double.infinity,
              height: 250,
              color: Colors.blueGrey.shade100,
              alignment: Alignment.center,
              child: const Icon(
                Icons.image_outlined,
                size: 55,
                color: Colors.white,
              ),
            ),

          // Tombol interaksi sementara
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border),
                  color: Colors.black,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.mode_comment_outlined),
                  color: Colors.black,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.send_outlined),
                  color: Colors.black,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmark_border),
                  color: Colors.black,
                ),
              ],
            ),
          ),

          // Jumlah like
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              '$likes likes',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),

          const SizedBox(height: 5),

          // Caption
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
                children: [
                  TextSpan(
                    text: '$username ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: caption),
                ],
              ),
            ),
          ),

          const SizedBox(height: 5),

          // Jumlah komentar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              'View all $comments comments',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ),

          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
        ],
      ),
    );
  }

  // Menu titik tiga
  void _showPostMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.link),
                title: const Text('Copy link'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.report_outlined),
                title: const Text('Report'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.close),
                title: const Text('Cancel'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
