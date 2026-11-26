import 'package:flutter/material.dart';

class PostHeader extends StatelessWidget {
  final String username;
  final String timeAgo;
  final String initial;
  final String? profileImage;
  final VoidCallback? onMenuTap;

  const PostHeader({
    super.key,
    required this.username,
    required this.timeAgo,
    required this.initial,
    this.profileImage,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      child: Row(
        children: [
          // Foto profil pengguna
          CircleAvatar(
            radius: 21,
            backgroundColor: Colors.blueGrey.shade100,
            backgroundImage: profileImage != null
                ? NetworkImage(profileImage!)
                : null,
            child: profileImage == null
                ? Text(
                    initial,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 17,
                    ),
                  )
                : null,
          ),

          const SizedBox(width: 10),

          // Nama dan waktu posting
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  timeAgo,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          // Tombol menu
          IconButton(
            onPressed: onMenuTap ?? () {},
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
