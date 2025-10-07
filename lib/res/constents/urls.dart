class AppUrls {
  static const String baseUrl = "https://api.priyafreshmeats.com";

  //Authentication
  static const String sendOtp = "$baseUrl/customer/send-otp";
  static const String verifyOtp = "$baseUrl/customer/verify-login";
  static const String refreshToken = "$baseUrl/customer/refresh-token";

  //Profile
  static const String deleteAccountUrl = '$baseUrl/customer/delete-account';
  static const String getcontact = "$baseUrl/customer/contact-us";
  static const String fetchNotificationsUrl =
      '$baseUrl/customer/get-notefication';
  static const String fetchProfileUrl = '$baseUrl/customer/profile';
  static const String updateProfileUrl = '$baseUrl/customer/update-profile';

  //Categories
  static const String shopcategories = "$baseUrl/customer/allCategories";
  static const String categoriestypes = "$baseUrl/customer/categories-types";
  static const String subcategoriesboxes =
      "$baseUrl/customer/type-categories-all-card";
  static const String itemDetailsView =
      "$baseUrl/customer/full-details-of-sub-categorie-card";
  static const String deleteItemUrl = '$baseUrl/customer/cart';

  //Home
  static const String bestSellersUrl =
      '$baseUrl/customer/bestSellingProducts';
  static const String shopbyCategoryUrl =
      '$baseUrl/customer/allCategories?limit=8';
  static const String shopbysubCategoryUrl =
      '$baseUrl/customer/allCategories-subProducts';
  static const String notifymeUrl = '$baseUrl/customer/notify';

  //Cart
  static const String addToCartUrl = '$baseUrl/customer/cart/';
  static const String updateCountUrl = '$baseUrl/customer/cart/';
  static const String fetchCartUrl = '$baseUrl/customer/cart-details';
  static const String fetchCartItemsUrl = '$baseUrl/customer/cart';
  static const String fetchCouponsUrl = '$baseUrl/customer/coupons';
  static const String walletUrl = '$baseUrl/customer/wallet';

  //Orders
  static const String placeOrderUrl = '$baseUrl/customer/create-order';
  static const String searchShopByCategoryUrl =
      '$baseUrl/customer/allCategories';
  static const String sendDeviceTokenUrl = '$baseUrl/deviceToken';
  static const String orderHistoryUrl = '$baseUrl/customer/order-history';
  static const String orderDetailsUrl = '$baseUrl/customer/order-details';
  static const String deleteOrderHistoryUrl =
      '$baseUrl/customer/delete-order-history';
  static const String reorderUrl = '$baseUrl/customer/re-order';
  static const String trackorderUrl = '$baseUrl/customer/order-status';
  static const String activeOrderUrl = '$baseUrl/customer/user-all-order';
  static const String cancelorderUrl = '$baseUrl/customer/cancel-order';

  //Search
  static const String searchByNameUrl = '$baseUrl/customer/search-item?name=';
  static const String searchDataUrl =
      '$baseUrl/customer/display-all-subcategory';

  //Address
  static const String addAddressUrl = '$baseUrl/customer/address';
  static const String getAllAddedAddressUrl = '$baseUrl/customer/address';
  static const String updateAddressUrl = '$baseUrl/customer/address';
  static const String deleteAddressUrl = '$baseUrl/customer/address';

  //RazorPay
  static const String razorpayUrl = 'https://api.razorpay.com/v1/orders';
  static const String keyId = 'rzp_test_R9sbSkX4NbwNms';
  static const String keySecret = 'wA4M56LEryw6de2vR6bxn07L';
  static const String initPaymentUrl = '$razorpayUrl/payments/initiate';
  static const String verifyPaymentUrl = '$baseUrl/payments/verify';
  static const String storePaymentDetailsUrl = '$baseUrl/payments/store';
}
