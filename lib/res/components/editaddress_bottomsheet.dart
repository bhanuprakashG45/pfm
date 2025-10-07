import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priya_fresh_meats/utils/exports.dart';
import 'package:priya_fresh_meats/viewmodels/profile_vm/profile_view_model.dart';

class EditAddressBottomSheet extends StatefulWidget {
  final String id;
  final String houseNo;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String addressType;

  const EditAddressBottomSheet({
    super.key,
    required this.id,
    required this.houseNo,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.addressType,
  });

  @override
  State<EditAddressBottomSheet> createState() => _EditAddressBottomSheetState();
}

class _EditAddressBottomSheetState extends State<EditAddressBottomSheet> {
  late TextEditingController houseController;
  late TextEditingController streetController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController postalCodeController;

  String? selectedAddressType;

  @override
  void initState() {
    super.initState();
    houseController = TextEditingController(text: widget.houseNo);
    streetController = TextEditingController(text: widget.street);
    cityController = TextEditingController(text: widget.city);
    stateController = TextEditingController(text: widget.state);
    postalCodeController = TextEditingController(text: widget.postalCode);
    selectedAddressType = widget.addressType;
  }

  @override
  void dispose() {
    houseController.dispose();
    streetController.dispose();
    cityController.dispose();
    stateController.dispose();
    postalCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer<ProfileViewModel>(
      builder: (context, provider, child) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 4,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Edit Address",
                  style: GoogleFonts.roboto(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),

                DropdownButtonFormField<String>(
                  value: selectedAddressType,
                  decoration: InputDecoration(
                    labelText: "Address Type",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items:
                      ["Home", "Work", "Other"].map((type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedAddressType = value;
                    });
                  },
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: houseController,
                  decoration: InputDecoration(
                    labelText: "House Number / Flat",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                TextField(
                  controller: streetController,
                  decoration: InputDecoration(
                    labelText: "Street / Area",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                TextField(
                  controller: cityController,
                  decoration: InputDecoration(
                    labelText: "City",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: stateController,
                  decoration: InputDecoration(
                    labelText: "State",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                TextField(
                  controller: postalCodeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Postal Code",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    await provider.updateAddress(
                      context,
                      widget.id,
                      houseController.text,
                      streetController.text,
                      cityController.text,
                      stateController.text,
                      postalCodeController.text,
                      selectedAddressType!,
                    );
                    Navigator.of(context).pop();
                  },
                  child:
                      provider.isAddressUpdating
                          ? SizedBox(
                            height: 20.0.h,
                            width: 20.w,
                            child: CircularProgressIndicator(
                              color: colorScheme.onPrimary,
                              strokeWidth: 2.0.w,
                            ),
                          )
                          : Text(
                            "Update",
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
