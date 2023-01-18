import 'package:flutter/material.dart';

class ContentBox extends StatelessWidget {
  final Widget child;

  const ContentBox({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 222, 222, 222),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 100, 100, 100),
            offset: Offset(1, 1),
            spreadRadius: 0.5,
            blurRadius: 3,
          )
        ],
      ),
      // margin: EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      child: child,
    );
  }
}
