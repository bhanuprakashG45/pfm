import 'package:priya_fresh_meats/utils/exports.dart';
import 'package:http/http.dart' as http;

class LoginViewModel with ChangeNotifier {
  final LoginRepository _loginRepository = LoginRepository();
  final SharedPref _sharedpref = SharedPref();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isVerifying = false;
  bool get isVerifying => _isVerifying;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set isVerifying(bool value) {
    _isVerifying = value;
    notifyListeners();
  }

  bool _showAnimation = false;
  bool get showAnimation => _showAnimation;

  set showAnimation(bool value) {
    _showAnimation = value;
    notifyListeners();
  }

  TextEditingController phoneController = TextEditingController();

  bool _isButtonEnabled = false;
  bool get isButtonEnabled => _isButtonEnabled;

  LoginViewmodel() {
    phoneController.addListener(_validatePhone);
  }

  void _validatePhone() {
    final isValid = phoneController.text.length == 10;
    if (_isButtonEnabled != isValid) {
      _isButtonEnabled = isValid;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    phoneController.removeListener(_validatePhone);
    phoneController.dispose();
    super.dispose();
  }

  Future<void> sendOtp(String phone, BuildContext context) async {
    isLoading = true;
    try {
      final result = await _loginRepository.sendOtp(phone);
      debugPrint("Login response: $result");
      if (result.success == true) {
        final userId = result.data.userId;
        debugPrint(userId);
        await _sharedpref.storeUserId(userId);
        notifyListeners();
        Navigator.pushNamed(context, AppRoutes.otpView, arguments: phone);
      } else {
        debugPrint(result.message);
      }
    } catch (e) {
      if (e is AppException) {
        debugPrint(e.userFriendlyMessage);
      } else {
        print("Response body: $e");
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> verifyOtp(String otp, String phone, BuildContext context) async {
    isVerifying = true;
    try {
      final userId = await _sharedpref.getUserId();
      final result = await _loginRepository.verifyOtp(otp, phone, userId);
      if (result.success == true) {
        final userData = result.data;

        await _sharedpref.storeUserData(userData);
        await _sharedpref.storeMobileNumber(phone);
        // customSuccessToast(context, result.message);
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.bottomNavBar,
          (route) => false,
        );
      } else {
        customErrorToast(context, result.message);
      }
    } catch (e) {
      if (e is AppException) {
        debugPrint(e.userFriendlyMessage);
      } else {
        debugPrint("An unexpected error occurred.");
      }
    } finally {
      isVerifying = false;
      notifyListeners();
    }
  }

  Future<void> sendDeviceToken() async {
    final url = AppUrls.sendDeviceTokenUrl;
    final deviceToken = await _sharedpref.fetchDeviceToken();
    debugPrint("DeviceToken :$deviceToken");
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"token": deviceToken}),
      );
      if (response.statusCode == 200) {
        debugPrint('Device token sent successfully!');
        debugPrint('Response: ${response.body}');
      } else {
        debugPrint(
          'Failed to send device token. Status code: ${response.statusCode}',
        );
        debugPrint('Response: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error sending device token: $e');
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    try {
      final userId = await _sharedpref.getUserId();
      final response = await _loginRepository.deleteAccount(userId);

      if (response.success) {
        if (context.mounted) {
          customSuccessToast(context, response.message);
          await _sharedpref.clearUserdata();
          await _sharedpref.clearAccessToken();
          await _sharedpref.clearRefreshToken();
          await Future.delayed(const Duration(milliseconds: 300));
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          );
        }
      } else {
        if (context.mounted) {
          customErrorToast(context, response.message);
          await Future.delayed(const Duration(milliseconds: 300));
          Navigator.pop(context);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      if (context.mounted) {
        customErrorToast(context, "Something went wrong");
        await Future.delayed(const Duration(milliseconds: 300));
        Navigator.pop(context);
      }
    } finally {
      showAnimation = false;
    }
  }
}
