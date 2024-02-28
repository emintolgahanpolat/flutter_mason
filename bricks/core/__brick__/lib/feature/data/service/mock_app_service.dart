import './app_service.dart';

class MockAppService implements AppService {
  MockAppService();

  @override
  Future<String> getAppVersion() async {
    return "2.0.0";
  }
}
