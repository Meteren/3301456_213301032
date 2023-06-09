
import 'package:flutter/material.dart';
import '../repositories/questions_repo.dart';

class QuestionPoint extends StatefulWidget {
  const QuestionPoint({
    super.key, required this.questions, required this.point,
  });
  final int point;
  final QuizBrain questions;
  @override
  State<QuestionPoint> createState() => _QuestionPointState();
}

class _QuestionPointState extends State<QuestionPoint> {
  late int active;
  late int pointTaken;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    active = 0;
    pointTaken = 0;
    widget.questions.RandomQuestion(widget.questions);
  }
  @override
  Widget build(BuildContext context) {
    bool ctrl = false;
    return WillPopScope(
      onWillPop: ()async{
        if (ctrl == false) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Center(child: Text("Use only on screen buttons to go back.")),
                duration: Duration(seconds: 2),
              )
          );
          ctrl = true;
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(400),
            ),
          ),
          title: const Center(child: Text('Question')),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                  width: 300,
                  height: 603.4,
                  child: Stack(
                    children: [
                      Positioned(
                        height: 50,
                        top: 130,
                        right: 0,
                        left:0,
                        child: Center(
                          child: Text(
                            widget.questions.getQuestionText(widget.questions),
                            style: const TextStyle(shadows: [
                              Shadow(color: Colors.green,
                                offset: Offset(2.0,2.0),
                                blurRadius: 10,
                              ),
                            ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 220,
                        right: 120,
                        child: ElevatedButton(
                          onPressed: active == 0 ? (){
                            setState(() {
                              active++;
                            });
                            if(widget.questions.getCorrectAnswer(widget.questions) == true) {
                              pointTaken +=widget.point;
                              showDialog<String>(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) =>
                                    AlertDialog(
                                      title: const Text('Congrats!!!'),
                                      content: Text(
                                          'Your answer is correct.\n'
                                              'You got ${widget.point} points.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            widget.questions.removeQuestion(widget.questions);
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                              );
                            }
                            else {
                              showDialog<String>(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) =>
                                    AlertDialog(
                                      title: const Text('Sorry'),
                                      content: const Text(
                                          'Your answer is not correct.\n'
                                              'You got 0 point.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            widget.questions.removeQuestion(
                                                widget.questions);
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                              );
                            }
                          }:null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // Background color
                          ),
                          child: const Text('True'),
                        ),
                      ),
                      Positioned(
                        top: 280,
                        right: 119,
                        child: ElevatedButton(
                          onPressed: active == 0 ? (){
                            setState(() {
                              active++;
                            });
                            if(widget.questions.getCorrectAnswer(widget.questions) == false) {
                              pointTaken +=widget.point;
                              showDialog<String>(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) =>
                                    AlertDialog(
                                      title: const Text('Congrats!!!'),
                                      content: Text(
                                          'Your answer is correct.\n'
                                              'You got ${widget.point} points.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            widget.questions.removeQuestion(widget.questions);
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                              );
                            }
                            else {
                              showDialog<String>(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) =>
                                    AlertDialog(
                                      title: const Text('Sorry'),
                                      content: const Text(
                                          'Your answer is not correct.\n'
                                              'You got 0 point.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            widget.questions.removeQuestion(
                                                widget.questions);
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                              );
                            }
                          }:null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red, // Background color
                          ),
                          child: const Text('False'),
                        ),
                      ),
                      Positioned(
                        bottom: 90,
                        right: 93,
                        child: ElevatedButton(
                          onPressed: active == 1 ? (){
                            Navigator.of(context).pop<int>(pointTaken);
                          }:null,

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // Background color
                          ),
                          child: const Text('End Question'),
                        ),
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
