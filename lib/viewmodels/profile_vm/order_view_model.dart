import 'package:priya_fresh_meats/data/models/profile/orders/active_order_model.dart';
import 'package:priya_fresh_meats/data/models/profile/orders/order_details_model.dart';
import 'package:priya_fresh_meats/data/models/profile/orders/track_order_model.dart';
import 'package:priya_fresh_meats/data/repository/profile_rep/order_repository.dart';
import 'package:priya_fresh_meats/utils/exports.dart';

class OrderViewModel with ChangeNotifier {
  final OrderRepository _repository = OrderRepository();

  List<OrderHistory> _orderHistoryData = [];
  List<OrderHistory> get orderHistoryData => _orderHistoryData;

  bool _isOrderHistoryLoading = false;
  bool get isOrderHistoryLoading => _isOrderHistoryLoading;

  set isOrderHistoryLoading(bool value) {
    _isOrderHistoryLoading = value;
    notifyListeners();
  }

  OrderDetailsData _orderDetailsdata = OrderDetailsData(
    store: StoreDetails(),
    billDetails: BillDetails(),
    deliveryAddress: DeliveryAddress(),
    timestamps: TimestampsDetails(createdAt: DateTime.now()),
  );
  OrderDetailsData get orderDetailsdata => _orderDetailsdata;
  bool _isOrderDetailsLoading = false;
  bool get isOrderDetailsLoading => _isOrderDetailsLoading;

  set isOrderDetailsLoading(bool value) {
    _isOrderDetailsLoading = value;
    notifyListeners();
  }

  bool _isOrderDeleting = false;
  bool get isOrderDeleting => _isOrderDeleting;

  set isOrderDeleting(bool value) {
    _isOrderDeleting = value;
    notifyListeners();
  }

  bool _isReOrdering = false;
  bool get isReOrdering => _isReOrdering;
  set isReOrdering(bool value) {
    _isReOrdering = value;
    notifyListeners();
  }

  TrackorderData _trackorderData = TrackorderData(
    orderId: '',
    status: '',
    deliveryStatus: '',
    stages: Stages(
      pending: false,
      accepted: false,
      pickedUp: false,
      inTransit: false,
      delivered: false,
      cancelled: false,
      rejected: false,
    ),
    displayOrder: DisplayOrder(
      geoLocation: TrackGeoLocation(type: '', coordinates: []),
      id: '',
      customer: '',
      clientName: '',
      location: '',
      pincode: '',
      orderDetails: [],
      phone: '',
      amount: 0,
      status: '',
      store: '',
      manager: '',
      notes: '',
      isUrgent: false,
      deliveryStatus: '',
      deliveryRejectionReason: '',
      reason: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      v: 0,
    ),
  );

  TrackorderData get trackorderdata => _trackorderData;

  bool _isTrackOrderFetching = false;
  bool get isTrackOrderFetching => _isTrackOrderFetching;
  set isTrackOrderFetching(bool value) {
    _isTrackOrderFetching = value;
    notifyListeners();
  }

  List<ActiveOrderData> _activeOrderdata = [];

  List<ActiveOrderData> get activeorderData => _activeOrderdata;

  bool _isActiveordersLoading = false;
  bool get isActiveOrderLoading => _isActiveordersLoading;

  set isActiveOrderLoading(bool value) {
    _isActiveordersLoading = value;
    notifyListeners();
  }

  bool _isOrderCancelling = false;
  bool get isOrderCancelling => _isOrderCancelling;
  set isOrderCancelling(bool value) {
    _isOrderCancelling = value;
    notifyListeners();
  }

  Future<void> fetchOrderHistory() async {
    isOrderHistoryLoading = true;
    try {
      final response = await _repository.fetchHistory();

      if (response.success) {
        _orderHistoryData = response.data;
      } else {
        debugPrint(response.message);
        _orderHistoryData = [];
      }
    } catch (e) {
      debugPrint("Error fetching order history: $e");
      _orderHistoryData = [];
    } finally {
      isOrderHistoryLoading = false;
    }
  }

  Future<void> fetchOrderDetails(String orderId) async {
    isOrderDetailsLoading = true;
    try {
      final response = await _repository.fetchOrderDetails(orderId);

      if (response.success) {
        _orderDetailsdata = response.data;
      } else {
        debugPrint(response.message);
        _orderHistoryData = [];
      }
    } catch (e) {
      debugPrint("Error fetching order history: $e");
      _orderHistoryData = [];
    } finally {
      isOrderDetailsLoading = false;
    }
  }

  Future<void> deleteOrderHistory(BuildContext context, String orderId) async {
    isOrderDeleting = true;
    try {
      final response = await _repository.deleteOrderHistory(orderId);
      if (response.success) {
        await fetchOrderHistory();
      } else {
        if (context.mounted) {
          customErrorToast(context, response.message);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isOrderDeleting = false;
    }
  }

  Future<void> reorderfromHistory(BuildContext context, String itemId) async {
    isReOrdering = true;
    try {
      final response = await _repository.reOrder(itemId);
      if (response.success) {
        if (context.mounted) {
          customSuccessToast(context, "Items Ready for Re order");
          Navigator.pushNamed(context, AppRoutes.cartView);
        }
      } else {
        if (context.mounted) {
          customErrorToast(context, "Failed to Reorder This Time");
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isReOrdering = false;
    }
  }

  Future<void> fetchTrackOrder(String itemId) async {
    isTrackOrderFetching = true;
    try {
      final response = await _repository.fetchTrackOrder(itemId);
      if (response.success) {
        _trackorderData = response.data;
      } else {
        debugPrint(response.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isTrackOrderFetching = false;
    }
  }

  Future<void> fetchActiveOrders() async {
    isActiveOrderLoading = true;
    try {
      final response = await _repository.fetchActiveorders();
      if (response.success) {
        _activeOrderdata = response.data;
      } else {
        debugPrint(response.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isActiveOrderLoading = false;
    }
  }

  Future<void> cancelOrder(
    BuildContext context,
    String orderId,
    String reason,
  ) async {
    isOrderCancelling = true;
    try {
      final response = await _repository.cancelOrder(orderId, reason);
      if (response.message == "Order cancelled successfully") {
        debugPrint(response.message);
      } else {
        debugPrint(response.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    }finally{
      isOrderCancelling = false;
    }
  }
}
