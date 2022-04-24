import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  var titelbar = 'KidsPlay';
  var player =AudioCache();
  Map<String, bool> score = {};
  Map<String, Color> chioces = {
    '🍎': Colors.red,
    '🥎': Colors.yellow,
    '🧿': Colors.blue,
    '🐢': Colors.green,
    '🤍': Colors.white,
    '🍆': Colors.deepPurple,
    '🐀': Colors.grey,
    '🎀': Colors.pink,
    /* '🔥': Colors.orangeAccent,
    '🖤': Colors.black,*/
  };
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titelbar),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:<Widget> [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: chioces.keys.map((element) {
              return Expanded(
                  child: Draggable<String>(
                data: element,
                child: MovableItem(score[element] == true ? '✔' : element),
                feedback: MovableItem(element),
                childWhenDragging: MovableItem('🐉'),
              )
              );
            }).toList(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: chioces.keys.map((element) {
             return buildTarget(element);
            }).toList()
              ..shuffle(Random(index)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            index++;
            score.clear();
          });
        },
      ),
    );
  }

 Widget buildTarget(element) {
    return DragTarget<String>(
      builder: (context, inComing, rejected) {
        if (score[element] == true) {
          return Container(
            color: Colors.white,
            child: Text('Congratulations'),
            height: 80,
            width: 200,
            alignment: Alignment.center,

          );
        } else {
          return Container(
            color: chioces[element],
            height: 80,
            width: 200,

          );
        }
      },
      onWillAccept: (data) => data == element,
      onAccept: (data) {
        setState(() {
          score[element] = true;
         player.play('clap.wav');
        });
      },
      onLeave: (data) => {},
    );

  }
}


class MovableItem extends StatelessWidget {
  String emoji;
  MovableItem(this.emoji);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 100,
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        child: Text(
          emoji,
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
