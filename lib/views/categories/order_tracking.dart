import 'package:priya_fresh_meats/utils/exports.dart';

class OrderTrackingWidget extends StatelessWidget {
  final List<TrackingStep> steps;
  final int currentStep;

  const OrderTrackingWidget({
    Key? key,
    required this.steps,
    required this.currentStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activeColor = Colors.green;
    final inactiveColor = Colors.grey;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            steps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;

              final isActive = index <= currentStep;
              final circleColor = isActive ? activeColor : inactiveColor;
              final lineColor =
                  index < currentStep ? activeColor : inactiveColor;

              return Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 10.r,
                        backgroundColor: circleColor,
                        child: Icon(
                          Icons.check,
                          size: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      SizedBox(
                        width: 60.w,
                        child: Text(
                          step.title,
                          style: GoogleFonts.roboto(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: isActive ? activeColor : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (index != steps.length - 1)
                    Container(
                      width: 30.w,
                      height: 1.5.h,
                      color: lineColor,
                      margin: EdgeInsets.symmetric(horizontal: 6.w),
                    ),
                ],
              );
            }).toList(),
      ),
    );
  }
}

class TrackingStep {
  final String title;

  TrackingStep(this.title);
}
