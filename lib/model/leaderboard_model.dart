class LeaderBoardModel {
  String? message;
  bool? status;
  LeaderBoardData? data;

  LeaderBoardModel({this.message, this.status, this.data});

  LeaderBoardModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? LeaderBoardData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class LeaderBoardData {
  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;
  List<LeaderBoardItems>? items;
  int? count;

  LeaderBoardData({this.total, this.perPage, this.currentPage, this.lastPage, this.items, this.count});

  LeaderBoardData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['perPage'];
    currentPage = json['currentPage'];
    lastPage = json['lastPage'];
    if (json['items'] != null) {
      items = <LeaderBoardItems>[];
      json['items'].forEach((v) {
        items!.add(LeaderBoardItems.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['perPage'] = perPage;
    data['currentPage'] = currentPage;
    data['lastPage'] = lastPage;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    return data;
  }
}

class LeaderBoardItems {
  int? rank;
  String? achievedAt;
  int? id;
  String? name;
  String? deviceId;
  String? profileImage;
  int? overallScore;
  int? badgeCount;

  LeaderBoardItems(
      {this.rank,
      this.achievedAt,
      this.id,
      this.name,
      this.deviceId,
      this.profileImage,
      this.overallScore,
      this.badgeCount});

  LeaderBoardItems.fromJson(Map<String, dynamic> json) {
    rank = json['rank'];
    achievedAt = json['achieved_at'];
    id = json['id'];
    name = json['name'];
    deviceId = json['device_id'];
    profileImage = json['profile_image'];
    overallScore = json['overall_score'];
    badgeCount = json['badge_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rank'] = rank;
    data['achieved_at'] = achievedAt;
    data['id'] = id;
    data['name'] = name;
    data['device_id'] = deviceId;
    data['profile_image'] = profileImage;
    data['overall_score'] = overallScore;
    data['badge_count'] = badgeCount;
    return data;
  }
}
