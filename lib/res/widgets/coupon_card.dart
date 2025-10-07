import 'package:flutter/material.dart';

class CouponCard extends StatelessWidget {
  const CouponCard({
    super.key,
    required this.title,
    required this.code,
    this.subtitle,
    this.validTill,
    this.colors = const [Color(0xFF3E6AF9), Color(0xFF7C3AED)],
    this.textColor,
    this.leading,
    this.onApply,
    this.isRedeemed = false,
    this.isExpired = false,
    this.trailingWidth = 124,
    this.notchRadius = 16,
    this.borderRadius = 24,
    this.padding = const EdgeInsets.all(16),
    this.elevation = 12,
    this.showShadow = true,
    this.dividerDashWidth = 6,
    this.dividerDashSpace = 6,
  });

  final String title;
  final String? subtitle;
  final String code;
  final DateTime? validTill;
  final List<Color> colors;
  final Color? textColor;
  final Widget? leading;
  final VoidCallback? onApply;

  final bool isRedeemed;

  final bool isExpired;

  final double trailingWidth;

  final double notchRadius;

  final double borderRadius;

  final EdgeInsets padding;

  final double elevation;

  final bool showShadow;

  final double dividerDashWidth;
  final double dividerDashSpace;

  @override
  Widget build(BuildContext context) {
    final Color resolvedTextColor = textColor ?? _legibleOn(colors.first);

    final Widget card = ClipPath(
      clipper: _CouponClipper(
        borderRadius: borderRadius,
        notchRadius: notchRadius,
      ),
      child: CustomPaint(
        foregroundPainter: _PerforationPainter(
          dividerFromRight: trailingWidth + padding.right,
          dashWidth: dividerDashWidth,
          dashSpace: dividerDashSpace,
          color: resolvedTextColor.withOpacity(0.5),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: _Content(
            title: title,
            subtitle: subtitle,
            code: code,
            validTill: validTill,
            textColor: resolvedTextColor,
            padding: padding,
            trailingWidth: trailingWidth,
            leading: leading,
            onApply: onApply,
            isExpired: isExpired,
          ),
        ),
      ),
    );

    if (!showShadow) return card;

    return PhysicalModel(
      color: Colors.transparent,
      elevation: elevation,
      borderRadius: BorderRadius.circular(borderRadius),
      shadowColor: Colors.black.withOpacity(0.25),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Opacity(opacity: isExpired ? 0.65 : 1, child: card),
          if (isExpired) _Ribbon(label: 'EXPIRED'),
          if (!isExpired && isRedeemed) _Ribbon(label: 'REDEEMED'),
        ],
      ),
    );
  }

  Color _legibleOn(Color background) {
    // Perceived luminance per ITU-R BT.709
    final double l =
        (0.2126 * background.red +
            0.7152 * background.green +
            0.0722 * background.blue) /
        255.0;
    return l > 0.6 ? const Color(0xFF111111) : Colors.white;
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.title,
    required this.code,
    required this.textColor,
    required this.padding,
    required this.trailingWidth,
    this.subtitle,
    this.validTill,
    this.leading,
    this.onApply,
    this.isExpired = false,
  });

  final String title;
  final String? subtitle;
  final String code;
  final DateTime? validTill;
  final Color textColor;
  final EdgeInsets padding;
  final double trailingWidth;
  final Widget? leading;
  final VoidCallback? onApply;
  final bool isExpired;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    final styleTitle = tt.titleLarge?.copyWith(
      color: textColor,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.2,
    );
    final styleSubtitle = tt.bodyMedium?.copyWith(
      color: textColor.withOpacity(0.9),
    );
    final styleValidity = tt.bodySmall?.copyWith(
      color: textColor.withOpacity(0.85),
    );

    final String? validityText =
        validTill == null ? null : 'Valid until ${_fmt(validTill!)}';

    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (leading != null) ...[
                      SizedBox(width: 38, height: 38, child: leading),
                      const SizedBox(width: 12),
                    ],
                    Flexible(
                      child: Text(
                        title,
                        style: styleTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    subtitle!,
                    style: styleSubtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                if (validityText != null) ...[
                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: textColor.withOpacity(0.9),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          validityText,
                          style: styleValidity,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
                if (onApply != null) ...[
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: isExpired ? null : onApply,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          isExpired
                              ? Colors.grey
                              : Colors.black.withOpacity(0.85),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text('APPLY'),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(
            width: trailingWidth,
            child: _CodePill(code: code, textColor: textColor),
          ),
        ],
      ),
    );
  }

  String _fmt(DateTime d) {
    // Simple format like "Aug 15, 2025"
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[d.month - 1]} ${d.day}, ${d.year}';
  }
}

class _CodePill extends StatelessWidget {
  const _CodePill({required this.code, required this.textColor});
  final String code;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: ShapeDecoration(
          color: Colors.white.withOpacity(0.12),
          shape: StadiumBorder(
            side: BorderSide(color: textColor.withOpacity(0.55), width: 1.4),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.local_offer,
              size: 18,
              color: textColor.withOpacity(0.95),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                code.toUpperCase(),
                style: TextStyle(
                  color: textColor,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.1,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 6),
            Icon(
              Icons.copy_rounded,
              size: 18,
              color: textColor.withOpacity(0.95),
            ),
          ],
        ),
      ),
    );
  }
}

class _Ribbon extends StatelessWidget {
  const _Ribbon({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 12,
      left: -32,
      child: Transform.rotate(
        angle: -0.6,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

class _PerforationPainter extends CustomPainter {
  _PerforationPainter({
    required this.dividerFromRight,
    required this.dashWidth,
    required this.dashSpace,
    required this.color,
  });

  final double
  dividerFromRight; // distance from right edge where the divider sits
  final double dashWidth;
  final double dashSpace;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final double x = size.width - dividerFromRight;
    final Paint paint =
        Paint()
          ..color = color
          ..strokeWidth = 1.4
          ..style = PaintingStyle.stroke;

    double y = 0;
    while (y < size.height) {
      final double y2 = (y + dashWidth).clamp(0, size.height);
      canvas.drawLine(Offset(x, y), Offset(x, y2), paint);
      y += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant _PerforationPainter oldDelegate) {
    return dividerFromRight != oldDelegate.dividerFromRight ||
        dashWidth != oldDelegate.dashWidth ||
        dashSpace != oldDelegate.dashSpace ||
        color != oldDelegate.color;
  }
}

class _CouponClipper extends CustomClipper<Path> {
  _CouponClipper({required this.borderRadius, required this.notchRadius});
  final double borderRadius;
  final double notchRadius;

  @override
  Path getClip(Size size) {
    final Rect rect = Offset.zero & size;

    final Path base =
        Path()..addRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(borderRadius)),
        );

    // Left & right notches centered vertically.
    final Path notches =
        Path()
          ..addOval(
            Rect.fromCircle(
              center: Offset(0, size.height / 2),
              radius: notchRadius,
            ),
          )
          ..addOval(
            Rect.fromCircle(
              center: Offset(size.width, size.height / 2),
              radius: notchRadius,
            ),
          );

    final Path result = Path.combine(PathOperation.difference, base, notches);
    return result;
  }

  @override
  bool shouldReclip(covariant _CouponClipper oldClipper) {
    return borderRadius != oldClipper.borderRadius ||
        notchRadius != oldClipper.notchRadius;
  }
}
