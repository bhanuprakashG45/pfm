import 'package:priya_fresh_meats/utils/exports.dart';

class LocationLoader extends StatefulWidget {
  const LocationLoader({super.key});

  @override
  State<LocationLoader> createState() => _LocationLoaderState();
}

class _LocationLoaderState extends State<LocationLoader>
    with SingleTickerProviderStateMixin {
  final String fullText = "Fetching location...";
  String displayText = "";
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    Future.doWhile(() async {
      for (int i = 0; i <= fullText.length; i++) {
        await Future.delayed(const Duration(milliseconds: 100));
        if (!mounted) return false;
        setState(() {
          displayText = fullText.substring(0, i);
        });
      }
      await Future.delayed(const Duration(milliseconds: 400));
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(Icons.my_location, color: colorScheme.primary, size: 20.sp),
        SizedBox(width: 6.w),
        Text(
          displayText,
          style: GoogleFonts.roboto(
            fontSize: 15.sp,
            color: colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
