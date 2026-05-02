
import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/features/tips/presentation/widgets/number_circle.dart';
import 'package:flutter/material.dart';

class GuidelineTile extends StatefulWidget {
  final int number;
  final String title;
  final List<String> points;

  const GuidelineTile({
    super.key,
    required this.number,
    required this.title,
    required this.points,
  });

  @override
  State<GuidelineTile> createState() => _GuidelineTileState();
}

class _GuidelineTileState extends State<GuidelineTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: isExpanded
              ? Border.all(color: AppColors.primary!, width: 1.2)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ExpansionTile(
          onExpansionChanged: (value) {
            setState(() {
              isExpanded = value;
            });
          },
          tilePadding: const EdgeInsets.symmetric(horizontal: 16),
          childrenPadding: const EdgeInsets.only(bottom: 12),
          iconColor: AppColors.primary,
          collapsedIconColor: Colors.grey,
          title: Row(
            children: [
              NumberCircle(
                number: widget.number,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight:
                        isExpanded ? FontWeight.bold : FontWeight.w600,
                    color: isExpanded
                        ? AppColors.primary
                        : Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          children: widget.points
              .map(
                (e) => ListTile(
                  title: Text(e),
                  dense: true,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
