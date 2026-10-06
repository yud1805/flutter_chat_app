import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _savedEmailKey = 'saved_email';
  static const String _savedPasswordKey = 'saved_password';

  // Hàm xử lý Đăng nhập
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // Giả lập chờ mạng

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Lấy thông tin tài khoản đã đăng ký trước đó từ bộ nhớ
    final String? savedEmail = prefs.getString(_savedEmailKey);
    final String? savedPassword = prefs.getString(_savedPasswordKey);

    // Kiểm tra xem có khớp 100% với tài khoản đã đăng ký không
    if (savedEmail != null && email == savedEmail && password == savedPassword) {
      // Khớp -> Cấp token và cho đăng nhập
      final String mockToken = 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}';
      await prefs.setString(_tokenKey, mockToken);
      return true;
    }

    // Sai email, sai pass hoặc chưa đăng ký -> Đuổi ra
    return false;
  }

  // Hàm xử lý Đăng ký
  Future<bool> register(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // Giả lập chờ mạng

    if (email.isNotEmpty && password.length >= 6) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Lưu thông tin người dùng vừa nhập vào bộ nhớ điện thoại
      await prefs.setString(_savedEmailKey, email);
      await prefs.setString(_savedPasswordKey, password);

      return true;
    }
    return false;
  }

  // Lấy token (để kiểm tra xem đã login chưa)
  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Đăng xuất
  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Xóa token (nhưng vẫn giữ lại tài khoản đã đăng ký để lần sau login)
    await prefs.remove(_tokenKey);
  }
}
