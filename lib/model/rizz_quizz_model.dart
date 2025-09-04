class RizzQuizzModel {
  String? message;
  bool? status;
  Data? data;

  RizzQuizzModel({this.message, this.status, this.data});

  RizzQuizzModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Categories? categories;

  Data({this.categories});

  Data.fromJson(Map<String, dynamic> json) {
    categories = json['categories'] != null
        ? new Categories.fromJson(json['categories'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.categories != null) {
      data['categories'] = this.categories!.toJson();
    }
    return data;
  }
}

class Categories {
  FlexFactorScore? flexFactorScore;
  FlexFactorScore? dripCheckScore;
  FlexFactorScore? juiceLevelScore;
  FlexFactorScore? pickupGameScore;
  FlexFactorScore? goalDiggerScore;

  Categories(
      {this.flexFactorScore,
        this.dripCheckScore,
        this.juiceLevelScore,
        this.pickupGameScore,
        this.goalDiggerScore});

  Categories.fromJson(Map<String, dynamic> json) {
    flexFactorScore = json['flex_factor_score'] != null
        ? new FlexFactorScore.fromJson(json['flex_factor_score'])
        : null;
    dripCheckScore = json['drip_check_score'] != null
        ? new FlexFactorScore.fromJson(json['drip_check_score'])
        : null;
    juiceLevelScore = json['juice_level_score'] != null
        ? new FlexFactorScore.fromJson(json['juice_level_score'])
        : null;
    pickupGameScore = json['pickup_game_score'] != null
        ? new FlexFactorScore.fromJson(json['pickup_game_score'])
        : null;
    goalDiggerScore = json['goal_digger_score'] != null
        ? new FlexFactorScore.fromJson(json['goal_digger_score'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.flexFactorScore != null) {
      data['flex_factor_score'] = this.flexFactorScore!.toJson();
    }
    if (this.dripCheckScore != null) {
      data['drip_check_score'] = this.dripCheckScore!.toJson();
    }
    if (this.juiceLevelScore != null) {
      data['juice_level_score'] = this.juiceLevelScore!.toJson();
    }
    if (this.pickupGameScore != null) {
      data['pickup_game_score'] = this.pickupGameScore!.toJson();
    }
    if (this.goalDiggerScore != null) {
      data['goal_digger_score'] = this.goalDiggerScore!.toJson();
    }
    return data;
  }
}

class FlexFactorScore {
  String? catText;
  String? timeKey;
  String? scoreKey;
  String? question;
  List<Options>? options;

  FlexFactorScore(
      {this.catText, this.timeKey, this.scoreKey, this.question, this.options});

  FlexFactorScore.fromJson(Map<String, dynamic> json) {
    catText = json['cat_text'];
    timeKey = json['time_key'];
    scoreKey = json['score_key'];
    question = json['question'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cat_text'] = this.catText;
    data['time_key'] = this.timeKey;
    data['score_key'] = this.scoreKey;
    data['question'] = this.question;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  String? text;
  int? weight;

  Options({this.text, this.weight});

  Options.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = this.text;
    data['weight'] = this.weight;
    return data;
  }
}
