import 'package:flutter/material.dart';

import '../utility/constants.dart';

class BigButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String text;

  const BigButton({
    super.key,
    required this.onPressed,
    required this.icon, required this.text,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: 280,
      height: 280,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.all(20),
            backgroundColor: Const.darkGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Const.lightGrey,
                width: 4,
                style: BorderStyle.solid,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 50.0, color: Colors.white),
              const SizedBox(width: 30),
              Text(text, style: Const.BigText)
            ],
          )
      ),
    );
  }
}