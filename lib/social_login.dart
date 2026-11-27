import 'package:flutter/material.dart';

class SocialLogin extends StatelessWidget {
  final VoidCallback onGooglePressed;
  final VoidCallback onFacebookPressed;
  final VoidCallback onXPressed;

  const SocialLogin({
    super.key,
    required this.onGooglePressed,
    required this.onFacebookPressed,
    required this.onXPressed,
  });

  Widget _buildSocialButton({
    required VoidCallback onTap,
    required Widget icon,
    required String label,
    Color textColor = Colors.black87,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey.shade300)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'ATAU',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey.shade300)),
          ],
        ),
        const SizedBox(height: 16),

        _buildSocialButton(
          onTap: onGooglePressed,
          icon: const Icon(
            Icons.g_mobiledata,
            color: Colors.redAccent,
            size: 28,
          ),
          label: 'Masuk dengan Google',
        ),
        const SizedBox(height: 10),

        _buildSocialButton(
          onTap: onFacebookPressed,
          icon: const Icon(
            Icons.facebook,
            color: Color(0xFF3797EF),
            size: 22,
          ),
          label: 'Masuk dengan Facebook',
          textColor: const Color(0xFF3797EF),
        ),
        const SizedBox(height: 10),

        _buildSocialButton(
          onTap: onXPressed,
          icon: const Text(
            '𝕏',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          label: 'Masuk dengan X',
        ),
      ],
    );
  }
}