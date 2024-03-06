import 'package:flutter/material.dart';

void showCustomSnackbar(
    BuildContext context, String title, String message, String type,
    {Duration duration = const Duration(milliseconds: 2500)}) {
  Color backgroundColor = _getBackgroundColor(type);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            _getIcon(type),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      dismissDirection: DismissDirection.up,
    ),
  );
}

Color _getBackgroundColor(String type) {
  switch (type) {
    case 'success':
      return Colors.green;
    case 'error':
      return Colors.red;
    default:
      return Colors.red;
  }
}

Icon _getIcon(String type) {
  switch (type) {
    case 'success':
      return const Icon(Icons.check, color: Colors.white);
    case 'error':
      return const Icon(Icons.error, color: Colors.white);
    default:
      return const Icon(Icons.warning, color: Colors.white);
  }
}
