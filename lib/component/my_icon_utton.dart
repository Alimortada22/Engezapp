import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  const MyIconButton({super.key,required this.onPressed,required this.iconcolor,required this.icon});
  final VoidCallback onPressed;
  final IconData icon;
  final Color iconcolor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
                  color: iconcolor,
                  onPressed: onPressed,
                  icon:  Icon(icon),
                  
                );
  }
}