import 'package:flutter/widgets.dart';
import 'package:priya_fresh_meats/data/models/home/best_sellers_model.dart';
import 'package:priya_fresh_meats/data/models/home/cartcount_model.dart';
import 'package:priya_fresh_meats/data/repository/home_rep/home_repository.dart';

class HomeViewmodel with ChangeNotifier {
  final HomeRepository _repository = HomeRepository();

  List<Datum> _bestSellers = [];
  List<Datum> get bestSellers => _bestSellers;

  bool _isBestSellersLoading = false;
  bool get isBestSellersLoading => _isBestSellersLoading;

  set isBestSellersLoading(bool value) {
    _isBestSellersLoading = value;
    notifyListeners();
  }

  List<String> _notifiedItemIds = [];
  List<String> get notifiedItemIds => _notifiedItemIds;

  // set addToNotifiedItem(String value) {
  //   _notifiedItemIds.add(value);
  //   debugPrint("Notified Item Ids: $value");
  //   notifyListeners();
  // }

  CartCount _count = CartCount(totalCount: 0, totalAmount: 0);
  CartCount get cartCount => _count;

  bool _isCartCountLoading = false;
  bool get isCartCountLoading => _isCartCountLoading;

  set isCartCountLoading(bool value) {
    _isCartCountLoading = value;
    notifyListeners();
  }

  void clearCartCount() {
    _count = CartCount(totalCount: 0, totalAmount: 0);
    notifyListeners();
  }

  bool _isNotifyMeLoading = false;
  bool get isNotifyMeLoading => _isNotifyMeLoading;

  set isNotifyMeLoading(bool value) {
    _isNotifyMeLoading = value;
    notifyListeners();
  }

  Future<void> fetchBestSellers() async {
    isBestSellersLoading = true;
    try {
      final response = await _repository.fetchBestSellers();
      if (response.success) {
        _bestSellers = response.data;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isBestSellersLoading = false;
    }
  }

  Future<void> addToCart(String itemId) async {
    try {
      final response = await _repository.addItemsToCart(itemId);
      if (response.success) {
        await fetchCartCount();
        debugPrint("Added Items To cart Successfully");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateCount(String itemId, int count) async {
    try {
      final response = await _repository.updateCount(itemId, count);
      await fetchCartCount();
      if (response.message == "Cart item count updated successfully") {
        debugPrint("Updated the Item Count");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteItem(String itemId) async {
    try {
      final response = await _repository.deleteCount(itemId);
      if (response.success) {
        await fetchCartCount();
        debugPrint("Deleted the Item Count");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> fetchCartCount() async {
    isCartCountLoading = true;
    try {
      final response = await _repository.fetchCartCount();
      if (response.success) {
        _count = response.data;
        debugPrint("Amount : ${cartCount.totalAmount}");
      } else {
        debugPrint(response.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isCartCountLoading = false;
    }
  }

  Future<void> notifyMe(String itemId) async {
    isNotifyMeLoading = true;

    _notifiedItemIds.add(itemId);

    debugPrint("Notified Item Ids: $itemId");
    notifyListeners();

    try {
      final response = await _repository.notifyMe(itemId);
      if (response.success) {
        debugPrint("Added to Notify Me : ${response.message}");
      } else {
        debugPrint(response.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isNotifyMeLoading = false;
    }
  }

  void updateCartCount(String productId, int newCount) {
    final index = _bestSellers.indexWhere((p) => p.id == productId);
    if (index != -1) {
      _bestSellers[index].count = newCount;
    }
    _recalculateCart();
    notifyListeners();
  }

  void removeFromCart(String productId) {
    final index = _bestSellers.indexWhere((p) => p.id == productId);
    if (index != -1) {
      _bestSellers[index].count = 0;
    }
    _recalculateCart();
    notifyListeners();
  }

  void addToCartLocal(String productId) {
    updateCartCount(productId, 1);
  }

  void _recalculateCart() {
    int totalCount = 0;
    double totalAmount = 0;

    for (final item in _bestSellers) {
      if (item.count > 0) {
        totalCount += item.count;
        totalAmount += (item.count * (item.price));
      }
    }

    _count = CartCount(totalCount: totalCount, totalAmount: totalAmount);
  }
}
