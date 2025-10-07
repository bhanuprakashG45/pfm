import 'package:priya_fresh_meats/res/components/login_bottomsheet.dart';
import 'package:priya_fresh_meats/utils/exports.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String? userId;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((value) async {
      _loadUserId();
      final provider = Provider.of<ProfileViewModel>(context, listen: false);
      await provider.fetchProfileDetails();
    });
  }

  void _loadUserId() async {
    final pref = SharedPref();
    final id = await pref.getUserId();

    setState(() {
      userId = id.isNotEmpty ? id : null;
      debugPrint('Loaded userId: $userId');
    });
  }

  void _showEditDialog(String name, String email) {
    final nameController = TextEditingController(text: name);
    final emailController = TextEditingController(text: email);
    final colorscheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder:
          (ctx) => Consumer<ProfileViewModel>(
            builder: (context, provider, child) {
              return AlertDialog(
                backgroundColor: AppColor.offWhite2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                title: Text(
                  "Edit Profile",
                  style: GoogleFonts.roboto(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: GoogleFonts.roboto(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: colorscheme.primary,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter your name",
                      ),
                    ),
                    SizedBox(height: 16.h),

                    Text(
                      "Email",
                      style: GoogleFonts.roboto(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: colorscheme.primary,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter your email",
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorscheme.onPrimary,
                      foregroundColor: colorscheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15).r,
                      ),
                    ),
                    onPressed: () => Navigator.pop(ctx),
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.roboto(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorscheme.primary,
                      foregroundColor: colorscheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15).r,
                      ),
                    ),
                    onPressed:
                        provider.isProfileUpdating || provider.isProfileLoading
                            ? null
                            : () async {
                              await provider.updateProfile(
                                context,
                                nameController.text,
                                emailController.text,
                              );
                            },
                    child:
                        provider.isProfileUpdating || provider.isProfileLoading
                            ? SizedBox(
                              height: 10.h,
                              width: 10.w,
                              child: CircularProgressIndicator(
                                color: colorscheme.primary,
                                strokeWidth: 2.0.w,
                              ),
                            )
                            : Text(
                              "Save",
                              style: GoogleFonts.roboto(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                  ),
                ],
              );
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final actions = <_ProfileAction>[
      if (userId != null) ...[
        _ProfileAction(
          icon: Icons.restaurant_menu_outlined,
          label: 'Orders',
          onTap: () => Navigator.pushNamed(context, AppRoutes.ordersView),
        ),
        _ProfileAction(
          icon: FontAwesomeIcons.addressCard,
          label: 'Address',
          onTap: () => Navigator.pushNamed(context, AppRoutes.addressBook),
        ),
        _ProfileAction(
          icon: Icons.wallet,
          label: 'Wallet',
          onTap: () => Navigator.pushNamed(context, AppRoutes.walletView),
        ),
        _ProfileAction(
          icon: FontAwesomeIcons.bell,
          label: 'Notifications',
          onTap: () => Navigator.pushNamed(context, AppRoutes.notificationView),
        ),
        _ProfileAction(
          icon: Icons.phone_sharp,
          label: 'Contact Us',
          onTap: () => Navigator.pushNamed(context, AppRoutes.contactUs),
        ),
        _ProfileAction(
          icon: Icons.location_on,
          label: 'Track Order',
          onTap: () => Navigator.pushNamed(context, AppRoutes.activeOrders),
        ),
        _ProfileAction(
          icon: Icons.post_add_outlined,
          label: 'Terms & conditions',
          onTap:
              () => Navigator.pushNamed(
                context,
                AppRoutes.termsAndConditionsView,
              ),
        ),
        _ProfileAction(
          icon: Icons.question_mark_rounded,
          label: 'FAQs',
          onTap: () => Navigator.pushNamed(context, AppRoutes.faqsview),
        ),
        _ProfileAction(
          icon: Icons.privacy_tip_outlined,
          label: 'Privacy policy',
          onTap:
              () => Navigator.pushNamed(context, AppRoutes.privacyPolicyView),
        ),
        _ProfileAction(
          icon: Icons.notification_important_outlined,
          label: 'Cancellation & Reschedule Policy',
          onTap:
              () => Navigator.pushNamed(context, AppRoutes.cancellationPolicy),
        ),
        _ProfileAction(
          icon: FontAwesomeIcons.trashCan,
          label: 'Delete Account',
          onTap: () => showDeleteAccountDialog(context),
        ),
        _ProfileAction(
          icon: FontAwesomeIcons.arrowRightFromBracket,
          label: 'Logout',
          onTap: () => showLogoutDialog(context),
        ),
      ] else ...[
        _ProfileAction(
          icon: Icons.phone_sharp,
          label: 'Contact Us',
          onTap: () => Navigator.pushNamed(context, AppRoutes.contactUs),
        ),
        _ProfileAction(
          icon: Icons.post_add_outlined,
          label: 'Terms & conditions',
          onTap:
              () => Navigator.pushNamed(
                context,
                AppRoutes.termsAndConditionsView,
              ),
        ),
        _ProfileAction(
          icon: Icons.question_mark_rounded,
          label: 'FAQs',
          onTap: () => Navigator.pushNamed(context, AppRoutes.faqsview),
        ),
        _ProfileAction(
          icon: Icons.privacy_tip_outlined,
          label: 'Privacy policy',
          onTap:
              () => Navigator.pushNamed(context, AppRoutes.privacyPolicyView),
        ),
        _ProfileAction(
          icon: Icons.notification_important_outlined,
          label: 'Cancellation & Reschedule Policy',
          onTap:
              () => Navigator.pushNamed(context, AppRoutes.cancellationPolicy),
        ),
      ],
    ];

    return Scaffold(
      backgroundColor: colorScheme.onPrimary,
      body: SafeArea(
        top: false,
        child: Consumer<ProfileViewModel>(
          builder: (context, provider, child) {
            final profile = provider.profiledata;
            return Column(
              children: [
                provider.isProfileLoading || provider.isProfileUpdating
                    ? Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 60.h,
                        horizontal: 20.w,
                      ),
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 30.h,
                        width: 30.w,
                        child: CircularProgressIndicator(
                          color: colorScheme.primary,
                          strokeWidth: 2.0.w,
                        ),
                      ),
                    )
                    : Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                        top: 60.h,
                        bottom: 10.h,
                        left: 20.w,
                        right: 20.w,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.onPrimary,
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.dividergrey,
                            spreadRadius: 2,
                            blurRadius: 1,
                            offset: Offset(0, 0),
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25.r),
                          bottomRight: Radius.circular(25.r),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child:
                                    profile.name.isEmpty
                                        ? Text(
                                          "New User",
                                          style: GoogleFonts.roboto(
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                        : Text(
                                          profile.name,
                                          style: GoogleFonts.roboto(
                                            fontSize: 23.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  if (userId == null) {
                                    showLoginBottomSheet(
                                      context,
                                      message: "Please login to edit profile",
                                    );
                                    return;
                                  } else {
                                    _showEditDialog(
                                      profile.name,
                                      profile.email,
                                    );
                                  }
                                },
                                child: Text(
                                  "Edit",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.h),

                          Row(
                            children: [
                              Text(
                                "+91-${profile.phone}",
                                style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.secondaryBlack,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "|",
                                style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.secondaryBlack,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  profile.email.isEmpty
                                      ? "${profile.phone}@gmail.com"
                                      : profile.email,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.secondaryBlack,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        if (userId == null) ...[
                          SizedBox(height: 20.h),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AppRoutes.login,
                                  (route) => false,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorScheme.primary,
                                foregroundColor: colorScheme.onPrimary,
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Text(
                                "Login",
                                style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.only(bottom: 100.h, top: 20.h),
                            itemCount: actions.length,
                            separatorBuilder:
                                (_, __) => Padding(
                                  padding: EdgeInsets.symmetric(vertical: 7.dg),
                                  child: const Divider(),
                                ),
                            itemBuilder: (context, index) {
                              final item = actions[index];
                              return ProfileActionTile(
                                icon: item.icon,
                                label: item.label,
                                onTap: item.onTap,
                              );
                            },
                          ),
                        ),
                      ],
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

class ProfileActionTile extends StatelessWidget {
  const ProfileActionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8.r),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 3.h),
          child: Row(
            children: [
              FaIcon(icon, color: colorScheme.outline, size: 21.sp),
              SizedBox(width: 15.w),
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    color: AppColor.black,
                  ),
                ),
              ),
              Icon(Icons.keyboard_arrow_right_outlined, size: 27.sp),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileAction {
  const _ProfileAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
}
