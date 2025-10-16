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
      debugPrint(' Error in fetchItemDetails: $e');

      _itemDetails = null;
      print(' Setting error message: $_errorMessage');
    } finally {
      _isLoading = false;
      print(
        ' Finished fetching item details. Loading: $_isLoading, Error: $_errorMessage',
      );
      notifyListeners();
    }
  }
}
