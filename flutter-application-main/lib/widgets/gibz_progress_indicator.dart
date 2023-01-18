import 'package:flutter/material.dart';

class GibzProgressIndicator extends StatelessWidget {
  final String indicatorText;

  const GibzProgressIndicator({required this.indicatorText, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 31, 138, 205),
          ),
        ),
        Center(
          child: Text(
            indicatorText,
            style: const TextStyle(color: Colors.black54),
          ),
        ),
      ],
    );
  }
}
