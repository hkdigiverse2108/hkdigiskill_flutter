import 'package:flutter/material.dart';

class ExpandableDescription extends StatefulWidget {
  final String text;
  final int trimLines;

  const ExpandableDescription({
    super.key,
    required this.text,
    this.trimLines = 3,
  });

  @override
  State<ExpandableDescription> createState() => _ExpandableDescriptionState();
}

class _ExpandableDescriptionState extends State<ExpandableDescription> {
  bool isExpanded = false;
  bool isOverflow = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkOverflow());
  }

  void _checkOverflow() {
    final span = TextSpan(
      text: widget.text,
      style: const TextStyle(fontSize: 15, height: 1.4, fontFamily: 'Poppins'),
    );

    final tp = TextPainter(
      text: span,
      maxLines: widget.trimLines,
      textDirection: TextDirection.ltr,
    );

    tp.layout(maxWidth: context.size!.width);

    setState(() {
      isOverflow = tp.didExceedMaxLines;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedCrossFade(
              firstChild: Text(
                widget.text,
                maxLines: widget.trimLines,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 15,
                  height: 1.4,
                  fontFamily: 'Poppins',
                ),
              ),
              secondChild: Text(
                widget.text,
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 15,
                  height: 1.4,
                  fontFamily: 'Poppins',
                ),
              ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 250),
            ),

            // Show More / Less button only if needed
            if (isOverflow)
              InkWell(
                onTap: () => setState(() => isExpanded = !isExpanded),
                child: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    isExpanded ? "Show less" : "Show more",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
