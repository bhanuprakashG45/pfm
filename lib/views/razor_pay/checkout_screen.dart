// import 'package:flutter/material.dart';
// import 'package:priya_fresh_meats/viewmodels/razorpay_vm/razorpay_viewmodel.dart';
// import 'package:provider/provider.dart';

// class CheckoutScreen extends StatefulWidget {
//   final String amountInRupees;

//   const CheckoutScreen({super.key, required this.amountInRupees});

//   @override
//   State<CheckoutScreen> createState() => _CheckoutScreenState();
// }

// class _CheckoutScreenState extends State<CheckoutScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((value) {
//       final provider = Provider.of<RazorpayViewmodel>(context, listen: false);

//       provider.initRazorpay();
//       _openRazorpay(provider);
//     });
//   }

//   void _openRazorpay(RazorpayViewmodel provider) {
//     final double amountInRupees = double.tryParse(widget.amountInRupees) ?? 0.0;
//     final int amountInPaise = (amountInRupees * 100).round();

//     if (amountInPaise <= 0) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Invalid amount")));
//       Navigator.pop(context);
//       return;
//     }

//     provider.startPayment(
//       amountInPaise,
//       "Test User",
//       "9876543210",
//       "test@example.com",
//     );
//   }

//   @override
//   void dispose() {
//     // _razorpayVm.disposeRazorpay();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<RazorpayViewmodel>(
//       builder: (context, vm, _) {
//         return Scaffold(
//           body: SafeArea(
//             top: false,
//             child: Center(child: const CircularProgressIndicator()),
//           ),
//         );
//       },
//     );
//   }
// }
