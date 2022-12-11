// A Rectangular container with gradient colors and a row of icon, Title and Value with horizontal scroll which accepts icon , color, title and value
import 'package:flutter/material.dart';

class RectangleContainer extends StatelessWidget {
  final Color? color;
  final Color? iconColor;
  final IconData? icon;
  final String? title;
  final String? value;
  RectangleContainer({this.color, this.icon, this.title, this.value, this.iconColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width*0.95,
      decoration: BoxDecoration(
        
        color: color,
        borderRadius: BorderRadius.circular(15),
       
      ),
      child: Row(
        
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Container(
                height: 30,
                width: 30,
                //Rounded corners
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              SizedBox(
                width: 14,),
               Text(
            title!,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              //ios text font
              fontFamily: 'SF Pro Display',
            ),
          ),
            ],
          ),
         
          Text(
            value!,
            style: TextStyle(
              color: iconColor,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              
            ),
          ),
        ],
      ),
    );
  }
}


 