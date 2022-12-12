import 'package:flutter/material.dart';

class UnderDevelopment extends StatelessWidget {
  const UnderDevelopment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Under Development', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,

      ),
      body: const Center(
        child: Text('Under Development'),
      ),
    );
  }
}