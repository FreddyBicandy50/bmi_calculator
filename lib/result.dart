import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});
  
  @override
  State<ResultPage> createState() => _ResultState();
}

class _ResultState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("HELLO WORLD"),
    );
  }
}
