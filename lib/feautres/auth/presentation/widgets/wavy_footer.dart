import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'social_login_button.dart';

class WavyFooter extends StatelessWidget {
  final VoidCallback onGoogleLogin;
  final bool isLoading;

  const WavyFooter({
    super.key,
    required this.onGoogleLogin,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _EllipseClipper(),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFA1E300), Color(0xFF77C700), Color(0xFF00A63E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.only(
          top: 28,
          bottom: 32,
          left: 24,
          right: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Divider
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    color: Colors.white.withOpacity(0.35),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'or continue with',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white.withOpacity(0.95),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    color: Colors.white.withOpacity(0.35),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Google Sign-In only
            SocialLoginButton(
              label: isLoading ? 'Signing in...' : 'Continue with Google',
              icon: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuBn00AgW91VgzPXHnV_UfsQvBRZxgnWD6qHLWFTjNPulsDeBKTyBAGV1hVhF5EoEreqvu7TzxrFeyRQ2oVntekRPSn3OOvC660ebXlYVNcANeR2SgPBxORIJKzM8iAv-0KYEpwf3ZEqpE5Ne_gqagwJ6xSTLqvImHVv5X_O8h4rHnz1RQ7j3T67HS2xmwNe2W-HDke1NxPZ4jZVb80Tdl9aYBlp6Gp80dLq-1wh0mdR0yVkLS1yeVDfqpmyWeiJ0DEetkZzk0e-J8M',
                width: 22,
                height: 22,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.g_mobiledata, size: 22),
              ),
              onPressed: isLoading ? () {} : onGoogleLogin,
            ),

            const SizedBox(height: 28),

            // iOS home indicator
            Container(
              width: 128,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.25),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EllipseClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, 20);
    path.quadraticBezierTo(size.width * 0.5, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
