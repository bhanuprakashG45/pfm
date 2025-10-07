import 'package:priya_fresh_meats/utils/exports.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  bool showWelcomeMessage = false;
  final List<String> label = ['Home', 'Categories', 'Search', 'Account'];

  final List<Widget> _screens = [
    HomeView(),
    const CategoriesView(),
    const SearchScreen(),
    const ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final navigationProvider = Provider.of<NavigationProvider>(
        context,
        listen: false,
      );

      navigationProvider.setIndex(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ScaffoldMessenger(
      child: WillPopScope(
        onWillPop: () async {
          final navigationProvider = Provider.of<NavigationProvider>(
            context,
            listen: false,
          );
          if (navigationProvider.currentIndex != 0) {
            navigationProvider.setIndex(0);
            return false;
          }
          return true;
        },
        child: SafeArea(
          top: false,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: DoubleBackToExit(
              snackBarMessage: "Tap back again to close the app",
              onDoubleBack: () {
                SystemNavigator.pop();
              },
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Consumer<NavigationProvider>(
                    builder: (context, navigationProvider, child) {
                      return IndexedStack(
                        index: navigationProvider.currentIndex,
                        children: _screens,
                      );
                    },
                  ),
                  Consumer<NavigationProvider>(
                    builder: (context, navigationProvider, child) {
                      return Container(
                        height: 72.h + MediaQuery.of(context).padding.bottom.h,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 124, 124, 124),
                              blurRadius: 0.5,
                              offset: Offset(0, 0),
                            ),
                          ],
                          color: colorScheme.onPrimary,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            for (int i = 0; i < 4; i++)
                              InkWell(
                                onTap: () {
                                  navigationProvider.setIndex(i);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: Column(
                                    children: [
                                      Icon(
                                        navigationProvider.currentIndex == i
                                            ? AppImages.darkValues[i]
                                            : AppImages.values[i],
                                        size: 27.sp,
                                        color:
                                            navigationProvider.currentIndex == i
                                                ? colorScheme.primary
                                                : colorScheme.outline,
                                      ),
                                      Text(
                                        label[i],
                                        style: TextStyle(
                                          fontSize:
                                              navigationProvider.currentIndex == i
                                                  ? 15.sp
                                                  : 14.sp,
                                          color:
                                              navigationProvider.currentIndex == i
                                                  ? colorScheme.primary
                                                  : colorScheme.outline,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
