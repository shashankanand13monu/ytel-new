//material ui

import 'package:flutter/material.dart';

class Kuchbhi extends StatelessWidget {
  const Kuchbhi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kuch bhi'),
      ),
      body: Container(
        // a form with a text field named 'name','email','password' and a button
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),


    );
  }
}