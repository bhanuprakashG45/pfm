import 'package:http/http.dart' as http;
import 'package:priya_fresh_meats/data/models/razorpay/razorpay_response.dart';
import 'package:priya_fresh_meats/utils/exports.dart';

class RazorpayRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<RazorpayOrderResponse?> initPayment(double amount) async {
    try {
      final String credentials = base64Encode(
        utf8.encode("${AppUrls.keyId}:${AppUrls.keySecret}"),
      );

      final url = Uri.parse("https://api.razorpay.com/v1/orders");
      final body = {
        "amount": (amount * 100).round(),
        "currency": "INR",
        "receipt": "order_rcptid_${DateTime.now().millisecondsSinceEpoch}",
        "payment_capture": 1,
      };

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Basic $credentials',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return RazorpayOrderResponse.fromJson(data);
      } else {
        debugPrint("Error creating order: ${response.body}");
        return null;
      }
    } catch (e) {
      debugPrint("Unexpected error in initPayment: $e");
      return null;
    }
  }

  Future<void> verifyPayment({
    required BuildContext context,
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
    required VoidCallback onSucess,
  }) async {
    try {
      var body = {
        "razorpay_payment_id": razorpayPaymentId,
        "razorpay_order_id": razorpayOrderId,
        "razorpay_signature": razorpaySignature,
      };

      final response = await _apiServices.postApiResponse(
        AppUrls.verifyPaymentUrl,
        body,
      );

      if (response["success"] == true) {
        onSucess();
        debugPrint("Payment verified successfully");
      } else {
        debugPrint("Payment verification failed : ${response.toString()}");
      }
    } catch (e) {
      debugPrint("Error in verifyPayment: $e");
    }
  }
}
