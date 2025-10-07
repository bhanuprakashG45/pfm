import 'package:priya_fresh_meats/utils/exports.dart';

class ItemDetailsProvider with ChangeNotifier {
  final ItemDetailsRepository _itemDetailsRepository;

  ItemDetailsProvider(this._itemDetailsRepository);

  ItemDetailsModel? _itemDetails;
  bool _isLoading = false;
  String _errorMessage = '';
  int _quantity = 0;

  ItemDetailsModel? get itemDetails => _itemDetails;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  int get quantity => _quantity;

  Future<void> fetchItemDetails(String itemId) async {
    _isLoading = true;
    _errorMessage = '';
    _itemDetails = null;
    notifyListeners();

    try {
      final itemDetails = await _itemDetailsRepository.getItemDetails(itemId);
      debugPrint(itemId);
      _itemDetails = itemDetails;
    } catch (e) {
      _errorMessage = 'Failed to load item details: $e';
      debugPrint('❌ Error in fetchItemDetails: $e');

      _itemDetails = null;
      print('🚨 Setting error message: $_errorMessage');
    } finally {
      _isLoading = false;
      print(
        '🏁 Finished fetching item details. Loading: $_isLoading, Error: $_errorMessage',
      );
      notifyListeners();
    }
  }

  // void updateQuantity(int newQuantity) {
  //   if (newQuantity >= 0) {
  //     _quantity = newQuantity;
  //     notifyListeners();
  //     print('📊 Updated quantity: $newQuantity');
  //   }
  // }

  // void incrementQuantity() {
  //   _quantity++;
  //   notifyListeners();
  //   print('➕ Incremented quantity: $_quantity');
  // }

  // void decrementQuantity() {
  //   if (_quantity > 0) {
  //     _quantity--;
  //     notifyListeners();
  //     print('➖ Decremented quantity: $_quantity');
  //   }
  // }

  // void addToCart() {
  //   if (_quantity == 0) {
  //     _quantity = 1;
  //     notifyListeners();
  //     print('🛒 Added item to cart with quantity: $_quantity');
  //   }
  // }

  // void clearError() {
  //   print('🧹 Clearing error message');
  //   _errorMessage = '';
  //   notifyListeners();
  // }

  // Future<void> retryFetchItemDetails(String itemId) async {
  //   print('🔄 Retrying to fetch item details for ID: $itemId');
  //   clearError();
  //   await fetchItemDetails(itemId);
  // }

  // void resetQuantity() {
  //   _quantity = 0;
  //   notifyListeners();
  // }

  // void clearData() {
  //   _itemDetails = null;
  //   _quantity = 0;
  //   _errorMessage = '';
  //   _isLoading = false;
  //   notifyListeners();
  // }
}
