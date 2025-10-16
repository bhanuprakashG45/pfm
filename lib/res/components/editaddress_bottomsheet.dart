import 'package:priya_fresh_meats/utils/exports.dart';

class EditAddressBottomSheet extends StatefulWidget {
  final String id;
  final String name;
  final String mobile;
  final String houseNo;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String addressType;

  const EditAddressBottomSheet({
    super.key,
    required this.id,
    required this.name,
    required this.mobile,
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
  late TextEditingController nameController;
  late TextEditingController mobileController;
  late TextEditingController houseController;
  late TextEditingController streetController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController postalCodeController;

  String? selectedAddressType;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    mobileController = TextEditingController(text: widget.mobile);
    houseController = TextEditingController(text: widget.houseNo);
    streetController = TextEditingController(text: widget.street);
    cityController = TextEditingController(text: widget.city);
    stateController = TextEditingController(text: widget.state);
    postalCodeController = TextEditingController(text: widget.postalCode);
    selectedAddressType = widget.addressType;
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    houseController.dispose();
    streetController.dispose();
    cityController.dispose();
    stateController.dispose();
    postalCodeController.dispose();
    super.dispose();
  }

  bool _validateFields() {
    if (nameController.text.trim().isEmpty ||
        mobileController.text.trim().isEmpty ||
        houseController.text.trim().isEmpty ||
        streetController.text.trim().isEmpty ||
        cityController.text.trim().isEmpty ||
        stateController.text.trim().isEmpty ||
        postalCodeController.text.trim().isEmpty ||
        selectedAddressType == null) {
      customErrorToast(context, "All fields are required");
      return false;
    }
    if (mobileController.text.length != 10) {
      customErrorToast(context, 'Enter valid 10-digit mobile number');
      return false;
    }
    if (postalCodeController.text.length < 6) {
      customErrorToast(context, 'Enter valid postal code');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer<ProfileViewModel>(
      builder: (context, provider, child) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.only(
              top: 20.h,
              left: 16.w,
              right: 16.w,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 4.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10).r,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Edit Address",
                    style: GoogleFonts.roboto(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Full Name *",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12).r,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  TextField(
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: InputDecoration(
                      counterText: "",
                      labelText: "Mobile Number *",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12).r,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  DropdownButtonFormField<String>(
                    value: selectedAddressType,
                    decoration: InputDecoration(
                      labelText: "Address Type *",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12).r,
                      ),
                    ),
                    items:
                        ["Home", "Office", "Other"].map((type) {
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
                  SizedBox(height: 12.h),

                  TextField(
                    controller: houseController,
                    decoration: InputDecoration(
                      labelText: "House Number / Flat *",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12).r,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  TextField(
                    controller: streetController,
                    decoration: InputDecoration(
                      labelText: "Street / Area *",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  TextField(
                    controller: cityController,
                    decoration: InputDecoration(
                      labelText: "City *",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12).r,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  TextField(
                    controller: stateController,
                    decoration: InputDecoration(
                      labelText: "State *",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12).r,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  TextField(
                    controller: postalCodeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Postal Code *",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12).r,
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      minimumSize: Size(double.infinity, 48.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12).r,
                      ),
                    ),
                    onPressed: () async {
                      if (_validateFields()) {
                        await provider.updateAddress(
                          context,
                          widget.id,
                          nameController.text,
                          mobileController.text,
                          houseController.text,
                          streetController.text,
                          cityController.text,
                          stateController.text,
                          postalCodeController.text,
                          selectedAddressType!,
                        );
                        Navigator.of(context).pop();
                      }
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
                                fontSize: 18.sp,
                                color: colorScheme.onPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
