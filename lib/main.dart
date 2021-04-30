import 'package:flutter/material.dart';
import 'package:quizz_app/question_bank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(MyApp());
}

QuestionBank _questionBank = QuestionBank();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text("Quizler"),
        // ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: QuizPage(),
          ),
        ),
        backgroundColor: Colors.grey.shade900,
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    setState(() {
      if (userPickedAnswer == _questionBank.getAnswer()) {
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        scoreKeeper.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
      _questionBank.getNextQuestion();
      if (_questionBank.resetQuestion()) {
        Alert(
          context: context,
          title: "Finished!",
          desc: "You have reached the end of the quiz",
          buttons: [
            DialogButton(
              child: Text(
                "CANCEL",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: ()
              {
                scoreKeeper = [];
                Navigator.pop(context);
              },
                width: 120
            )
          ],
        ).show();

        scoreKeeper = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  _questionBank.getQuestionText(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FlatButton(
            onPressed: () {
              checkAnswer(true);
            },
            child: Text(
              "True",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            color: Colors.green,
          ),
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FlatButton(
            onPressed: () {
              checkAnswer(false);
            },
            child: Text(
              "False",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            color: Colors.red,
          ),
        )),
        Expanded(
          child: Row(
            children: scoreKeeper,
          ),
        )
      ],
    );
  }
}
