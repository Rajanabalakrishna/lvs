


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusBarWidget extends StatelessWidget {
  const StatusBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? Colors.white : const Color(0xFF0F172A);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '9:41',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: iconColor,
            ),
          ),
          Row(
            children: [
              Icon(Icons.signal_cellular_alt, size: 16, color: iconColor),
              const SizedBox(width: 4),
              Icon(Icons.wifi, size: 16, color: iconColor),
              const SizedBox(width: 4),
              RotatedBox(
                quarterTurns: 1,
                child: Icon(Icons.battery_full, size: 16, color: iconColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}