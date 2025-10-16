import 'package:priya_fresh_meats/data/models/profile/notifications_model.dart';
import 'package:priya_fresh_meats/data/models/profile/profile_details_model.dart';
import 'package:priya_fresh_meats/utils/exports.dart';

class ProfileViewModel with ChangeNotifier {
  final ProfileRepository _repository = ProfileRepository();

  List<NotificationData> _notifications = [];
  List<NotificationData> get notifications => _notifications;

  bool _isNotificationFetching = false;
  bool get isNotificationsFetching => _isNotificationFetching;

  set isNotificationsFetching(bool value) {
    _isNotificationFetching = value;
    notifyListeners();
  }

  List<AddressData> _addressdata = [];
  List<AddressData> get addressdata => _addressdata;

  bool _isAddressLoading = false;
  bool get isAddressLoading => _isAddressLoading;

  set isAddressLoading(bool value) {
    _isAddressLoading = value;
    notifyListeners();
  }

  bool _isNewAddressAdding = false;
  bool get isNewAddressAdding => _isNewAddressAdding;

  set isNewAddressAdding(bool value) {
    _isNewAddressAdding = value;
    notifyListeners();
  }

  bool _isAddressUpdating = false;
  bool get isAddressUpdating => _isAddressUpdating;

  set isAddressUpdating(bool value) {
    _isAddressUpdating = value;
    notifyListeners();
  }

  bool _isAddressDeleting = false;
  bool get isAddressDeleting => _isAddressDeleting;

  set isAddressDeleting(bool value) {
    _isAddressDeleting = value;
    notifyListeners();
  }

  ProfileData _profileData = ProfileData(name: '', phone: '', email: '');
  ProfileData get profiledata => _profileData;

  bool _isProfileLoading = false;
  bool get isProfileLoading => _isProfileLoading;

  set isProfileLoading(bool value) {
    _isProfileLoading = value;
    notifyListeners();
  }

  bool _isProfileUpdating = false;
  bool get isProfileUpdating => _isProfileUpdating;

  set isProfileUpdating(bool value) {
    _isProfileUpdating = value;
    notifyListeners();
  }

  Future<void> fetchProfileDetails() async {
    isProfileLoading = true;
    try {
      final response = await _repository.fetchprofile();
      if (response.success) {
        _profileData = response.data;
      } else {
        debugPrint(response.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isProfileLoading = false;
    }
  }

  Future<void> updateProfile(
    BuildContext context,
    String name,
    String email,
  ) async {
    isProfileUpdating = true;
    try {
      final response = await _repository.updateProfile(name, email);
      if (response.success) {
        await fetchProfileDetails();
        debugPrint(response.message);
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      } else {
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isProfileUpdating = false;
    }
  }

  Future<void> fetchNotifications() async {
    isNotificationsFetching = true;
    try {
      final response = await _repository.fetchNotifications();

      if (response.success) {
        _notifications = response.data.notifications;
      } else {
        debugPrint(response.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isNotificationsFetching = false;
    }
  }

  Future<void> fetchAllAddress() async {
    isAddressLoading = true;
    try {
      final response = await _repository.fetchAllAddress();
      if (response.success) {
        _addressdata = response.data;
      } else {
        debugPrint(response.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isAddressLoading = false;
    }
  }

  Future<void> addNewAddress(
    String name,
    String phone,
    String houseNo,
    String streetName,
    String city,
    String state,
    String pincode,
    String type,
    String lat,
    String long,
  ) async {
    isNewAddressAdding = true;
    try {
      final response = await _repository.addNewAddress(
        name,
        phone,
        houseNo,
        streetName,
        city,
        state,
        pincode,
        type,
        lat,
        long,
      );
      if (response.success) {
        await fetchAllAddress();

        debugPrint("Added New Address : ${response.message}");
      } else {
        debugPrint(response.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isNewAddressAdding = false;
    }
  }

  Future<void> updateAddress(
    BuildContext context,
    String id,
    String name,
    String phone,
    String houseNo,
    String streetName,
    String city,
    String state,
    String pincode,
    String type,
  ) async {
    isAddressUpdating = true;
    try {
      final locationprovider = Provider.of<LocationProvider>(
        context,
        listen: false,
      );
      final result = await locationprovider.getLatLngFromAddress(
        houseNo: houseNo,
        street: streetName,
        city: city,
        state: state,
        pincode: pincode,
      );

      double? latitude;
      double? longitude;

      if (result != null) {
        latitude = result["latitude"];
        longitude = result["longitude"];
        debugPrint("Lat: $latitude, Lng: $longitude");
      } else {
        debugPrint("Could not fetch location");
      }

      final response = await _repository.updateAddress(
        id,
        name,
        phone,
        houseNo,
        streetName,
        city,
        state,
        pincode,
        type,
        latitude.toString(),
        longitude.toString(),
      );
      if (response.success) {
        await fetchAllAddress();
        if (context.mounted) {
          customSuccessToast(context, "Updated Address SuccessFully");
        }
        debugPrint("Updated Address SuccessFully");
      } else {
        debugPrint(response.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isAddressUpdating = false;
    }
  }

  Future<void> deleteAddress(String itemId) async {
    isAddressDeleting = true;
    try {
      final response = await _repository.deleteAddress(itemId);
      if (response.success) {
        debugPrint(response.message);
        await fetchAllAddress();
      } else {
        debugPrint(response.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isAddressDeleting = false;
    }
  }

  Future<void> updateDeFaultAddress(String itemId) async {
    isAddressUpdating = true;
    try {
      final response = await _repository.updateDefaultAddress(itemId, true);
      if (response.success) {
        await fetchAllAddress();
        debugPrint(response.statusCode.toString());
      } else {
        debugPrint("Failed to Update DeFault Address");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isAddressUpdating = false;
    }
  }
}
