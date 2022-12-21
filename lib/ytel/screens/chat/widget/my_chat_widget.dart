import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../model/message.dart';

class MyChatWidget extends StatefulWidget {
  final String isMe;
  final AsyncSnapshot<dynamic> snapshot;
  final int index;

  const MyChatWidget({
    super.key,
    required this.isMe,
    required this.snapshot,
    required this.index,
  });

  @override
  State<MyChatWidget> createState() => _MyChatWidgetState(isMe, index,snapshot);
}

class _MyChatWidgetState extends State<MyChatWidget> {
  final String isMe;
  final AsyncSnapshot<dynamic> snapshot;
  final int index;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  AudioPlayer audioPlayer = AudioPlayer();

  _MyChatWidgetState(this.isMe, this.index,this.snapshot);

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(17);
    final borderRadius = BorderRadius.all(radius);
    final type= widget.snapshot.data!["payload"][widget.index]["event"]["type"].toString();
    


    return Row(
      mainAxisAlignment:
          widget.isMe == "in" ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: Container(
            padding: EdgeInsets.all(16),
            constraints: BoxConstraints(maxWidth: 400),
        
            decoration: BoxDecoration(
              color: widget.isMe == "in"
                  ? Color.fromARGB(255, 33, 133, 247)
                  : Color.fromARGB(255, 190, 232, 251),
              borderRadius: widget.isMe == "in"
                  ? BorderRadius.only(
                      topLeft: radius,
                      topRight: radius,
                      bottomLeft: radius,
                    )
                  : BorderRadius.only(
                      topLeft: radius,
                      topRight: radius,
                      bottomRight: radius,
                    ),
            ),
            child: type=="message"?buildMessage():type=="call"?buildCall():playRecording()
          ),
        ),
      ],
    );
  }

  Widget buildMessage() => Column(
        crossAxisAlignment:
            widget.isMe == "in" ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.snapshot.data!["payload"][widget.index]["event"]["body"]
                .toString(),
            style: TextStyle(color: widget.isMe == "in" ? Colors.white : Colors.black),
            textAlign: widget.isMe == "in" ? TextAlign.end : TextAlign.start,
          ),
        ],
      );

  Widget buildCall() => Column(
        crossAxisAlignment:
            widget.isMe == "in" ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            (widget.isMe=="in"? "Outbound Call : 00:00:":"Inbound Call : 00:00:")+ widget.snapshot.data!["payload"][widget.index]["event"]["duration"]
                .toString(),
            style: TextStyle(color: widget.isMe == "in" ? Colors.white : Colors.black),
            textAlign: widget.isMe == "in" ? TextAlign.end : TextAlign.start,
          ),
        ],
      );

  Widget playRecording() => Column(
        crossAxisAlignment:
            widget.isMe == "in" ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text("Play Recording",
                  style: TextStyle(color: widget.isMe == "in" ? Colors.white : Colors.black),
                  textAlign: widget.isMe == "in" ? TextAlign.end : TextAlign.start,
              ),
            ),
          ],
        ),

        ],

      );
}
