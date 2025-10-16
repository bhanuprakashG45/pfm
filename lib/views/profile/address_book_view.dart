import 'package:geocoding/geocoding.dart';
import 'package:priya_fresh_meats/utils/exports.dart';

class AddressBookView extends StatefulWidget {
  const AddressBookView({super.key});

  @override
  State<AddressBookView> createState() => _AddressBookViewState();
}

class _AddressBookViewState extends State<AddressBookView> {
  final houseController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final postalCodeController = TextEditingController();
  final customAddressTypeController = TextEditingController();
  final searchController = TextEditingController();
  final addressTypeController = TextEditingController();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((value) async {
      final profileprovider = Provider.of<ProfileViewModel>(
        context,
        listen: false,
      );
      await profileprovider.fetchAllAddress();
    });
  }

  @override
  void dispose() {
    houseController.dispose();
    streetController.dispose();
    cityController.dispose();
    stateController.dispose();
    postalCodeController.dispose();
    customAddressTypeController.dispose();
    searchController.dispose();
    super.dispose();
  }

  Future<void> showDeleteAddressDialog(
    BuildContext context,
    String itemId,
  ) async {
    final colorscheme = Theme.of(context).colorScheme;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Consumer<ProfileViewModel>(
          builder: (context, provider, child) {
            return AlertDialog(
              backgroundColor: colorscheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16).r,
              ),
              title: Text(
                "Delete Address",
                style: GoogleFonts.roboto(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              content: Text(
                "Are you sure you want to delete this address?",
                style: GoogleFonts.roboto(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.secondaryBlack,
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorscheme.onPrimary,
                    foregroundColor: AppColor.primaryBlack,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: AppColor.dividergrey, width: 0.5),
                      borderRadius: BorderRadius.circular(30).r,
                    ),
                  ),
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorscheme.primary,
                    foregroundColor: colorscheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: AppColor.dividergrey, width: 0.5),
                      borderRadius: BorderRadius.circular(30).r,
                    ),
                  ),

                  onPressed:
                      provider.isAddressDeleting
                          ? null
                          : () async {
                            await provider.deleteAddress(itemId);
                            Navigator.of(context).pop(true);
                          },
                  child:
                      provider.isAddressDeleting
                          ? SizedBox(
                            height: 18.h,
                            width: 18.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                          : Text(
                            "Delete",
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                            ),
                          ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showAddAddressBottomSheet(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    nameController.clear();
    mobileController.clear();
    houseController.clear();
    streetController.clear();
    cityController.clear();
    stateController.clear();
    postalCodeController.clear();
    addressTypeController.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colorScheme.onPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          top: false,
          right: false,
          left: false,
          child: Consumer2<ProfileViewModel, LocationProvider>(
            builder: (context, provider, locationprovider, child) {
              return Padding(
                padding: EdgeInsets.only(
                  top: 20.h,
                  left: 16.w,
                  right: 16.w,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
                ),
                child: SingleChildScrollView(
                  child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setModalState) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              height: 4.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                color: AppColor.secondaryBlack,
                                borderRadius: BorderRadius.circular(10).r,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'Add New Address',
                            style: GoogleFonts.roboto(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColor.primaryBlack,
                            ),
                          ),
                          SizedBox(height: 16.h),

                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12).r,
                              ),
                            ),
                            onPressed: () async {
                              final result =
                                  await locationprovider
                                      .fetchAndSaveCurrentLocation();
                              if (result != null) {
                                customErrorToast(context, result);
                              } else {
                                final place =
                                    await Geolocator.getCurrentPosition();
                                final placemarks =
                                    await placemarkFromCoordinates(
                                      place.latitude,
                                      place.longitude,
                                    );
                                if (placemarks.isNotEmpty) {
                                  final p = placemarks.first;
                                  streetController.text =
                                      '${p.name ?? ''} , ${p.subLocality ?? ''}';

                                  cityController.text = p.locality ?? '';
                                  stateController.text =
                                      p.administrativeArea ?? '';
                                  postalCodeController.text =
                                      p.postalCode ?? '';
                                }
                              }
                            },
                            icon: Icon(
                              Icons.my_location,
                              color: colorScheme.onPrimary,
                              size: 20.sp,
                            ),
                            label:
                                locationprovider.isCurrentLocationLoading
                                    ? TweenAnimationBuilder(
                                      tween: IntTween(begin: 0, end: 3),
                                      duration: const Duration(
                                        milliseconds: 800,
                                      ),
                                      builder: (context, value, child) {
                                        String dots = "." * value;
                                        return Text(
                                          "Fetching$dots",
                                          style: GoogleFonts.roboto(
                                            fontSize: 16.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        );
                                      },
                                      onEnd: () {},
                                    )
                                    : Text(
                                      "Use Current Location",
                                      style: GoogleFonts.roboto(
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                          ),

                          SizedBox(height: 20.h),
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: 'Full Name *',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              labelStyle: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          TextField(
                            controller: mobileController,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            decoration: InputDecoration(
                              labelText: 'Mobile Number *',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              labelStyle: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),

                          DropdownButtonFormField<String>(
                            value:
                                addressTypeController.text.isNotEmpty
                                    ? addressTypeController.text
                                    : null,
                            decoration: InputDecoration(
                              labelText: 'Address Type*',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              labelStyle: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            items:
                                ['Home', 'Office', 'Other'].map((String type) {
                                  return DropdownMenuItem<String>(
                                    value: type,
                                    child: Text(type),
                                  );
                                }).toList(),
                            onChanged: (newValue) {
                              if (newValue != null) {
                                addressTypeController.text = newValue;
                              }
                            },
                          ),

                          SizedBox(height: 12.h),
                          TextField(
                            controller: houseController,
                            decoration: InputDecoration(
                              labelText: 'House Number / Flat *',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          TextField(
                            controller: streetController,
                            decoration: InputDecoration(
                              labelText: 'Street / Area *',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          TextField(
                            controller: cityController,
                            decoration: InputDecoration(
                              labelText: 'City *',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          TextField(
                            controller: stateController,
                            decoration: InputDecoration(
                              labelText: 'State *',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          TextField(
                            controller: postalCodeController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Postal Code *',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              backgroundColor: colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12).r,
                              ),
                              minimumSize: Size(double.infinity, 25.h),
                            ),
                            onPressed:
                                provider.isNewAddressAdding
                                    ? null
                                    : () async {
                                      if (nameController.text.isEmpty ||
                                          mobileController.text.isEmpty ||
                                          houseController.text.isEmpty ||
                                          streetController.text.isEmpty ||
                                          cityController.text.isEmpty ||
                                          stateController.text.isEmpty ||
                                          postalCodeController.text.isEmpty ||
                                          addressTypeController.text.isEmpty) {
                                        if (context.mounted) {
                                          customErrorToast(
                                            context,
                                            'Please fill all required fields',
                                          );
                                        }
                                        return;
                                      }

                                      final locationprovider =
                                          Provider.of<LocationProvider>(
                                            context,
                                            listen: false,
                                          );
                                      final name = nameController.text;
                                      final phone = mobileController.text;
                                      final type = addressTypeController.text;
                                      final houseNo = houseController.text;
                                      final streetname = streetController.text;
                                      final city = cityController.text;
                                      final state = stateController.text;
                                      final pincode = postalCodeController.text;

                                      final result = await locationprovider
                                          .getLatLngFromAddress(
                                            houseNo: houseNo,
                                            street: streetname,
                                            city: city,
                                            state: state,
                                            pincode: pincode,
                                          );

                                      double? latitude;
                                      double? longitude;

                                      if (result != null) {
                                        latitude = result["latitude"];
                                        longitude = result["longitude"];
                                        debugPrint(
                                          "Lat: $latitude, Lng: $longitude",
                                        );
                                      } else {
                                        debugPrint("Could not fetch location");
                                      }

                                      if (result != null) {
                                        await provider.addNewAddress(
                                          name,
                                          phone,
                                          houseNo,
                                          streetname,
                                          city,
                                          state,
                                          pincode,
                                          type,
                                          latitude.toString(),
                                          longitude.toString(),
                                        );
                                      }

                                      Navigator.pop(context);
                                    },
                            child:
                                provider.isNewAddressAdding
                                    ? SizedBox(
                                      height: 20.h,
                                      width: 20.w,
                                      child: CircularProgressIndicator(
                                        color: colorScheme.onPrimary,
                                        strokeWidth: 3.0.w,
                                      ),
                                    )
                                    : Text(
                                      'Submit',
                                      style: GoogleFonts.roboto(
                                        fontSize: 18.sp,
                                        color: colorScheme.onPrimary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      right: false,
      left: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Address Book',
            style: GoogleFonts.roboto(
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          backgroundColor: colorScheme.onPrimary,
          foregroundColor: AppColor.primaryBlack,
          shadowColor: colorScheme.onPrimary,
          elevation: 0.1,
        ),
        backgroundColor: colorScheme.onPrimary,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(8.dg),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              backgroundColor: colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            onPressed: () {
              _showAddAddressBottomSheet(context);
            },
            child: Text(
              'Add Address',
              style: GoogleFonts.roboto(
                fontSize: 18.sp,
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        body: Consumer2<ProfileViewModel, LocationProvider>(
          builder: (context, addressProvider, locationProvider, child) {
            final addresses = addressProvider.addressdata;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.w, top: 15.h),
                  child: InkWell(
                    onTap: () async {
                      final error =
                          await locationProvider.fetchAndSaveCurrentLocation();
                      await locationProvider.clearUserDetails();

                      if (context.mounted) {
                        if (error != null) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(error)));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Location updated: ${locationProvider.fullAddress}',
                              ),
                            ),
                          );
                        }
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                        border: Border.all(
                          color: AppColor.pastelBrown,
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.my_location,
                            color: colorScheme.onPrimary,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),

                          locationProvider.isCurrentLocationLoading
                              ? TweenAnimationBuilder(
                                tween: IntTween(begin: 0, end: 3),
                                duration: const Duration(milliseconds: 800),
                                builder: (context, value, child) {
                                  String dots = "." * value;
                                  return Text(
                                    "Fetching$dots",
                                    style: GoogleFonts.roboto(
                                      fontSize: 16.sp,
                                      color: colorScheme.onPrimary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                },
                                onEnd: () {},
                              )
                              : Text(
                                "Use Current Location",
                                style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.onPrimary,
                                ),
                              ),
                        ],
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Skeletonizer(
                    enabled: addressProvider.isAddressLoading,
                    child:
                        addresses.isEmpty
                            ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppImages.emptyAddress,
                                  height: 290.h,
                                  width: 290.w,
                                ),
                                Center(
                                  child: Text(
                                    'No addresses added yet.',
                                    style: GoogleFonts.roboto(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ],
                            )
                            : ListView.separated(
                              separatorBuilder:
                                  (context, index) => SizedBox(height: 20.h),
                              padding: EdgeInsets.all(16.w),
                              itemCount: addresses.length,
                              itemBuilder: (context, index) {
                                final address = addresses[index];
                                return InkWell(
                                  onTap: () async {
                                    final fullAddress =
                                        " ${address.street}, ${address.city}, ${address.state}, ${address.pincode}";
                                    await locationProvider.storeUserDetails(
                                      address.houseNo,
                                      address.name,
                                      address.phone,
                                    );

                                    await locationProvider.saveLocation(
                                      address.street,
                                      fullAddress,
                                      address.pincode,
                                      address.latitude,
                                      address.longitude,
                                    );
                                    await locationProvider.loadUserDetails();
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: colorScheme.onPrimary,
                                      borderRadius: BorderRadius.circular(12).r,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColor.dividergrey,
                                          blurRadius: 1,
                                          spreadRadius: 2,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                      border:
                                          address.isSelected
                                              ? Border.all(
                                                color: AppColor.greenGrad1,
                                                width: 1,
                                              )
                                              : null,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12.h,
                                        horizontal: 16.w,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.home,
                                                size: 30.sp,
                                                color: colorScheme.primary,
                                              ),
                                              SizedBox(width: 10.w),
                                              Text(
                                                address.type,
                                                style: GoogleFonts.roboto(
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),

                                          Divider(
                                            color: AppColor.greytext,
                                            thickness: 0.5,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.person,
                                                size: 22.sp,
                                                color: colorScheme.primary,
                                              ),
                                              SizedBox(width: 10.w),
                                              Text(
                                                address.name,
                                                style: GoogleFonts.roboto(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      AppColor.secondaryBlack,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 6.h),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.phone,
                                                size: 22.sp,
                                                color: colorScheme.primary,
                                              ),
                                              SizedBox(width: 10.w),
                                              Text(
                                                address.phone,
                                                style: GoogleFonts.roboto(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      AppColor.secondaryBlack,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 6.h),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                size: 22.sp,
                                                color: colorScheme.primary,
                                              ),
                                              SizedBox(width: 10.w),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${address.houseNo}, ${address.street}',
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            AppColor
                                                                .secondaryBlack,
                                                      ),
                                                    ),
                                                    SizedBox(height: 4.h),
                                                    Text(
                                                      '${address.city}, ${address.state} - ${address.pincode}',
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColor
                                                                .secondaryBlack,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 8.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      colorScheme.onPrimary,
                                                  foregroundColor:
                                                      AppColor.primaryBlack,
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      color:
                                                          AppColor.dividergrey,
                                                      width: 0.5,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          30,
                                                        ).r,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.white,
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                            top:
                                                                Radius.circular(
                                                                  16,
                                                                ),
                                                          ),
                                                    ),
                                                    builder: (context) {
                                                      return EditAddressBottomSheet(
                                                        name: address.name,
                                                        mobile: address.phone,
                                                        id: address.id,
                                                        houseNo:
                                                            address.houseNo,
                                                        street: address.street,
                                                        city: address.city,
                                                        state: address.state,
                                                        postalCode:
                                                            address.pincode,
                                                        addressType:
                                                            address.type,
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Row(
                                                  children: [
                                                    FaIcon(
                                                      FontAwesomeIcons
                                                          .penToSquare,
                                                      size: 18.sp,
                                                      color: AppColor.black,
                                                    ),
                                                    SizedBox(width: 6.w),
                                                    Text(
                                                      'Edit',
                                                      style: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 8.w),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      colorScheme.onPrimary,
                                                  foregroundColor:
                                                      AppColor.primaryBlack,
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      color:
                                                          AppColor.dividergrey,
                                                      width: 0.5,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          30,
                                                        ).r,
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  await showDeleteAddressDialog(
                                                    context,
                                                    address.id,
                                                  );
                                                  debugPrint(
                                                    'Delete address: ${address.houseNo}',
                                                  );
                                                },
                                                child: Row(
                                                  children: [
                                                    FaIcon(
                                                      FontAwesomeIcons.trashCan,
                                                      size: 18.sp,
                                                      color:
                                                          AppColor.black,
                                                    ),
                                                    SizedBox(width: 6.w),
                                                    Text(
                                                      'Delete',
                                                      style: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // if (!address.isSelected) ...[
                                              //   SizedBox(width: 8.w),
                                              //   ElevatedButton(
                                              //     style: ElevatedButton.styleFrom(
                                              //       backgroundColor:
                                              //           colorScheme.onPrimary,
                                              //       foregroundColor:
                                              //           AppColor.primaryBlack,
                                              //       shape: RoundedRectangleBorder(
                                              //         side: BorderSide(
                                              //           color:
                                              //               AppColor
                                              //                   .dividergrey,
                                              //           width: 0.5,
                                              //         ),
                                              //         borderRadius:
                                              //             BorderRadius.circular(
                                              //               30,
                                              //             ).r,
                                              //       ),
                                              //     ),
                                              //     onPressed:
                                              //         addressProvider
                                              //                 .isAddressUpdating
                                              //             ? null
                                              //             : () async {
                                              //               await addressProvider
                                              //                   .updateDeFaultAddress(
                                              //                     address.id,
                                              //                   );
                                              //             },

                                              //     child:
                                              //         addressProvider
                                              //                 .isAddressUpdating
                                              //             ? SizedBox(
                                              //               height: 10.h,
                                              //               width: 10.w,
                                              //               child: CircularProgressIndicator(
                                              //                 color:
                                              //                     colorScheme
                                              //                         .primary,
                                              //                 strokeWidth:
                                              //                     2.0.w,
                                              //               ),
                                              //             )
                                              //             : Text(
                                              //               'Default',
                                              //               style:
                                              //                   GoogleFonts.roboto(
                                              //                     fontSize:
                                              //                         15.sp,
                                              //                     fontWeight:
                                              //                         FontWeight
                                              //                             .w500,
                                              //                   ),
                                              //             ),
                                              //   ),
                                              // ],
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
