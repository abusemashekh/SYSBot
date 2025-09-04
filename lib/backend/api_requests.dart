import 'package:sysbot3/backend/api_end_points.dart';
import 'package:sysbot3/backend/network_api_services.dart';

///* Call project APIs here
class ApiRequests {
  final _apiService = NetworkApiServices();

  Future<dynamic> initializeUserApi(var data) async {
    dynamic response =
        await _apiService.postApi(data, ApiEndpoints.initializeUser);
    return response;
  }

  Future<dynamic> getRizzQuizzApi() async {
    dynamic response = await _apiService.getApi(ApiEndpoints.getConfig);
    return response;
  }

  Future<dynamic> updateRizzQuizzAnsApi(var data) async {
    dynamic response =
        await _apiService.postApi(data, ApiEndpoints.initializeAnswer);
    return response;
  }

  Future<dynamic> initializeFriendApi(var data) async {
    dynamic response =
        await _apiService.postApi(data, ApiEndpoints.initializeFriend);
    return response;
  }

  Future<dynamic> checkReferStatusApi(var data) async {
    dynamic response =
        await _apiService.postApi(data, ApiEndpoints.checkReferStatus);
    return response;
  }

  Future<dynamic> updateProfileApi(var data) async {
    dynamic response =
        await _apiService.postApi(data, ApiEndpoints.updateProfile);
    return response;
  }

  Future<dynamic> initializeTimeApi(var data) async {
    dynamic response =
        await _apiService.postApi(data, ApiEndpoints.initializeTime);
    return response;
  }

  Future<dynamic> updatePlanStatusApi(var data) async {
    dynamic response =
        await _apiService.postApi(data, ApiEndpoints.updatePlanStatus);
    return response;
  }

  Future<dynamic> currentRankListApi(var data) async {
    dynamic response =
        await _apiService.postApi(data, ApiEndpoints.currentRankList);
    return response;
  }

  Future<dynamic> currentUserRankApi(var data) async {
    dynamic response =
        await _apiService.postApi(data, ApiEndpoints.currentUserRank);
    return response;
  }
}
