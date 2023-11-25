import 'package:flutter/material.dart';

class Window2 extends StatefulWidget {
  const Window2({super.key});
  @override
  State<Window2> createState() => _Window2State();
}

class _Window2State extends State<Window2> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.list,
            size: 130.0,
            color: Colors.orange,
          ),
          Text('Pestaña 2', style: TextStyle(fontSize: 50.0))
        ],
      ),
    );
  }
}