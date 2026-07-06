import 'package:flutter/material.dart';

void showAnimatedDialog(BuildContext context, String title, String message, {VoidCallback? onOk}) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Container();
    },
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    barrierLabel: '',
    transitionBuilder: (context, a1, a2, child) {
      return Transform.scale(
        scale: a1.value,
        child: Opacity(
          opacity: a1.value,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onOk != null) onOk();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}
