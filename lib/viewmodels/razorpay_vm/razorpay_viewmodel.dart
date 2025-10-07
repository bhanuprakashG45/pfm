import 'package:priya_fresh_meats/data/models/razorpay/razorpay_response.dart';
import 'package:priya_fresh_meats/data/repository/razorpay_rep/razorpay_repository.dart';
import 'package:priya_fresh_meats/utils/exports.dart';

class RazorpayViewmodel with ChangeNotifier {
  final RazorpayRepository _repository = RazorpayRepository();

  String? razorpayOrderId;
  String? razorpayPaymentId;
  String? razorpaySignature;

  Future<RazorpayOrderResponse?> initpayment(double amount) async {
    try {
      final response = await _repository.initPayment(amount);
      if (response != null) {
        razorpayOrderId = response.id;
        notifyListeners();
        debugPrint("OrderId after initPayment : ${response.id}");
        debugPrint("orderAmount : ${response.amount}");
      }
      return response;
    } catch (e) {
      debugPrint("Error in initpayment: $e");
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
      this.razorpayOrderId = razorpayOrderId;
      this.razorpayPaymentId = razorpayPaymentId;
      this.razorpaySignature = razorpaySignature;

      await _repository.verifyPayment(
        context: context,
        razorpayOrderId: razorpayOrderId,
        razorpayPaymentId: razorpayPaymentId,
        razorpaySignature: razorpaySignature,
        onSucess: onSucess,
      );
    } catch (e) {
      debugPrint("Error in verifyPayment: $e");
    }
  }
}
