import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  const LoginButton({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}
