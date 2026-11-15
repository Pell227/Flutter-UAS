  import 'package:flutter/material.dart';

  class CreatePostBox extends StatefulWidget {
    final String userName;
    final String? avatarUrl;
    final ValueChanged<String> onPost;

    final VoidCallback? onPhotoTap;
    final VoidCallback? onVideoTap;
    final VoidCallback? onFeelingTap;

    const CreatePostBox({
      super.key,
      required this.userName,
      required this.onPost,
      this.avatarUrl,
      this.onPhotoTap,
      this.onVideoTap,
      this.onFeelingTap,
    });

    @override
    State<CreatePostBox> createState() => _CreatePostBoxState();
  }

  class _CreatePostBoxState extends State<CreatePostBox> {
    final TextEditingController _postController = TextEditingController();

    bool get _hasText => _postController.text.trim().isNotEmpty;

    @override
    void dispose() {
      _postController.dispose();
      super.dispose();
    }

    void _submitPost() {
      final content = _postController.text.trim();

      if (content.isEmpty) return;

      widget.onPost(content);

      _postController.clear();

      setState(() {});
    }

    @override
    Widget build(BuildContext context) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        color: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User profile and text input
              Row(
                children: [
                  CircleAvatar(
                    radius: 21,
                    backgroundColor: const Color(0xFF1877F2),
                    backgroundImage: widget.avatarUrl != null
                        ? NetworkImage(widget.avatarUrl!)
                        : null,
                    child: widget.avatarUrl == null
                        ? Text(
                            widget.userName.isNotEmpty
                                ? widget.userName[0].toUpperCase()
                                : 'U',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 10),

                  Expanded(
                    child: TextField(
                      controller: _postController,
                      minLines: 1,
                      maxLines: 4,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: "What's on your mind, ${widget.userName}?",
                        hintStyle: const TextStyle(
                          color: Color(0xFF65676B),
                          fontSize: 14,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF0F2F5),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 8),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActionButton(
                    icon: Icons.videocam,
                    label: 'Live video',
                    color: const Color(0xFFF3425F),
                    onTap: widget.onVideoTap,
                  ),

                  _buildActionButton(
                    icon: Icons.photo_library,
                    label: 'Photo',
                    color: const Color(0xFF45BD62),
                    onTap: widget.onPhotoTap,
                  ),

                  _buildActionButton(
                    icon: Icons.emoji_emotions,
                    label: 'Feeling',
                    color: const Color(0xFFF7B928),
                    onTap: widget.onFeelingTap,
                  ),
                ],
              ),

              // Post button appears when user types
              if (_hasText) ...[
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitPost,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1877F2),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'Post',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }

    Widget _buildActionButton({
      required IconData icon,
      required String label,
      required Color color,
      VoidCallback? onTap,
    }) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          child: Row(
            children: [
              Icon(icon, color: color, size: 21),
              const SizedBox(width: 5),
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF65676B),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
