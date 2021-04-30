class Question{
  String _question;
  bool _questionAnswer;

  Question({String q, bool a}){
    _questionAnswer = a;
    _question = q;
}

  String get question => _question;
  bool get questionAnswer => _questionAnswer;
}