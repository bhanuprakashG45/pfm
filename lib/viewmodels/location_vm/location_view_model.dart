import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationProvider with ChangeNotifier {
  String _area = 'No area set';
  String _fullAddress = 'No location set';

  String get area => _area;
  String get fullAddress => _fullAddress;

  String _pincode = 'No Pincode';
  String get pincode => _pincode;

  double _lat = 0.0;
  double _long = 0.0;

  double get lat => _lat;
  double get long => _long;

  bool get hasLocation =>
      _fullAddress != 'No location set' && _fullAddress.isNotEmpty;

  bool _isCurrentLocationLoading = false;
  bool get isCurrentLocationLoading => _isCurrentLocationLoading;
  set isCurrentLocationLoading(bool value) {
    _isCurrentLocationLoading = value;
    notifyListeners();
  }

  String? _userAreaTemp;
  String? _userFullAddressTemp;
  String? _pincodeTemp;
  double? _latTemp;
  double? _longTemp;

  String? get userAreaTemp => _userAreaTemp;
  String? get userFullAddressTemp => _userFullAddressTemp;
  String? get pincodeTemp => _pincodeTemp;
  double? get latTemp => _latTemp;
  double? get longTemp => _longTemp;

  String? _userName;
  String? _userPhone;
  String? _userFloor;
  String? _userType;

  String? get userName => _userName;
  String? get userPhone => _userPhone;
  String? get userFloor => _userFloor;
  String? get userType => _userType;

  set userType(String? value) {
    _userType = value;
    notifyListeners();
  }

  set userName(String? value) {
    _userName = value;
    notifyListeners();
  }

  set userPhone(String? value) {
    _userPhone = value;
    notifyListeners();
  }

  set userFloor(String? value) {
    _userFloor = value;
    notifyListeners();
  }

  Future<void> loadSavedLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _area = prefs.getString('user_area') ?? 'No area set';
    _fullAddress = prefs.getString('user_full_address') ?? 'No location set';
    notifyListeners();
  }

  Future<void> storeUserDetails(String floor, String name, String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_floor', floor);
    await prefs.setString('user_name', name);
    await prefs.setString('user_phone', phone);
    debugPrint("Floor : $floor, $name,$phone");
    _userFloor = floor;
    _userName = name;
    _userPhone = phone;
    notifyListeners();
  }

  Future<void> loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? floor = prefs.getString('user_floor');
    String? name = prefs.getString('user_name');
    String? phone = prefs.getString('user_phone');
    _userFloor = floor;
    _userName = name;
    _userPhone = phone;
    notifyListeners();
    debugPrint('User Floor: $floor, Name: $name, Phone: $phone');
  }

  Future<void> clearUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_floor');
    await prefs.remove('user_name');
    await prefs.remove('user_phone');
    _userFloor = null;
    _userName = null;
    _userPhone = null;
    notifyListeners();
  }

  Future<void> saveLocation(
    String area,
    String fullAddress,
    String pincode,
    double lat,
    double lang,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_area', area);
    await prefs.setString('user_full_address', fullAddress);
    await prefs.setString('pincode', pincode);
    await prefs.setDouble('lat', lat);
    await prefs.setDouble('long', lang);
    _area = area;
    _fullAddress = fullAddress;
    _pincode = pincode;
    notifyListeners();
  }

  Future<String?> fetchAndSaveCurrentLocation() async {
    isCurrentLocationLoading = true;
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return 'Location services are disabled.';

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return 'Location permission denied.';
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return 'Location permission permanently denied. Please enable it in settings.';
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      double? lat, long;
      String? postalCode;
      String area, fullAddress;
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        area =
            place.locality ?? place.subLocality ?? place.name ?? 'Unknown area';
        fullAddress =
            '${place.name}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
        postalCode = place.postalCode!;
        lat = position.latitude;
        long = position.longitude;
      } else {
        area = 'Unknown area';
        fullAddress = '${position.latitude}, ${position.longitude}';
      }

      await saveLocation(area, fullAddress, postalCode!, lat!, long!);
      return null;
    } catch (e) {
      return 'Failed to fetch location: $e';
    } finally {
      isCurrentLocationLoading = false;
    }
  }

  Future<Map<String, double>?> getLatLngFromAddress({
    required String houseNo,
    required String street,
    required String city,
    required String state,
    required String pincode,
  }) async {
    try {
      final address = "$houseNo, $street, $city, $state, $pincode";
      List<Location> locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        final loc = locations.first;
        debugPrint(loc.latitude.toString());
        debugPrint(loc.longitude.toString());
        return {"latitude": loc.latitude, "longitude": loc.longitude};
      } else {
        return null;
      }
    } catch (e) {
      print("Geocoding error: $e");
      return null;
    }
  }

  Future<void> saveTempLocation(
    String area,
    String fullAddress,
    String pincode,
    double lat,
    double lang,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_area_temp', area);
    await prefs.setString('user_full_address_temp', fullAddress);
    await prefs.setString('pincode_temp', pincode);
    await prefs.setDouble('lat_temp', lat);
    await prefs.setDouble('long_temp', lang);
    _userAreaTemp = area;
    _userFullAddressTemp = fullAddress;
    _pincodeTemp = pincode;
    _latTemp = lat;
    _longTemp = long;

    notifyListeners();
  }

  Future<void> loadTempLocation() async {
    final prefs = await SharedPreferences.getInstance();

    _userAreaTemp = prefs.getString('user_area_temp');
    _userFullAddressTemp = prefs.getString('user_full_address_temp');
    _pincodeTemp = prefs.getString('pincode_temp');
    _latTemp = prefs.getDouble('lat_temp');
    _longTemp = prefs.getDouble('long_temp');

    notifyListeners();
  }
}
