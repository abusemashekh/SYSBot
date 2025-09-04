class UserModel {
  final String? message;
  final bool? status;
  final UserData? data;

  UserModel({
    this.message,
    this.status,
    this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      message: json['message'] ?? "",
      status: json['status'] ?? false,
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "status": status,
      "data": data?.toJson(),
    };
  }
}

class UserData {
  final int id;
  final String? deviceId;
  final String? profileImage;
  final String? name;
  final int badgeCount;
  final String? email;
  final String referralCode;
  final dynamic referredBy;
  final dynamic promoCode;
  final dynamic referredDone;
  final int freeTrial;
  final int proPlan;
  final int flexFactorScore;
  final int dripCheckScore;
  final int juiceLevelScore;
  final int goalDiggerScore;
  final int pickupGameScore;
  final int hotGameScore;
  final int overallScore;
  final String? achievedAt;
  final int rank;
  final dynamic flexFactorAns;
  final dynamic dripCheckAns;
  final dynamic juiceLevelAns;
  final dynamic goalDiggerAns;
  final dynamic pickupGameAns;
  final dynamic overallAns;
  final int flexFactorTimeSpent;
  final int dripCheckTimeSpent;
  final int juiceLevelTimeSpent;
  final int goalDiggerTimeSpent;
  final int pickupGameTimeSpent;
  final int askMeAnythingTimeSpent;
  final int weeklyAiTimeSpent;
  final String? weeklyAiTimeResetAt;
  final String? lastResetAt;
  final int level1;
  final int level2;
  final int level3;
  final int level4;
  final int isActive;
  final String createdAt;
  final String updatedAt;
  final dynamic settings;
  final TierData? tierData;
  final CategoryData? categoryData;

  UserData({
    required this.id,
    this.deviceId,
    this.profileImage,
    this.name,
    required this.badgeCount,
    this.email,
    required this.referralCode,
    this.referredBy,
    this.promoCode,
    this.referredDone,
    required this.freeTrial,
    required this.proPlan,
    required this.flexFactorScore,
    required this.dripCheckScore,
    required this.juiceLevelScore,
    required this.goalDiggerScore,
    required this.pickupGameScore,
    required this.hotGameScore,
    required this.overallScore,
    this.achievedAt,
    required this.rank,
    this.flexFactorAns,
    this.dripCheckAns,
    this.juiceLevelAns,
    this.goalDiggerAns,
    this.pickupGameAns,
    this.overallAns,
    required this.flexFactorTimeSpent,
    required this.dripCheckTimeSpent,
    required this.juiceLevelTimeSpent,
    required this.goalDiggerTimeSpent,
    required this.pickupGameTimeSpent,
    required this.askMeAnythingTimeSpent,
    required this.weeklyAiTimeSpent,
    this.weeklyAiTimeResetAt,
    this.lastResetAt,
    required this.level1,
    required this.level2,
    required this.level3,
    required this.level4,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.settings,
    this.tierData,
    this.categoryData,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? 0,
      deviceId: json['device_id'],
      profileImage: json['profile_image'],
      name: json['name'],
      badgeCount: json['badge_count'] ?? 0,
      email: json['email'],
      referralCode: json['referral_code'] ?? "",
      referredBy: json['referred_by'],
      promoCode: json['promo_code'],
      referredDone: json['referred_done'],
      freeTrial: json['free_trial'] ?? 0,
      proPlan: json['pro_plan'] ?? 0,
      flexFactorScore: json['flex_factor_score'] ?? 0,
      dripCheckScore: json['drip_check_score'] ?? 0,
      juiceLevelScore: json['juice_level_score'] ?? 0,
      goalDiggerScore: json['goal_digger_score'] ?? 0,
      pickupGameScore: json['pickup_game_score'] ?? 0,
      hotGameScore: json['hot_game_score'] ?? 0,
      overallScore: json['overall_score'] ?? 0,
      achievedAt: json['achieved_at'],
      rank: json['rank'] ?? 0,
      flexFactorAns: json['flex_factor_ans'],
      dripCheckAns: json['drip_check_ans'],
      juiceLevelAns: json['juice_level_ans'],
      goalDiggerAns: json['goal_digger_ans'],
      pickupGameAns: json['pickup_game_ans'],
      overallAns: json['overall_ans'],
      flexFactorTimeSpent: json['flex_factor_time_spent'] ?? 0,
      dripCheckTimeSpent: json['drip_check_time_spent'] ?? 0,
      juiceLevelTimeSpent: json['juice_level_time_spent'] ?? 0,
      goalDiggerTimeSpent: json['goal_digger_time_spent'] ?? 0,
      pickupGameTimeSpent: json['pickup_game_time_spent'] ?? 0,
      askMeAnythingTimeSpent: json['ask_me_anything_time_spent'] ?? 0,
      weeklyAiTimeSpent: json['weekly_ai_time_spent'] ?? 0,
      weeklyAiTimeResetAt: json['weekly_ai_time_reset_at'],
      lastResetAt: json['last_reset_at'],
      level1: json['level_1'] ?? 0,
      level2: json['level_2'] ?? 0,
      level3: json['level_3'] ?? 0,
      level4: json['level_4'] ?? 0,
      isActive: json['is_active'] ?? 0,
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      settings: json['settings'],
      tierData: json['tier_data'] != null ? TierData.fromJson(json['tier_data']) : null,
      categoryData: json['category_data'] != null ? CategoryData.fromJson(json['category_data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "device_id": deviceId,
      "profile_image": profileImage,
      "name": name,
      "badge_count": badgeCount,
      "email": email,
      "referral_code": referralCode,
      "referred_by": referredBy,
      "promo_code": promoCode,
      "referred_done": referredDone,
      "free_trial": freeTrial,
      "pro_plan": proPlan,
      "flex_factor_score": flexFactorScore,
      "drip_check_score": dripCheckScore,
      "juice_level_score": juiceLevelScore,
      "goal_digger_score": goalDiggerScore,
      "pickup_game_score": pickupGameScore,
      "hot_game_score": hotGameScore,
      "overall_score": overallScore,
      "achieved_at": achievedAt,
      "rank": rank,
      "flex_factor_ans": flexFactorAns,
      "drip_check_ans": dripCheckAns,
      "juice_level_ans": juiceLevelAns,
      "goal_digger_ans": goalDiggerAns,
      "pickup_game_ans": pickupGameAns,
      "overall_ans": overallAns,
      "flex_factor_time_spent": flexFactorTimeSpent,
      "drip_check_time_spent": dripCheckTimeSpent,
      "juice_level_time_spent": juiceLevelTimeSpent,
      "goal_digger_time_spent": goalDiggerTimeSpent,
      "pickup_game_time_spent": pickupGameTimeSpent,
      "ask_me_anything_time_spent": askMeAnythingTimeSpent,
      "weekly_ai_time_spent": weeklyAiTimeSpent,
      "weekly_ai_time_reset_at": weeklyAiTimeResetAt,
      "last_reset_at": lastResetAt,
      "level_1": level1,
      "level_2": level2,
      "level_3": level3,
      "level_4": level4,
      "is_active": isActive,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "settings": settings,
      "tier_data": tierData?.toJson(),
      "category_data": categoryData?.toJson(),
    };
  }
}

class TierData {
  final List<ItemData>? level1;
  final List<ItemData>? level2;
  final List<ItemData>? level3;
  final List<ItemData>? level4;

  TierData({this.level1, this.level2, this.level3, this.level4});

  factory TierData.fromJson(Map<String, dynamic> json) {
    return TierData(
      level1: (json['level_1'] as List?)?.map((e) => ItemData.fromJson(e)).toList(),
      level2: (json['level_2'] as List?)?.map((e) => ItemData.fromJson(e)).toList(),
      level3: (json['level_3'] as List?)?.map((e) => ItemData.fromJson(e)).toList(),
      level4: (json['level_4'] as List?)?.map((e) => ItemData.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "level_1": level1?.map((e) => e.toJson()).toList(),
      "level_2": level2?.map((e) => e.toJson()).toList(),
      "level_3": level3?.map((e) => e.toJson()).toList(),
      "level_4": level4?.map((e) => e.toJson()).toList(),
    };
  }
}

class CategoryData {
  final List<ItemData>? hot;
  final List<ItemData>? flex;
  final List<ItemData>? drip;
  final List<ItemData>? juice;
  final List<ItemData>? pickup;
  final List<ItemData>? goal;

  CategoryData({this.hot, this.flex, this.drip, this.juice, this.pickup, this.goal});

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      hot: (json['hot'] as List?)?.map((e) => ItemData.fromJson(e)).toList(),
      flex: (json['flex'] as List?)?.map((e) => ItemData.fromJson(e)).toList(),
      drip: (json['drip'] as List?)?.map((e) => ItemData.fromJson(e)).toList(),
      juice: (json['juice'] as List?)?.map((e) => ItemData.fromJson(e)).toList(),
      pickup: (json['pickup'] as List?)?.map((e) => ItemData.fromJson(e)).toList(),
      goal: (json['goal'] as List?)?.map((e) => ItemData.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "hot": hot?.map((e) => e.toJson()).toList(),
      "flex": flex?.map((e) => e.toJson()).toList(),
      "drip": drip?.map((e) => e.toJson()).toList(),
      "juice": juice?.map((e) => e.toJson()).toList(),
      "pickup": pickup?.map((e) => e.toJson()).toList(),
      "goal": goal?.map((e) => e.toJson()).toList(),
    };
  }
}

class ItemData {
  final String key;
  final String label;
  final String catLabel;
  final int value;
  final int level;
  final String category;

  ItemData({
    required this.key,
    required this.label,
    required this.catLabel,
    required this.value,
    required this.level,
    required this.category,
  });

  factory ItemData.fromJson(Map<String, dynamic> json) {
    return ItemData(
      key: json['key'] ?? "",
      label: json['label'] ?? "",
      catLabel: json['cat_label'] ?? "",
      value: json['value'] ?? 0,
      level: json['level'] ?? 0,
      category: json['category'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "key": key,
      "label": label,
      "cat_label": catLabel,
      "value": value,
      "level": level,
      "category": category,
    };
  }
}
