

import 'package:flutter/material.dart';

class AliveLogoWidget extends StatelessWidget {
  final double size;
  const AliveLogoWidget({super.key, this.size = 80});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCyZcxqNm5CUEvrDOevi-sxd5xwC6fQ8qKqXctdgSmN6e0LA8Ng7u9nCp2Yg0lQLF-fxeZUpMcNYFVNJeAwifw40eTRS0IDQcXM-qUxf0u9E8bswwHdP33XSH-N34FSfyuLIWtcCVGwDADKPhZgnl5Rass_dF6jhMdjsMulnHaUjNpx0-VZehtUDXsj_Q0Zm4zfnmsY6i7nis-4XR-mWplwUxGRIzo5eOsmAqf5Qsjjw0iu7aVfdcXlVtsL6USp1EbOPCfpDPN61QA',
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          color: const Color(0xFF77C700),
          child: const Icon(Icons.live_tv, color: Colors.white, size: 40),
        ),
      ),
    );
  }
}