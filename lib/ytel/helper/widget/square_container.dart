//return a square container which accepts color,icon,text and display it in column with a small colored sqare which conatins the icon
import 'package:flutter/material.dart';

class SquareContainer extends StatelessWidget {
  final Color? color;
  final IconData? icon;
  final String? value;
  final String? text;
  SquareContainer({this.color, this.icon, this.text, this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: <Widget>[

          Container(
            
            height: 30,
            width: 30,
            //rounded corners
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            
            child: Icon(
              icon,
              color: Colors.white,
              size: 17,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            value!,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          
          Text(
            text!,
            style: TextStyle(
              fontSize: 15,
              
              color: Colors.grey,
            ),
            
          )
        ],
      ),
    );
  }
}