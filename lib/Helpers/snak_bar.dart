import 'package:flutter/material.dart';

mixin ShowSnackBar {
  showSnackBar(BuildContext context,
      {bool isError = false, required String text}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: isError == false ? Colors.green : Colors.red,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 800),
      margin: const EdgeInsets.all(12),
    ));
  }
}
