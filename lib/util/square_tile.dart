import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final image;
  final void Function()? onTap;
  const SquareTile({
    super.key,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(18),
        ),
        child: Image.asset(image, height: 45),
      ),
    );
  }
}
