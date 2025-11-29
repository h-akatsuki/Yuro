import 'package:asmrapp/data/models/auth/auth_resp/auth_resp.dart';
import 'package:dio/dio.dart';
import '../../utils/logger.dart';

class AuthService {
  final Dio _dio;

  AuthService()
      : _dio = Dio(BaseOptions(
          baseUrl: 'https://api.asmr.one/api',
        ));

  Future<AuthResp> login(String name, String password) async {
    try {
      AppLogger.info('开始登录请求: name=$name');
      final response = await _dio.post(
        '/auth/me',
        data: {
          'name': name,
          'password': password,
        },
      );

      AppLogger.info('收到登录响应: statusCode=${response.statusCode}');
      AppLogger.info('响应数据: ${response.data}');

      if (response.statusCode == 200) {
        final authResp = AuthResp.fromJson(response.data);
        AppLogger.info(
            '登录成功: username=${authResp.user?.name}, group=${authResp.user?.group}');
        return authResp;
      }

      throw Exception('登录失败: ${response.statusCode}');
    } on DioException catch (e) {
      AppLogger.error('登录请求失败', e);
      AppLogger.error('错误详情: ${e.response?.data}');
      throw Exception('网络请求失败: ${e.message}');
    } catch (e) {
      AppLogger.error('登录失败', e);
      throw Exception('登录失败: $e');
    }
  }
}
