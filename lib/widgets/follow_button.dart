import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final Function()? function;
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final Color textColor;
  const FollowButton({
    Key? key,
    this.function,
    required this.backgroundColor,
    required this.borderColor,
    required this.text,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: TextButton(
          onPressed: function,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent.withOpacity(0.5),

              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: Text(text,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                )),
            width: 200,
            height: 25,
          )),
    );
  }
}
