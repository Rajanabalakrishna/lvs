
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AliveTextField extends StatefulWidget {
  final String label;
  final String placeholder;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  const AliveTextField({
    super.key,
    required this.label,
    required this.placeholder,
    this.isPassword = false,
    this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<AliveTextField> createState() => _AliveTextFieldState();
}

class _AliveTextFieldState extends State<AliveTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: widget.controller,
          obscureText: widget.isPassword && _obscure,
          keyboardType: widget.keyboardType,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
          ),
          decoration: InputDecoration(
            hintText: widget.placeholder,
            hintStyle: GoogleFonts.plusJakartaSans(
              color: isDark
                  ? const Color(0xFF475569)
                  : const Color(0xFF94A3B8),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: isDark
                ? const Color(0xFF1E293B)
                : const Color(0xFFF4F6F9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:
              const BorderSide(color: Color(0xFF77C700), width: 2),
            ),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            suffixIcon: widget.isPassword
                ? IconButton(
              icon: Icon(
                _obscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: const Color(0xFF94A3B8),
                size: 20,
              ),
              onPressed: () =>
                  setState(() => _obscure = !_obscure),
            )
                : null,
          ),
        ),
      ],
    );
  }
}