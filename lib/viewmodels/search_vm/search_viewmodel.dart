import 'package:priya_fresh_meats/utils/exports.dart';

class SearchViewmodel with ChangeNotifier {
  final SearchRepository _repository = SearchRepository();

  List<SearchCategoryData> _searchCategoryData = [];
  List<SearchCategoryData> get shopByCategoryData => _searchCategoryData;

  bool _isSearchCategoriesLoading = false;
  bool get isSearchCategoriesloading => _isSearchCategoriesLoading;

  set isSearchCategoriesLoading(bool value) {
    _isSearchCategoriesLoading = value;
    notifyListeners();
  }

  List<AllSearchData> _allSearchData = [];
  List<AllSearchData> get allSearchData => _allSearchData;

  List<AllSearchData> _filteredSearchData = [];
  List<AllSearchData> get filteredSearchData => _filteredSearchData;

  bool _isAllsearchDataLoading = false;
  bool get isAllsearchDataLoading => _isAllsearchDataLoading;

  set isAllsearchDataLoading(bool value) {
    _isAllsearchDataLoading = value;
    notifyListeners();
  }

  String _searchText = '';
  String get searchText => _searchText;

  bool _showHint = true;
  bool get showHint => _showHint;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  int _nextIndex = 1;
  int get nextIndex => _nextIndex;

  void updateSearchText(String value) {
    _searchText = value;

    _showHint = value.isEmpty;

    filterSearchData(value);

    notifyListeners();
  }

  void updateHintVisibility(bool visible) {
    if (_showHint != visible) {
      _showHint = visible;
      notifyListeners();
    }
  }

  void updateAnimatedKeyword({int keywordsLength = 3}) {
    _currentIndex = _nextIndex;
    _nextIndex = (_nextIndex + 1) % keywordsLength;
    notifyListeners();
  }

  void clearSearch() {
    _searchText = '';
    _showHint = true;
    notifyListeners();
  }

  Future<void> fetchSearchShopByCategory() async {
    isSearchCategoriesLoading = true;
    try {
      final result = await _repository.fetchAllShopByCategory();

      if (result.success) {
        _searchCategoryData = result.data;
      } else {
        debugPrint(result.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isSearchCategoriesLoading = false;
    }
  }

  Future<void> fetchAllSearchData({String searchText = ''}) async {
    isAllsearchDataLoading = true;
    notifyListeners();

    try {
      final result = await _repository.fetchSearchData();

      if (result.success) {
        _allSearchData = result.data;
        debugPrint("Search Data : ${result.data.length.toString()}");
        debugPrint(searchText);
        filterSearchData(searchText);
      } else {
        debugPrint(result.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isAllsearchDataLoading = false;
      notifyListeners();
    }
  }

  void filterSearchData(String searchText) {
    debugPrint("Filtering with text: $searchText");

    if (searchText.isEmpty) {
      _filteredSearchData = [];
    } else {
      _filteredSearchData =
          _allSearchData
              .where(
                (item) =>
                    item.name.toLowerCase().contains(searchText.toLowerCase()),
              )
              .toList();
    }

    //     if (_filteredSearchData.isEmpty) {
    //       debugPrint("No matching items found.");
    //     } else {
    //       debugPrint("Filtered items (${_filteredSearchData.length}):");

    //       for (var item in _filteredSearchData) {
    //         debugPrint("""
    // -------------------------------
    // ID: ${item.id}
    // Name: ${item.name}
    // Description: ${item.description}
    // Image: ${item.img}
    // Weight: ${item.weight}
    // Pieces: ${item.pieces}
    // Serves: ${item.serves}
    // Price: ₹${item.price}
    // Discount: ${item.discount}%
    // Discount Price: ₹${item.discountPrice}
    // Available: ${item.available}
    // Notify: ${item.notify}
    // Best Seller: ${item.bestSellers}
    // Created At: ${item.createdAt}
    // Updated At: ${item.updatedAt}
    // -------------------------------
    // """);
    //       }
    // }

    notifyListeners();
  }
}
