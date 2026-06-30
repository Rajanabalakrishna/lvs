import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/alive_logo_widget.dart';
import '../widgets/alive_text_field.dart';
import '../widgets/alive_gradient_button.dart';
import '../widgets/status_bar_widget.dart';
import '../widgets/wavy_footer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey _footerKey = GlobalKey();
  double _footerHeight = 300; // safe fallback

  @override
  void initState() {
    super.initState();
    // Measure footer height after first frame renders
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _footerKey.currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox;
        setState(() => _footerHeight = box.size.height);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    // Responsive horizontal padding — tighter on small screens, wider on tablets
    final hPad = size.width < 400 ? 20.0 : 24.0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor:
      isDark ? const Color(0xFF0F172A) : const Color(0xFFFFFFFF),
      body: Stack(
        children: [
          // ── Scrollable content ────────────────────────
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              // Extra bottom padding = footer height so content is never hidden
              padding: EdgeInsets.only(bottom: _footerHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Status bar
                  const StatusBarWidget(),

                  // iOS notch
                  Center(
                    child: Container(
                      width: 120,
                      height: 34,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.035),

                  // App logo
                  AliveLogoWidget(size: size.width < 400 ? 70 : 80),

                  SizedBox(height: size.height * 0.028),

                  // Welcome text
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    child: Column(
                      children: [
                        Text(
                          'Welcome back! 👋',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: size.width < 400 ? 24 : 28,
                            fontWeight: FontWeight.w800,
                            color: isDark
                                ? Colors.white
                                : const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Sign in to continue your live streaming journey.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? const Color(0xFF94A3B8)
                                : const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: size.height * 0.04),

                  // ── Form ──────────────────────────────
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Email / Phone
                        const AliveTextField(
                          label: 'Email ID or Phone Number',
                          placeholder: 'Enter Registered Email or Phone No.',
                          keyboardType: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 20),

                        // Password
                        const AliveTextField(
                          label: 'Password',
                          placeholder: 'Enter your password',
                          isPassword: true,
                        ),

                        const SizedBox(height: 10),

                        // Forgot password
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              // TODO: Navigate to forgot password
                            },
                            child: Text(
                              'Forgot Password?',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF16A34A),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 28),

                        // Login button
                        AliveGradientButton(
                          label: 'Login',
                          onPressed: () {
                            // TODO: Handle login
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Sticky wavy footer ────────────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: WavyFooter(
              key: _footerKey,
              onGoogleLogin: () {
                // TODO: Google Sign-In
              },
              onFacebookLogin: () {
                // TODO: Facebook Sign-In
              },
              onSignUp: () {
                // TODO: Navigate to Sign Up
              },
            ),
          ),
        ],
      ),
    );
  }
}