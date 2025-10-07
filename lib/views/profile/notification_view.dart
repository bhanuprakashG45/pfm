import 'package:priya_fresh_meats/utils/exports.dart';

class NotificationScreen extends StatefulWidget {
  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final profilevm = Provider.of<ProfileViewModel>(context, listen: false);
      await profilevm.fetchNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Notifications",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            fontSize: 22.sp,
          ),
        ),
        backgroundColor: colorscheme.onPrimary,
        shadowColor: colorscheme.onPrimary,
        surfaceTintColor: colorscheme.onPrimary,
        elevation: 0.01,
      ),
      backgroundColor: colorscheme.onPrimary,
      body: SafeArea(
        top: false,
        child: Consumer<ProfileViewModel>(
          builder: (context, provider, child) {
            if (provider.isNotificationsFetching) {
              return Center(
                child: CircularProgressIndicator(
                  color: colorscheme.primary,
                  strokeWidth: 3.0.w,
                ),
              );
            }
        
            if (provider.notifications.isEmpty) {
              return Center(
                child: Text(
                  "No Notifications",
                  style: GoogleFonts.roboto(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }
        
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 13.h),
              itemCount: provider.notifications.length,
              separatorBuilder: (context, index) => SizedBox(height: 15.h),
              itemBuilder: (context, index) {
                final notification = provider.notifications[index];
        
                return Container(
                  decoration: BoxDecoration(
                    color: colorscheme.onPrimary,
                    borderRadius: BorderRadius.circular(20).r,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.dividergrey,
                        spreadRadius: 1.5,
                        blurRadius: 4,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 15.h,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50.h,
                          width: 50.w,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          child: Lottie.asset(
                            'assets/json/notification.json',
                            fit: BoxFit.contain,
                            repeat: true,
                          ),
                        ),
                        SizedBox(width: 13.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification.title,
                                style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.primaryBlackshade,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                notification.body,
                                style: GoogleFonts.roboto(
                                  fontSize: 15.sp,
                                  color: AppColor.primaryBlackshade,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
