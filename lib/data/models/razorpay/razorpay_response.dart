class RazorpayOrderResponse {
  final String id;
  final String entity;
  final int amount;
  final int amountDue;
  final int amountPaid;
  final int attempts;
  final int createdAt;
  final String currency;
  final String receipt;
  final String status;
  final List<dynamic> notes;
  final String? offerId;

  RazorpayOrderResponse({
    required this.id,
    required this.entity,
    required this.amount,
    required this.amountDue,
    required this.amountPaid,
    required this.attempts,
    required this.createdAt,
    required this.currency,
    required this.receipt,
    required this.status,
    required this.notes,
    this.offerId,
  });

  factory RazorpayOrderResponse.fromJson(Map<String, dynamic>? json) {
    return RazorpayOrderResponse(
      id: json?['id'] ?? '',
      entity: json?['entity'] ?? '',
      amount: (json?['amount'] as num?)?.toInt() ?? 0,
      amountDue: (json?['amount_due'] as num?)?.toInt() ?? 0,
      amountPaid: (json?['amount_paid'] as num?)?.toInt() ?? 0,
      attempts: (json?['attempts'] as num?)?.toInt() ?? 0,
      createdAt: (json?['created_at'] as num?)?.toInt() ?? 0,
      currency: json?['currency'] ?? '',
      receipt: json?['receipt'] ?? '',
      status: json?['status'] ?? '',
      notes: (json?['notes'] as List?) ?? [],
      offerId: json?['offer_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "entity": entity,
      "amount": amount,
      "amount_due": amountDue,
      "amount_paid": amountPaid,
      "attempts": attempts,
      "created_at": createdAt,
      "currency": currency,
      "receipt": receipt,
      "status": status,
      "notes": notes,
      "offer_id": offerId,
    };
  }
}
