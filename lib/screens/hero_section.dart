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
        const SizedBox(height: 20),
        _fadeSlide(
          1,
          Row(
            children: [
              Container(width: 36, height: 1, color: AppTheme.teal),
              const SizedBox(width: 12),
              Flexible(
                child: Text('Flutter Developer · 4.5+ Years',
                    style: AppTheme.dmMono(
                        size: 11, color: AppTheme.teal, letterSpacing: 1.8)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _fadeSlide(
          2,
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Mihir\n',
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
          Text('Senior Mobile App Developer',
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
              'Senior Mobile App Developer with over 4.5 years of experience in designing and maintaining high-performance iOS and Android applications. Skilled in Flutter, Dart, and Swift, with strong expertise in state management, clean architecture, and scalable app solutions.',
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
              _PrimaryButton(label: 'View My Work', onTap: widget.onViewWork),
              _SecondaryButton(label: "Let's Talk", onTap: widget.onContact),
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
              const StatItem(value: '5', sup: '+', label: 'COMPANIES\nWORKED'),
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
                            child: _fadeSlide(0, const _HeroGraphic()),
                          ),
                        ],
                      )
                    : _buildTextContent(
                        isMobile, isDesktop, nameSize, subtitleSize),
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

// ── HERO GRAPHIC ─────────────────────────────────────────────────────────

class _HeroGraphic extends StatefulWidget {
  const _HeroGraphic();

  @override
  State<_HeroGraphic> createState() => _HeroGraphicState();
}

class _HeroGraphicState extends State<_HeroGraphic>
    with TickerProviderStateMixin {
  late AnimationController _orbitCtrl;
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _orbitCtrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 20))
          ..repeat();
    _pulseCtrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _orbitCtrl.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_orbitCtrl, _pulseAnim]),
      builder: (_, __) => AspectRatio(
        aspectRatio: 1,
        child: CustomPaint(
          painter: _HeroGraphicPainter(
            orbitProgress: _orbitCtrl.value,
            pulse: _pulseAnim.value,
          ),
        ),
      ),
    );
  }
}

class _HeroGraphicPainter extends CustomPainter {
  final double orbitProgress;
  final double pulse;

  _HeroGraphicPainter({required this.orbitProgress, required this.pulse});

  static const _techLabels = [
    'Flutter',
    'Dart',
    'Firebase',
    'BLoC',
    'REST API',
    'Swift',
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final center = Offset(cx, cy);
    final maxR = size.width * 0.45;

    // Orbit rings
    for (var i = 0; i < 3; i++) {
      final r = maxR * (0.5 + i * 0.25);
      final alpha = 0.06 + i * 0.03;
      canvas.drawCircle(
        center,
        r,
        Paint()
          ..color = AppTheme.teal.withValues(alpha: alpha * pulse)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );
    }

    // Central diamond (Flutter-like)
    final diamondSize = maxR * 0.28 * (0.9 + pulse * 0.1);
    final diamondPath = Path()
      ..moveTo(cx, cy - diamondSize)
      ..lineTo(cx + diamondSize * 0.7, cy)
      ..lineTo(cx, cy + diamondSize)
      ..lineTo(cx - diamondSize * 0.7, cy)
      ..close();
    canvas.drawPath(
      diamondPath,
      Paint()
        ..color = AppTheme.teal.withValues(alpha: 0.08 * pulse)
        ..style = PaintingStyle.fill,
    );
    canvas.drawPath(
      diamondPath,
      Paint()
        ..color = AppTheme.teal.withValues(alpha: 0.25 * pulse)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    // Code brackets "< />" in center
    _drawText(canvas, '<  />', cx, cy,
        size: 22, color: AppTheme.teal.withValues(alpha: 0.5 * pulse));

    // Central glow
    canvas.drawCircle(
      center,
      maxR * 0.18,
      Paint()
        ..shader = RadialGradient(
          colors: [
            AppTheme.teal.withValues(alpha: 0.12 * pulse),
            Colors.transparent,
          ],
        ).createShader(Rect.fromCircle(center: center, radius: maxR * 0.18)),
    );

    // Orbiting dots on each ring
    for (var ring = 0; ring < 3; ring++) {
      final r = maxR * (0.5 + ring * 0.25);
      final dotCount = 2 + ring;
      for (var d = 0; d < dotCount; d++) {
        final angle = (orbitProgress * 2 * pi * (ring.isEven ? 1 : -1)) +
            (d * 2 * pi / dotCount);
        final dx = cx + r * cos(angle);
        final dy = cy + r * sin(angle);
        final dotR = 3.0 + ring * 0.5;

        canvas.drawCircle(
          Offset(dx, dy),
          dotR * pulse,
          Paint()..color = AppTheme.teal.withValues(alpha: 0.7 * pulse),
        );
        canvas.drawCircle(
          Offset(dx, dy),
          dotR * 3 * pulse,
          Paint()..color = AppTheme.teal.withValues(alpha: 0.08 * pulse),
        );
      }
    }

    // Floating tech labels around outer ring
    for (var i = 0; i < _techLabels.length; i++) {
      final angle =
          (i * 2 * pi / _techLabels.length) + (orbitProgress * 2 * pi * 0.15);
      final r = maxR * (0.85 + 0.08 * sin(orbitProgress * 2 * pi + i));
      final lx = cx + r * cos(angle);
      final ly = cy + r * sin(angle);

      final fadeZone = (sin(angle + orbitProgress * pi) + 1) / 2;
      final labelAlpha = 0.3 + fadeZone * 0.5;

      _drawText(canvas, _techLabels[i], lx, ly,
          size: 10, color: AppTheme.teal.withValues(alpha: labelAlpha * pulse));
    }

    // Corner accent dots
    final accentPositions = [
      Offset(cx - maxR * 0.35, cy - maxR * 0.35),
      Offset(cx + maxR * 0.4, cy - maxR * 0.3),
      Offset(cx - maxR * 0.3, cy + maxR * 0.4),
      Offset(cx + maxR * 0.35, cy + maxR * 0.35),
    ];
    for (var i = 0; i < accentPositions.length; i++) {
      final p = accentPositions[i];
      final glow = sin(orbitProgress * 2 * pi * 2 + i * 1.5).abs();
      canvas.drawCircle(
        p,
        2,
        Paint()
          ..color = AppTheme.gold.withValues(alpha: (0.2 + glow * 0.5) * pulse),
      );
    }

    // Connecting lines from center to orbiting dots (subtle)
    for (var ring = 0; ring < 2; ring++) {
      final r = maxR * (0.5 + ring * 0.25);
      final angle = orbitProgress * 2 * pi * (ring.isEven ? 1 : -1);
      final dx = cx + r * cos(angle);
      final dy = cy + r * sin(angle);
      canvas.drawLine(
        center,
        Offset(dx, dy),
        Paint()
          ..color = AppTheme.teal.withValues(alpha: 0.04 * pulse)
          ..strokeWidth = 1,
      );
    }
  }

  void _drawText(Canvas canvas, String text, double x, double y,
      {required double size, required Color color}) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontFamily: 'DM Mono',
          fontSize: size,
          color: color,
          fontWeight: FontWeight.w500,
          letterSpacing: size > 15 ? 4 : 1,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(x - tp.width / 2, y - tp.height / 2));
  }

  @override
  bool shouldRepaint(_HeroGraphicPainter old) => true;
}

// ── PAINTERS ─────────────────────────────────────────────────────────────

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
