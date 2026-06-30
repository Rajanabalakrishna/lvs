import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../notifier/auth_notifier.dart';
import '../state/auth_state.dart';
import '../widgets/alive_logo_widget.dart';
import '../widgets/alive_text_field.dart';
import '../widgets/alive_gradient_button.dart';
import '../widgets/status_bar_widget.dart';
import '../widgets/wavy_footer.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final authNotifier = ref.read(authNotifierProvider.notifier);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final hPad = size.width < 400 ? 20.0 : 24.0;

    final isLoading = authState is AuthLoading;

    ref.listen<AuthState>(authNotifierProvider, (prev, next) {
      if (next is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor:
          isDark ? const Color(0xFF0F172A) : const Color(0xFFFFFFFF),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 300),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const StatusBarWidget(),
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
                  AliveLogoWidget(size: size.width < 400 ? 70 : 80),
                  SizedBox(height: size.height * 0.028),
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AliveTextField(
                          label: 'Email ID or Phone Number',
                          placeholder: 'Enter Registered Email or Phone No.',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 20),
                        AliveTextField(
                          label: 'Password',
                          placeholder: 'Enter your password',
                          isPassword: true,
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {},
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
                        AliveGradientButton(
                          label: 'Login',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Loading overlay
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.35),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Color(0xFF16A34A)),
                ),
              ),
            ),

          // Sticky wavy footer — Google Sign-In only
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: WavyFooter(
              isLoading: isLoading,
              onGoogleLogin: () async {
                await authNotifier.signInWithGoogle();
              },
            ),
          ),
        ],
      ),
    );
  }
}
