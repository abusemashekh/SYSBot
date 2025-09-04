abstract class ApiEndpoints {
  // Server Url
  static final String serverUrl = "http://16.171.16.239:8080/";

  static final String imageUrl = "https://shoot-your-shot-app.s3.amazonaws.com/ai_bot/user_profile/";

  static final String terms = "https://shootyourshot.ai/terms";
  static final String privacy = "https://shootyourshot.ai/privacy";

  static final String _apiV1 = "api/v1";

  static final String getConfig = "$_apiV1/get-config";
  static final String initializeUser = "$_apiV1/initialize-user";
  static final String initializeAnswer = "$_apiV1/initialize-answer";
  static final String initializeTime = "$_apiV1/initialize-time";
  static final String initializeFriend = "$_apiV1/initialize-referFriend";
  static final String checkReferStatus = "$_apiV1/check-refer-status";
  static final String updateProfile = "$_apiV1/update-profile-profile";
  static final String updatePlanStatus = "$_apiV1/update-plan-status";
  static final String currentRankList = "$_apiV1/current-rank-list";
  static final String currentUserRank = "$_apiV1/current-rank";
}
