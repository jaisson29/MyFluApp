import 'package:flutter/material.dart';

class Window1 extends StatefulWidget {
  const Window1({super.key});

  @override
  State<Window1> createState() => _Window1State();
}

class _Window1State extends State<Window1> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.article_outlined,
            size: 130.0,
            color: Colors.purple,
          ),
          Text('Pestaña 1', style: TextStyle(fontSize: 50.0))
        ],
      ),
    );
  }
}
