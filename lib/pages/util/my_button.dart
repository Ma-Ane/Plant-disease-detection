import 'package:flutter/material.dart' ;

class MyButton extends StatelessWidget {

  final String text ;
  final VoidCallback onPressed ;

  const MyButton({
    super.key,
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top:20),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: onPressed,
        color: const Color.fromARGB(255, 192, 231, 225),
        height: 45,
        minWidth: 200,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
        ),
    );
  }
}