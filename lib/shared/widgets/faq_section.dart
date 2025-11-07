import 'package:flutter/material.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/modules/courses/controllers/course_details_controller.dart';
import 'package:hkdigiskill/shared/widgets/widget_animation_wrapper.dart';

class FaqSection extends StatefulWidget {
  final List<FaqItem> faqs;

  const FaqSection({super.key, required this.faqs});

  @override
  State<FaqSection> createState() => _FaqSectionState();
}

class _FaqSectionState extends State<FaqSection> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.faqs.length, (index) {
        final item = widget.faqs[index];
        final isExpanded = expandedIndex == index;
        return WidgetAnimationWrapper(
          animationTypes: [AnimationType.slide, AnimationType.fade],
          slideDirection: SlideDirection.fromRight,
          index: index,
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                decoration: BoxDecoration(
                  // Only top corners colored and rounded when expanded
                  color: isExpanded ? AppColors.primary : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                    bottomLeft: Radius.circular(isExpanded ? 0 : 14),
                    bottomRight: Radius.circular(isExpanded ? 0 : 14),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                      bottomLeft: Radius.circular(isExpanded ? 0 : 14),
                      bottomRight: Radius.circular(isExpanded ? 0 : 14),
                    ),
                    onTap: () {
                      setState(() {
                        expandedIndex = isExpanded ? null : index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 16,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.question,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: isExpanded ? Colors.white : Colors.black,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: isExpanded
                                ? Colors.white
                                : AppColors.textLight,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (isExpanded)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(left: 4, right: 4, bottom: 8),
                  // Use only bottom corners rounded and white bg for answer
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(14),
                      bottomRight: Radius.circular(14),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 16,
                    ),
                    child: Text(
                      item.answer,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[800],
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
