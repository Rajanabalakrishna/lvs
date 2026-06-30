import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'social_login_button.dart';

class WavyFooter extends StatelessWidget {
  final VoidCallback onGoogleLogin;
  final VoidCallback onFacebookLogin;
  final VoidCallback onSignUp;

  const WavyFooter({
    super.key,
    required this.onGoogleLogin,
    required this.onFacebookLogin,
    required this.onSignUp,
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
          top: 28,      // ← reduced from 56 to match flatter curve
          bottom: 32,
          left: 24,
          right: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Divider ───────────────────────────────
            Row(
              children: [
                Expanded(
                  child: Container(
                      height: 1, color: Colors.white.withOpacity(0.35)),
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
                      height: 1, color: Colors.white.withOpacity(0.35)),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ── Google ────────────────────────────────
            SocialLoginButton(
              label: 'Continue with Google',
              icon: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuBn00AgW91VgzPXHnV_UfsQvBRZxgnWD6qHLWFTjNPulsDeBKTyBAGV1hVhF5EoEreqvu7TzxrFeyRQ2oVntekRPSn3OOvC660ebXlYVNcANeR2SgPBxORIJKzM8iAv-0KYEpwf3ZEqpE5Ne_gqagwJ6xSTLqvImHVv5X_O8h4rHnz1RQ7j3T67HS2xmwNe2W-HDke1NxPZ4jZVb80Tdl9aYBlp6Gp80dLq-1wh0mdR0yVkLS1yeVDfqpmyWeiJ0DEetkZzk0e-J8M',
                width: 22,
                height: 22,
                errorBuilder: (_, __, ___) =>
                const Icon(Icons.g_mobiledata, size: 22),
              ),
              onPressed: onGoogleLogin,
            ),

            const SizedBox(height: 14),

            // ── Facebook ──────────────────────────────
            SocialLoginButton(
              label: 'Continue with Facebook',
              icon: const _FacebookIcon(),
              onPressed: onFacebookLogin,
            ),

            const SizedBox(height: 28),

            // ── Sign Up ───────────────────────────────
            RichText(
              text: TextSpan(
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  const TextSpan(text: "Don't have an account? "),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: onSignUp,
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── iOS home indicator ────────────────────
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

// ── Low radius curve ──────────────────────────────────────
class _EllipseClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, 20);                                           // ← was 58
    path.quadraticBezierTo(size.width * 0.5, 0, size.width, 20); // ← was -18, now 0
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// ── Facebook icon ─────────────────────────────────────────
class _FacebookIcon extends StatelessWidget {
  const _FacebookIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        color: Color(0xFF1877F2),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        'f',
        style: GoogleFonts.plusJakartaSans(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w900,
          height: 1.15,
        ),
      ),
    );
  }
}