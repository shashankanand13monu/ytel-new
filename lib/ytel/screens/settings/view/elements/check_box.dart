import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:ytel/ytel/helper/constants/colors.dart';

class check_box extends StatefulWidget {
  check_box({Key? key, required this.text}) : super(key: key);
final text ;
  @override
  State<check_box> createState() => _check_boxState();
}

class _check_boxState extends State<check_box> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("${widget.text}",style: TextStyle(fontSize: 18,color: ColorHelper.colors[9]),),
        Expanded(child: Align(
          alignment: Alignment.centerRight,
          child: ToggleSwitch(

            minWidth: 40.0,
            minHeight: 40.0,
            initialLabelIndex: 0,
            cornerRadius: 10.0,
            activeFgColor: ColorHelper.colors[8],
            inactiveBgColor: ColorHelper.colors[9],
            inactiveFgColor: ColorHelper.colors[8],
            totalSwitches: 2,
            icons: [
              FontAwesomeIcons.cancel,
              FontAwesomeIcons.check,
            ],

            iconSize: 30.0,
            activeBgColors: [[Colors.black45, Colors.black26], [Colors.green]],
            animate: true, // with just animate set to true, default curve = Curves.easeIn
            curve: Curves.bounceInOut, // animate must be set to true when using custom curve
            onToggle: (index) {
              print('switched to: $index');
            },
          ),
        ))
      ],
    );
  }
}
