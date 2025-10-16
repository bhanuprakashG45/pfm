import 'package:priya_fresh_meats/data/models/cart/cart_items_model.dart';
import 'package:priya_fresh_meats/data/models/cart/wallet_model.dart';
import 'package:priya_fresh_meats/data/repository/cart_rep/cart_repository.dart';
import 'package:priya_fresh_meats/utils/exports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  final CartRepository _repository = CartRepository();
  final SharedPref _pref = SharedPref();
  bool? _isSwitchOn = false;

  bool? get isSwitchOn => _isSwitchOn;

  void setSwitchwallet(bool value) {
    _isSwitchOn = value;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (isSwitchOn == true) {
        await _pref.storeWalletAmount(walletAmount.walletPoints);
        await _pref.clearCouponId();
      } else {
        await _pref.clearWalletAmount();
        debugPrint("Clearing wallet");
      }
      notifyListeners();
    });
  }

  List<CartItems> _cartData = [];
  List<CartItems> get cartItemsData => _cartData;

  bool _isCartFetching = false;
  bool get isCartFetching => _isCartFetching;

  set isCartFetching(bool value) {
    _isCartFetching = value;
    notifyListeners();
  }

  CouponData _couponData = CouponData(userCoupons: [], availableCoupons: []);
  CouponData get couponData => _couponData;

  bool _isCouponsLoading = false;
  bool get isCouponsLoading => _isCouponsLoading;

  set isCouponsLoading(bool value) {
    _isCouponsLoading = value;
    notifyListeners();
  }

  WalletData _wallet = WalletData(walletPoints: 0);
  WalletData get walletAmount => _wallet;

  bool _isWalletLoading = false;
  bool get isWalletLoading => _isWalletLoading;

  set isWalletLoading(bool value) {
    _isWalletLoading = value;
    notifyListeners();
  }

  String? _appliedCoupon;
  String? get appliedCoupon => _appliedCoupon;

  void applyCoupon(String? couponCode) {
    _appliedCoupon = couponCode;
    notifyListeners();
  }

  bool _isAmountLoading = false;
  bool get isAmountLoading => _isAmountLoading;

  set isAmountLoading(bool value) {
    _isAmountLoading = value;
    notifyListeners();
  }

  bool _isOrderPlacing = false;
  bool get isOrderPlacing => _isOrderPlacing;

  set isOrderPlacing(bool value) {
    _isOrderPlacing = value;
    notifyListeners();
  }

  String _orderId = '';
  String get orderID => _orderId;

  Future<void> fetchCartItems() async {
    isCartFetching = true;
    try {
      final result = await _repository.fetchCartItems();
      if (result.success) {
        _cartData = result.data;
        notifyListeners();
      } else {
        debugPrint("Failed to fetch cart items: ${result.message}");
      }
    } catch (e) {
      debugPrint("Error fetching cart items: $e");
    } finally {
      isCartFetching = false;
    }
  }

  Future<void> fetchAllCoupons() async {
    isCouponsLoading = true;
    try {
      final result = await _repository.fetchAllCoupons();
      if (result.success) {
        _couponData = result.data;
        notifyListeners();
      } else {
        debugPrint("Failed to fetch coupons: ${result.message}");
      }
    } catch (e) {
      debugPrint("Error fetching coupons: $e");
    } finally {
      isCouponsLoading = false;
    }
  }

  Future<void> fetchWallet() async {
    isWalletLoading = true;
    try {
      final result = await _repository.fetchWallet();
      if (result.success) {
        _wallet = result.data;
        notifyListeners();
      }
      debugPrint("Wallet fetched successfully");
    } catch (e) {
      debugPrint("Error fetching wallet: $e");
    } finally {
      isWalletLoading = false;
    }
  }

  Future<void> placeOrder(
    BuildContext context,
    String couponId,
    int wallet,
  ) async {
    isOrderPlacing = true;
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final locationprovider = Provider.of<LocationProvider>(
      context,
      listen: false,
    );
    final userType = locationprovider.userType ?? "self";
    final userName = locationprovider.userName ?? "";
    final userPhone = locationprovider.userPhone ?? "";
    final userFloor = locationprovider.userFloor ?? "";

    debugPrint("User Type: $userType");
    debugPrint("User Name: $userName");
    debugPrint("User Phone: $userPhone");
    await _prefs.setBool("pending_order", true);
    try {
      final userData = await _pref.getUserDetails();

      String location = userData['user_full_address'] ?? '';
      String phone = userData['mobile'] ?? '';
      String notes = '';
      double lat = userData['lat'] ?? 0.0;
      double long = userData['long'] ?? 0.0;
      String pincode = userData['pincode'] ?? '';
      int walletPoint = wallet;
      debugPrint("CouponId: $couponId");
      debugPrint("Wallet: $wallet");
      debugPrint("Location: $location");
      debugPrint("Phone: $phone");
      debugPrint("Notes: $notes");
      debugPrint("Latitude: $lat");
      debugPrint("Longitude: $long");
      debugPrint("Pincode: $pincode");
      debugPrint("Wallet Points: $walletPoint");
      final result = await _repository.placeOrder(
        userType,
        userName,
        userPhone,
        userFloor,
        location,
        notes,
        lat,
        long,
        pincode,
        walletPoint,
        couponId,
      );

      debugPrint(
        "Result success: ${result.success} (${result.success.runtimeType})",
      );
      debugPrint("Status: ${result.statusCode}, Message: ${result.message}");
      if (result.success) {
        _orderId = result.data.order;
        debugPrint("Order ID: $_orderId");
        debugPrint("Order placed successfully");
        await _prefs.setBool("pending_order", false);
        notifyListeners();
      } else {
        debugPrint("Failed to place order: ${result.message}");
      }
    } catch (e) {
      debugPrint("Error placing order: $e");
    } finally {
      isOrderPlacing = false;
    }
  }

  double get totalAmount {
    final itemTotal = cartItemsData.fold<double>(
      0.0,
      (sum, item) =>
          sum +
          (item.subCategory.discountPrice.toDouble() * item.count.toDouble()),
    );

    const double deliveryFee = 39.0;
    const double handlingFee = 5.0;
    double discount = 0.0;
    double walletDeduction = 0.0;

    final totalBeforeDiscount = itemTotal + deliveryFee + handlingFee;
    if (_appliedCoupon != null && _appliedCoupon!.isNotEmpty) {
      final coupon = _couponData.availableCoupons.firstWhere(
        (c) => c.code == _appliedCoupon,
        orElse:
            () => Coupon(
              id: '',
              name: '',
              code: '',
              discount: 0,
              expiryDate: DateTime.now(),
              limit: 0,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              v: 0,
            ),
      );

      if (coupon.code.isNotEmpty) {
        discount = itemTotal * (coupon.discount.toDouble() / 100.0);
      }
    } else if (_isSwitchOn == true && walletAmount.walletPoints > 0) {
      walletDeduction =
          walletAmount.walletPoints.toDouble() > totalBeforeDiscount
              ? totalBeforeDiscount
              : walletAmount.walletPoints.toDouble();
    }
    return totalBeforeDiscount - discount - walletDeduction;
  }
}
