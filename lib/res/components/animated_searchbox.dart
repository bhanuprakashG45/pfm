import 'dart:async';
import 'package:priya_fresh_meats/utils/exports.dart';

class AnimatedSearchTextField extends StatefulWidget {
  final TextEditingController controller;

  const AnimatedSearchTextField({required this.controller, super.key});

  @override
  State<AnimatedSearchTextField> createState() =>
      _AnimatedSearchTextFieldState();
}

class _AnimatedSearchTextFieldState extends State<AnimatedSearchTextField>
    with SingleTickerProviderStateMixin {
  final List<String> _keywords = ["'Chicken'", "'Mutton'", "'Fish'"];
  late AnimationController _controller;
  late Animation<Offset> _oldTextOffset;
  late Animation<double> _oldTextOpacity;
  late Animation<Offset> _newTextOffset;
  late Animation<double> _newTextOpacity;
  late Timer _timer;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _oldTextOffset = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _oldTextOpacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _newTextOffset = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _newTextOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      final provider = context.read<SearchViewmodel>();
      if (provider.showHint) {
        _controller.forward().then((_) {
          provider.updateAnimatedKeyword(keywordsLength: _keywords.length);
          _controller.reset();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 60.h,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Consumer<SearchViewmodel>(
            builder: (context, provider, child) {
              if (widget.controller.text != provider.searchText) {
                widget.controller.text = provider.searchText;
                widget.controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: widget.controller.text.length),
                );
              }

              provider.updateHintVisibility(widget.controller.text.isEmpty);

              return TextField(
                focusNode: _focusNode,
                // keyboardType: TextInputType.text,
                controller: widget.controller,
                onChanged: (value) {
                  provider.updateSearchText(value);
                },
                style: GoogleFonts.roboto(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, size: 30.sp),
                  suffixIcon:
                      widget.controller.text.isNotEmpty
                          ? IconButton(
                            icon: Icon(
                              Icons.clear,
                              size: 24.sp,
                              color: colorScheme.primary,
                            ),
                            onPressed: () {
                              widget.controller.clear();
                              provider.clearSearch();
                              FocusScope.of(context).requestFocus(_focusNode);
                            },
                          )
                          : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15).r,
                    borderSide: BorderSide(
                      color: Colors.grey.shade600,
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15).r,
                    borderSide: BorderSide(
                      color: Colors.grey.shade600,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15).r,
                    borderSide: BorderSide(
                      color: colorScheme.primary,
                      width: 1.5,
                    ),
                  ),
                  filled: true,
                  fillColor: colorScheme.onPrimary,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                ),
              );
            },
          ),

          Consumer<SearchViewmodel>(
            builder: (context, provider, child) {
              if (!provider.showHint) return const SizedBox.shrink();

              return IgnorePointer(
                child: Padding(
                  padding: EdgeInsets.only(left: 70.w, right: 16.w),
                  child: Row(
                    children: [
                      Text(
                        "Search for ",
                        style: GoogleFonts.roboto(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(
                        width: 100.w,
                        height: 24.h,
                        child: Stack(
                          clipBehavior: Clip.hardEdge,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SlideTransition(
                                position: _oldTextOffset,
                                child: FadeTransition(
                                  opacity: _oldTextOpacity,
                                  child: SizedBox(
                                    width: 100.w,
                                    child: Text(
                                      _keywords[provider.currentIndex],
                                      style: GoogleFonts.roboto(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade600,
                                        height: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SlideTransition(
                                position: _newTextOffset,
                                child: FadeTransition(
                                  opacity: _newTextOpacity,
                                  child: SizedBox(
                                    width: 100.w,
                                    child: Text(
                                      _keywords[provider.nextIndex],
                                      style: GoogleFonts.roboto(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade600,
                                        height: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
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
          ),
        ],
      ),
    );
  }
}
