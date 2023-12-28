class AnswerCommonQuestionModel {
  bool? status;
  String? errNum;
  String? msg;
  Data? data;

  AnswerCommonQuestionModel({this.status, this.errNum, this.msg, this.data});

  AnswerCommonQuestionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {
  List<ListAnswers>? listAnswers;

  Data({this.listAnswers});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list_answers'] != null) {
      listAnswers = <ListAnswers>[];
      json['list_answers'].forEach((v) {
        listAnswers!.add(new ListAnswers.fromJson(v));
      });
    }
  }

}

class ListAnswers {
  String? answer;
  int? idAnswer;

  ListAnswers({this.answer, this.idAnswer});

  ListAnswers.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
    idAnswer = json['id_answer'];
  }
}
