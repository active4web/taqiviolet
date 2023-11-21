class CommonQuestionModel {
  bool? status;
  String? errNum;
  String? msg;
  Data? data;

  CommonQuestionModel({this.status, this.errNum, this.msg, this.data});

  CommonQuestionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<QuestionsList>? questionsList;

  Data({this.questionsList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['questions_list'] != null) {
      questionsList = <QuestionsList>[];
      json['questions_list'].forEach((v) {
        questionsList!.add(new QuestionsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questionsList != null) {
      data['questions_list'] =
          this.questionsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionsList {
  String? name;
  int? id;
  bool? type;
  List<ListAnswers>? listAnswers;

  QuestionsList({this.name, this.id, this.type, this.listAnswers});

  QuestionsList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    type = json['type'];
    if (json['list_answers'] != null) {
      listAnswers = <ListAnswers>[];
      json['list_answers'].forEach((v) {
        listAnswers!.add(new ListAnswers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['type'] = this.type;
    if (this.listAnswers != null) {
      data['list_answers'] = this.listAnswers!.map((v) => v.toJson()).toList();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer'] = this.answer;
    data['id_answer'] = this.idAnswer;
    return data;
  }
}
