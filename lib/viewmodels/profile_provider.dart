import 'package:flutter/material.dart';

class Address {
  final String house;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String? addressType;

  Address({
    required this.house,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    this.addressType,
  });
}

class ProfileProvider with ChangeNotifier {
  List<Address> _addresses = [];

  List<Address> get addresses => _addresses;

  void addAddress({
    required String house,
    required String street,
    required String city,
    required String state,
    required String postalCode,
    String? addressType,
  }) {
    final newAddress = Address(
      house: house,
      street: street,
      city: city,
      state: state,
      postalCode: postalCode,
      addressType: addressType,
    );
    _addresses.add(newAddress);
    notifyListeners(); // Notify UI to rebuild with updated address list
  }

  // Optional: Method to clear all addresses (for testing or reset)
  void clearAddresses() {
    _addresses.clear();
    notifyListeners();
  }
}