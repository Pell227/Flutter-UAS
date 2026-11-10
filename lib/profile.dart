import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD1E3E1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 160,
                  width: double.infinity,
                  color: Colors.blueGrey,
                ),
                Positioned(
                  left: 20,
                  bottom: -45,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: const CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(
                        'https://static.wikia.nocookie.net/projectsekai/images/b/bb/At_The_End_Of_Darkness_T.png/revision/latest/scale-to-width-down/1000?cb=20261031030025',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 55),
          ],
        ),
      ),
    );
  }
}
