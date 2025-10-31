import 'package:flutter/material.dart';

class StatCountersBar extends StatelessWidget {
  final List<Map<String, dynamic>> counters;
  final int columns; // How many columns per row

  const StatCountersBar({
    super.key,
    required this.counters,
    this.columns = 2, // Set to 2 for two rows, 3 for three rows, etc.
  });

  @override
  Widget build(BuildContext context) {
    int rows = (counters.length / columns).ceil();

    return Column(
      children: List.generate(rows, (rowIndex) {
        int start = rowIndex * columns;
        int end = (rowIndex + 1) * columns;
        List<Map<String, dynamic>> rowCounters = counters.sublist(
          start,
          end > counters.length ? counters.length : end,
        );

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: rowCounters.map((stat) {
            return Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 7,
                ),
                decoration: BoxDecoration(
                  color: stat["color"],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      stat["count"],
                      style: TextStyle(
                        color: stat["textColor"],
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      stat["label"],
                      style: const TextStyle(
                        color: Color(0xFF838D9A),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        fontSize: 11.5,
                        letterSpacing: 0.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      }),
    );
  }
}
