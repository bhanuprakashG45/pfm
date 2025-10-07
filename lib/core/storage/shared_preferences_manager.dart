import 'package:flutter/widgets.dart';
import 'package:priya_fresh_meats/data/models/auth/userdata_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPreferences? _prefs;

  Future<void> _initSharedPreferences() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> storeWalletAmount(int amount) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('wallet', amount);
  }

  Future<int> getWalletAmount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('wallet') ?? 0;
  }

  Future<void> clearWalletAmount() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('wallet');
  }

  Future<void> storelastQuestionShownTime() async {
    await _initSharedPreferences();
    await _prefs!.setString('lastshowntime', DateTime.now().toIso8601String());
  }

  Future<void> storeAccessToken(String? accessToken) async {
    await _initSharedPreferences();
    if (accessToken != null) {
      await _prefs!.setString('accessToken', accessToken);
    }
  }

  Future<void> storeRefreshToken(String? refreshToken) async {
    await _initSharedPreferences();
    if (refreshToken != null) {
      await _prefs!.setString('refreshToken', refreshToken);
    }
  }

  Future<void> storeUserId(String userId) async {
    await _initSharedPreferences();
    await _prefs!.setString('userId', userId);
    debugPrint("Storing UserId : $userId");
  }

  Future<String> getUserId() async {
    await _initSharedPreferences();
    final userId = _prefs!.getString('userId') ?? '';
    debugPrint("Fetching UserId : $userId");
    return userId;
  }

  Future<void> storeCouponId(String couponId) async {
    await _initSharedPreferences();
    const key = 'couponId';
    await _prefs!.remove(key);
    await _prefs!.setString(key, couponId);
    debugPrint("Stored couponId: $couponId");
  }

  Future<String> getCouponId() async {
    await _initSharedPreferences();
    return _prefs!.getString('couponId') ?? '';
  }

  Future<void> clearCouponId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('couponId');
  }

  Future<void> storeUserData(UserData userData) async {
    await _initSharedPreferences();
    String accessToken = userData.accessToken;
    String refreshToken = userData.refreshToken;
    String userId = userData.user.id;
    await storeAccessToken(accessToken);
    await storeRefreshToken(refreshToken);
    await storeUserId(userId);
    debugPrint(accessToken);
  }

  Future<void> storeMobileNumber(String mobile) async {
    await _initSharedPreferences();
    await _prefs!.setString('mobile', mobile);
  }

  Future<String?> getlastQuestionShownTime() async {
    await _initSharedPreferences();
    return _prefs!.getString('lastshowntime');
  }

  Future<String?> getUserData() async {
    await _initSharedPreferences();
    return _prefs!.getString('userData');
  }

  // Future<String> getUserId() async {
  //   await _initSharedPreferences();
  //   return _prefs!.getString('userId') ?? '';
  // }

  Future<String> getAccessToken() async {
    await _initSharedPreferences();
    return _prefs!.getString('accessToken') ?? '';
  }

  Future<String> getRefreshToken() async {
    await _initSharedPreferences();
    return _prefs!.getString('refreshToken') ?? '';
  }

  Future<void> clearAccessToken() async {
    await _initSharedPreferences();
    if (_prefs!.containsKey('accessToken')) {
      await _prefs!.remove('accessToken');
    }
  }

  Future<void> clearRefreshToken() async {
    await _initSharedPreferences();
    if (_prefs!.containsKey('refreshToken')) {
      await _prefs!.remove('refreshToken');
    }
  }

  // Future<void> clearUserData() async {
  //   await _initSharedPreferences();
  //   if (_prefs!.containsKey('userData')) {
  //     await _prefs!.remove('userData');
  //   }
  //   // await _prefs!.clear();
  // }

  Future<void> storeModalIndex(int index) async {
    await _initSharedPreferences();
    await _prefs!.setInt("modalindex", index);
  }

  Future<int?> getModalIndex() async {
    await _initSharedPreferences();
    return _prefs!.getInt('modalindex');
  }

  // Additional helper methods for debugging
  Future<bool> hasAccessToken() async {
    await _initSharedPreferences();
    final token = _prefs!.getString('accessToken');
    return token != null && token.isNotEmpty;
  }

  Future<bool> hasRefreshToken() async {
    await _initSharedPreferences();
    final token = _prefs!.getString('refreshToken');
    return token != null && token.isNotEmpty;
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? area = prefs.getString('user_area');
    String? fullAddress = prefs.getString('user_full_address');
    String? pincode = prefs.getString('pincode');
    double? lat = prefs.getDouble('lat');
    double? long = prefs.getDouble('long');
    String? mobile = prefs.getString('mobile');

    return {
      'user_area': area,
      'user_full_address': fullAddress,
      'pincode': pincode,
      'lat': lat,
      'long': long,
      'mobile': mobile,
    };
  }

  Future<void> clearUserdata() async {
    await _initSharedPreferences();
    _prefs!.remove('user_area');
    _prefs!.remove('user_full_address');
    _prefs!.remove('pincode');
    _prefs!.remove('lat');
    _prefs!.remove('long');
    _prefs!.remove('mobile');
  }

  Future<void> clearUserId() async {
    await _initSharedPreferences();
    _prefs!.remove('userId');
  }

  Future<void> storeDeviceToken(String devicetoken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    debugPrint("Store DeviceToken :$devicetoken");

    if (devicetoken.isNotEmpty) {
      await prefs.setString('device_token', devicetoken);
    } else {}
  }

  Future<String> fetchDeviceToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    print("Fetching Device Token ");
    String devicetoken = preferences.getString("device_token") ?? '';
    debugPrint("FCM Token : $devicetoken");
    if (devicetoken != '' && devicetoken.isNotEmpty) {
      debugPrint("FCM Token : $devicetoken");
      return devicetoken;
    } else {
      return '';
    }
  }

  Future<String> getUserAddress() async {
    await _initSharedPreferences();
    final userData = await getUserDetails();
    return userData['user_full_address'] ?? "No address available";
  }

  Future<Map<String, dynamic>> getTempAddressDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? area = prefs.getString('user_area_temp');
    String? fullAddress = prefs.getString('user_full_address_temp');
    String? pincode = prefs.getString('pincode_temp');
    double? lat = prefs.getDouble('lat_temp');
    double? long = prefs.getDouble('long_temp');
    return {
      'user_area_temp': area,
      'user_full_address_temp': fullAddress,
      'pincode_temp': pincode,
      'lat_temp': lat,
      'long_temp': long,
    };
  }
}
