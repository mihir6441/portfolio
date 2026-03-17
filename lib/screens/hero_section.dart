import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/widgets.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onViewWork;
  final VoidCallback onContact;

  const HeroSection({
    super.key,
    required this.onViewWork,
    required this.onContact,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _glowController;
  late Animation<double> _glowAnim;

  late AnimationController _fadeController;
  late List<Animation<double>> _fadeAnims;

  @override
  void initState() {
    super.initState();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
    _glowAnim = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnims = List.generate(
      6,
      (i) => Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _fadeController,
          curve: Interval(i * 0.12, min(i * 0.12 + 0.4, 1.0),
              curve: Curves.easeOut),
        ),
      ),
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _fadeController.forward();
    });
  }

  @override
  void dispose() {
    _glowController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Widget _fadeSlide(int i, Widget child) {
    return AnimatedBuilder(
      animation: _fadeAnims[i],
      builder: (_, __) => Opacity(
        opacity: _fadeAnims[i].value,
        child: Transform.translate(
          offset: Offset(0, 24 * (1 - _fadeAnims[i].value)),
          child: child,
        ),
      ),
    );
  }

  Widget _buildTextContent(
      bool isMobile, bool isDesktop, double nameSize, double subtitleSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _fadeSlide(0, _AvailabilityBadge()),
        const SizedBox(height: 24),
        _fadeSlide(
          1,
          Text("Hi, I'm",
              style: AppTheme.dmSans(
                  size: isMobile ? 16 : 20,
                  color: AppTheme.muted,
                  weight: FontWeight.w400)),
        ),
        const SizedBox(height: 8),
        _fadeSlide(
          2,
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Mihir ',
                  style: AppTheme.playfair(
                      size: nameSize, height: 1.05, color: AppTheme.white),
                ),
                TextSpan(
                  text: 'Bhojani',
                  style: AppTheme.playfair(
                      size: nameSize, height: 1.05, color: AppTheme.teal),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        _fadeSlide(
          3,
          Text('Senior Flutter & AI-Enabled Mobile App Developer',
              style: AppTheme.playfair(
                  size: subtitleSize,
                  weight: FontWeight.w400,
                  color: AppTheme.goldLight)),
        ),
        const SizedBox(height: 24),
        _fadeSlide(
          4,
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 540),
            child: Text(
              'Building intelligent, cross-platform mobile & web apps powered by Flutter and AI. From AI chatbots and smart recommendations to production-grade apps — clean architecture, on-time delivery, and future-ready solutions.',
              style: AppTheme.dmSans(
                  size: isMobile ? 14 : 15,
                  color: AppTheme.muted,
                  height: 1.75),
            ),
          ),
        ),
        SizedBox(height: isMobile ? 28 : 40),
        _fadeSlide(
          5,
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              _PrimaryButton(
                  label: 'Hire Me on Upwork', onTap: widget.onContact),
              _SecondaryButton(label: 'View My Work', onTap: widget.onViewWork),
            ],
          ),
        ),
        SizedBox(height: isMobile ? 36 : 56),
        _fadeSlide(
          5,
          Wrap(
            spacing: isMobile ? 20 : 32,
            runSpacing: 20,
            children: [
              const StatItem(
                  value: '4.5', sup: '+', label: 'YEARS\nEXPERIENCE'),
              _StatDivider(),
              const StatItem(value: '8', sup: '+', label: 'APPS\nSHIPPED'),
              _StatDivider(),
              const StatItem(value: '3', sup: '+', label: 'AI-POWERED\nAPPS'),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < AppTheme.bpMobile;
    final isDesktop = w >= AppTheme.bpTablet;
    final hPad = isDesktop ? 60.0 : (isMobile ? 20.0 : 40.0);

    final nameSize = isDesktop ? 72.0 : (isMobile ? 40.0 : 56.0);
    final subtitleSize = isDesktop ? 22.0 : (isMobile ? 15.0 : 18.0);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: isMobile ? 500 : 600),
      color: AppTheme.navy,
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(painter: _GridPainter()),
          ),
          Positioned(
            right: -100,
            top: -80,
            child: RepaintBoundary(
              child: AnimatedBuilder(
                animation: _glowAnim,
                builder: (_, __) => Transform.scale(
                  scale: _glowAnim.value,
                  child: Container(
                    width: isDesktop ? 600 : 300,
                    height: isDesktop ? 600 : 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppTheme.teal.withValues(alpha: 0.12),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: isDesktop ? 0 : -40,
            top: isDesktop ? 40 : -10,
            child: SizedBox(
              width: isDesktop ? 520 : 320,
              height: isDesktop ? 520 : 320,
              child: CustomPaint(painter: _OrbitRingsPainter()),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                hPad, isMobile ? 88 : 100, hPad, isMobile ? 32 : 60),
            child: Center(
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: AppTheme.maxContentWidth),
                child: isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: _buildTextContent(
                                isMobile, isDesktop, nameSize, subtitleSize),
                          ),
                          const SizedBox(width: 40),
                          Expanded(
                            flex: 2,
                            child: RepaintBoundary(
                              child: _fadeSlide(0, const _ProfileImage()),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          _buildTextContent(
                              isMobile, isDesktop, nameSize, subtitleSize),
                          const SizedBox(height: 40),
                          RepaintBoundary(
                            child: _fadeSlide(
                              0,
                              const _ProfileImage(isMobileLayout: true),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 56,
      color: AppTheme.borderColor,
    );
  }
}

class _AvailabilityBadge extends StatefulWidget {
  @override
  State<_AvailabilityBadge> createState() => _AvailabilityBadgeState();
}

class _AvailabilityBadgeState extends State<_AvailabilityBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500))
      ..repeat(reverse: true);
    _anim = Tween<double>(begin: 1, end: 0.3).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF4DFFA4);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      decoration: BoxDecoration(
        color: green.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: green.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _anim,
            builder: (_, __) => Opacity(
              opacity: _anim.value,
              child: Container(
                width: 7,
                height: 7,
                decoration:
                    const BoxDecoration(color: green, shape: BoxShape.circle),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text('AVAILABLE FOR NEW PROJECTS',
              style:
                  AppTheme.dmMono(size: 9, color: green, letterSpacing: 1.2)),
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _PrimaryButton({required this.label, required this.onTap});

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          transform: Matrix4.translationValues(0, _hovered ? -1 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          decoration: BoxDecoration(
            color: _hovered ? AppTheme.tealSoft : AppTheme.teal,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(widget.label,
              style: AppTheme.dmSans(
                  size: 14, weight: FontWeight.w600, color: AppTheme.navy)),
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _SecondaryButton({required this.label, required this.onTap});

  @override
  State<_SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<_SecondaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          transform: Matrix4.translationValues(0, _hovered ? -1 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 13),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: _hovered
                  ? AppTheme.teal
                  : AppTheme.white.withValues(alpha: 0.25),
            ),
          ),
          child: Text(widget.label,
              style: AppTheme.dmSans(
                  size: 14, color: _hovered ? AppTheme.teal : AppTheme.white)),
        ),
      ),
    );
  }
}

// ── PROFILE IMAGE ────────────────────────────────────────────────────────

class _ProfileImage extends StatefulWidget {
  final bool isMobileLayout;
  const _ProfileImage({this.isMobileLayout = false});

  @override
  State<_ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<_ProfileImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowCtrl;
  late Animation<double> _glowAnim;

  @override
  void initState() {
    super.initState();
    _glowCtrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat(reverse: true);
    _glowAnim = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _glowCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxH = widget.isMobileLayout ? 360.0 : 480.0;
    final maxW = widget.isMobileLayout ? 280.0 : 380.0;

    return Center(
      child: AnimatedBuilder(
        animation: _glowAnim,
        builder: (_, __) => Container(
          constraints: BoxConstraints(maxHeight: maxH, maxWidth: maxW),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppTheme.teal.withValues(alpha: 0.15 * _glowAnim.value),
                blurRadius: 40,
                spreadRadius: 8,
              ),
              BoxShadow(
                color: AppTheme.gold.withValues(alpha: 0.06 * _glowAnim.value),
                blurRadius: 60,
                spreadRadius: 2,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 0.75,
                  child: Image.asset(
                    'assets/mihir_profile.png',
                    fit: BoxFit.cover,
                    alignment: const Alignment(0, -0.6),
                  ),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.5, 1.0],
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          AppTheme.navy.withValues(alpha: 0.85),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppTheme.teal
                            .withValues(alpha: 0.2 * _glowAnim.value),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppTheme.teal.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: AppTheme.teal.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text('Flutter',
                            style: AppTheme.dmSans(
                                size: 11,
                                color: AppTheme.teal,
                                weight: FontWeight.w600)),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppTheme.gold.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: AppTheme.gold.withValues(alpha: 0.25),
                          ),
                        ),
                        child: Text('AI / ML',
                            style: AppTheme.dmSans(
                                size: 11,
                                color: AppTheme.goldLight,
                                weight: FontWeight.w600)),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppTheme.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: AppTheme.white.withValues(alpha: 0.15),
                          ),
                        ),
                        child: Text('4.5+ yrs',
                            style: AppTheme.dmSans(
                                size: 11,
                                color: AppTheme.white,
                                weight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── PAINTERS ─────────────────────────────────────────────────────────────

class _OrbitRingsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final center = Offset(cx, cy);
    final maxR = size.width * 0.45;

    for (var i = 1; i <= 4; i++) {
      final r = maxR * (0.35 + i * 0.2);
      final a = (0.14 - (i - 1) * 0.025).clamp(0.04, 0.14);
      canvas.drawCircle(
        center,
        r,
        Paint()
          ..color = AppTheme.teal.withValues(alpha: a)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
    }

    final outerR = maxR * 0.95;
    final dotPaint = Paint()..color = AppTheme.teal.withValues(alpha: 0.25);
    for (var i = 0; i < 8; i++) {
      final angle = i * pi * 2 / 8;
      canvas.drawCircle(
        Offset(cx + outerR * cos(angle), cy + outerR * sin(angle)),
        2,
        dotPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_OrbitRingsPainter old) => false;
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00B4D8).withValues(alpha: 0.04)
      ..strokeWidth = 1;

    const step = 60.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter oldDelegate) => false;
}
