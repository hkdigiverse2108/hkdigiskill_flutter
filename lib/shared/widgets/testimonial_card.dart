import 'package:flutter/material.dart';
import 'package:hkdigiskill/app/utils/globals.dart';

Widget testimonialCard({
  required String imageUrl,
  required String date,
  required String title,
  required String description,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image section
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
          child: Image.network(
            Globals.fixLocalhostUrl(imageUrl),
            width: 120,
            fit: BoxFit.cover,
          ),
        ),
        // Text content section
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 14, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 10,
                    height: 1.4,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
