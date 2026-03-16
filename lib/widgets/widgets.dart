import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../models/data.dart';

// ── SECTION HEADER ────────────────────────────────────────────────────────

class SectionHeader extends StatelessWidget {
  final String label;
  final String title;
  final String subtitle;

  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label,
                style: AppTheme.dmMono(
                    size: 11,
                    color: AppTheme.teal,
                    letterSpacing: 2.5)),
            const SizedBox(width: 12),
            Container(width: 50, height: 1, color: AppTheme.teal.withOpacity(0.5)),
          ],
        ),
        const SizedBox(height: 14),
        Text(title,
            style: AppTheme.playfair(
                size: 32, height: 1.15, color: AppTheme.white)),
        const SizedBox(height: 14),
        Text(subtitle,
            style: AppTheme.dmSans(
                size: 15, color: AppTheme.muted, height: 1.7)),
        const SizedBox(height: 48),
      ],
    );
  }
}

// ── SKILL CARD ────────────────────────────────────────────────────────────

class SkillCardWidget extends StatefulWidget {
  final SkillCard card;

  const SkillCardWidget({super.key, required this.card});

  @override
  State<SkillCardWidget> createState() => _SkillCardWidgetState();
}

class _SkillCardWidgetState extends State<SkillCardWidget> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _hovered
                ? AppTheme.teal.withOpacity(0.6)
                : AppTheme.borderColor,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppTheme.teal.withOpacity(0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  )
                ]
              : [],
        ),
        child: Stack(
          children: [
            // Top accent line
            if (_hovered)
              Positioned(
                top: 0, left: 0, right: 0,
                child: Container(
                  height: 3,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.teal, AppTheme.gold],
                    ),
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10)),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      color: AppTheme.teal.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(widget.card.icon,
                          style: const TextStyle(fontSize: 20)),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(widget.card.title,
                      style: AppTheme.playfair(size: 16, color: AppTheme.white)),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.card.tags
                        .map((t) => _TagChip(label: t))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;
  const _TagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.teal.withOpacity(0.07),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: AppTheme.teal.withOpacity(0.22)),
      ),
      child: Text(label.toUpperCase(),
          style: AppTheme.dmMono(
              size: 9, color: AppTheme.teal, letterSpacing: 0.8)),
    );
  }
}

// ── PROJECT CARD ──────────────────────────────────────────────────────────

class ProjectCardWidget extends StatefulWidget {
  final Project project;
  const ProjectCardWidget({super.key, required this.project});

  @override
  State<ProjectCardWidget> createState() => _ProjectCardWidgetState();
}

class _ProjectCardWidgetState extends State<ProjectCardWidget> {
  bool _hovered = false;

  Color get _domainColor {
    switch (widget.project.domainType) {
      case DomainType.fintech:
        return AppTheme.goldLight;
      case DomainType.health:
        return const Color(0xFF4DFFA4);
      case DomainType.social:
        return const Color(0xFFC87AFF);
      case DomainType.enterprise:
        return AppTheme.teal;
      case DomainType.travel:
        return const Color(0xFF56CCF2);
      case DomainType.education:
        return const Color(0xFFFF8A65);
    }
  }

  Color get _domainBg {
    switch (widget.project.domainType) {
      case DomainType.fintech:
        return AppTheme.gold.withOpacity(0.1);
      case DomainType.health:
        return const Color(0xFF00C878).withOpacity(0.08);
      case DomainType.social:
        return const Color(0xFFB464FF).withOpacity(0.08);
      case DomainType.enterprise:
        return AppTheme.teal.withOpacity(0.08);
      case DomainType.travel:
        return const Color(0xFF56CCF2).withOpacity(0.08);
      case DomainType.education:
        return const Color(0xFFFF8A65).withOpacity(0.08);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hovered
                ? AppTheme.teal.withOpacity(0.4)
                : AppTheme.borderColor,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.35),
                    blurRadius: 40,
                    offset: const Offset(0, 16),
                  )
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: _domainBg,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: _domainColor.withOpacity(0.25)),
                    ),
                    child: Text(widget.project.domain.toUpperCase(),
                        style: AppTheme.dmMono(
                            size: 9,
                            color: _domainColor,
                            letterSpacing: 1.2)),
                  ),
                  Text(widget.project.platform,
                      style: AppTheme.dmMono(size: 10, color: AppTheme.muted)),
                ],
              ),
            ),
            // Body
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.project.title,
                      style: AppTheme.playfair(size: 18, color: AppTheme.white)),
                  const SizedBox(height: 10),
                  Text(widget.project.description,
                      style: AppTheme.dmSans(
                          size: 13, color: AppTheme.muted, height: 1.65)),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 7,
                    runSpacing: 7,
                    children: widget.project.tech
                        .map((t) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 9, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.04),
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.08)),
                              ),
                              child: Text(t,
                                  style: AppTheme.dmMono(
                                      size: 9, color: AppTheme.muted,
                                      letterSpacing: 0.5)),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 1,
                    color: AppTheme.borderColor,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: widget.project.metrics
                        .expand((m) => [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(m.value,
                                      style: AppTheme.playfair(
                                          size: 18, color: AppTheme.teal)),
                                  const SizedBox(height: 3),
                                  Text(m.label.toUpperCase(),
                                      style: AppTheme.dmMono(
                                          size: 8,
                                          color: AppTheme.muted,
                                          letterSpacing: 0.8)),
                                ],
                              ),
                              if (m != widget.project.metrics.last)
                                const SizedBox(width: 28),
                            ])
                        .toList(),
                  ),
                  if (widget.project.appStoreUrl != null ||
                      widget.project.playStoreUrl != null) ...[
                    const SizedBox(height: 18),
                    Container(height: 1, color: AppTheme.borderColor),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: [
                        if (widget.project.appStoreUrl != null)
                          _StoreLinkButton(
                            label: 'App Store',
                            icon: Icons.apple,
                            url: widget.project.appStoreUrl!,
                          ),
                        if (widget.project.playStoreUrl != null)
                          _StoreLinkButton(
                            label: 'Play Store',
                            icon: Icons.shop,
                            url: widget.project.playStoreUrl!,
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── STORE LINK BUTTON ─────────────────────────────────────────────────────

class _StoreLinkButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final String url;

  const _StoreLinkButton({
    required this.label,
    required this.icon,
    required this.url,
  });

  @override
  State<_StoreLinkButton> createState() => _StoreLinkButtonState();
}

class _StoreLinkButtonState extends State<_StoreLinkButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url),
            mode: LaunchMode.externalApplication),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: _hovered
                ? AppTheme.teal.withValues(alpha: 0.12)
                : Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: _hovered
                  ? AppTheme.teal.withValues(alpha: 0.5)
                  : Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon,
                  size: 14,
                  color: _hovered ? AppTheme.teal : AppTheme.muted),
              const SizedBox(width: 6),
              Text(widget.label,
                  style: AppTheme.dmMono(
                      size: 9,
                      color: _hovered ? AppTheme.teal : AppTheme.muted,
                      letterSpacing: 0.8)),
            ],
          ),
        ),
      ),
    );
  }
}

// ── TESTIMONIAL CARD ──────────────────────────────────────────────────────

class TestimonialCardWidget extends StatefulWidget {
  final Testimonial testimonial;
  const TestimonialCardWidget({super.key, required this.testimonial});

  @override
  State<TestimonialCardWidget> createState() => _TestimonialCardWidgetState();
}

class _TestimonialCardWidgetState extends State<TestimonialCardWidget> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hovered
                ? AppTheme.teal.withOpacity(0.35)
                : AppTheme.borderColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('"',
                    style: AppTheme.playfair(
                        size: 52,
                        color: AppTheme.teal.withOpacity(0.3),
                        height: 0.8)),
                Text('★★★★★',
                    style: AppTheme.dmSans(
                        size: 12, color: AppTheme.gold)),
              ],
            ),
            const SizedBox(height: 12),
            Text(widget.testimonial.quote,
                style: AppTheme.dmSans(
                    size: 13,
                    color: AppTheme.muted,
                    height: 1.75)),
            const SizedBox(height: 24),
            Row(
              children: [
                Container(
                  width: 42, height: 42,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [AppTheme.teal, AppTheme.gold],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Text(widget.testimonial.initials,
                        style: AppTheme.playfair(
                            size: 14,
                            color: AppTheme.navy,
                            weight: FontWeight.w700)),
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.testimonial.name,
                        style: AppTheme.dmSans(
                            size: 14,
                            weight: FontWeight.w600,
                            color: AppTheme.white)),
                    const SizedBox(height: 2),
                    Text(widget.testimonial.role,
                        style: AppTheme.dmMono(
                            size: 10, color: AppTheme.muted)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── NAV LINK ──────────────────────────────────────────────────────────────

class NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool isCta;

  const NavLink({
    super.key,
    required this.label,
    required this.onTap,
    this.isCta = false,
  });

  @override
  State<NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<NavLink> {
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
          padding: widget.isCta
              ? const EdgeInsets.symmetric(horizontal: 20, vertical: 8)
              : EdgeInsets.zero,
          decoration: widget.isCta
              ? BoxDecoration(
                  color: _hovered ? AppTheme.teal : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppTheme.teal),
                )
              : null,
          child: Text(
            widget.label.toUpperCase(),
            style: AppTheme.dmMono(
              size: 10,
              color: widget.isCta
                  ? (_hovered ? AppTheme.navy : AppTheme.teal)
                  : (_hovered ? AppTheme.teal : AppTheme.muted),
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}

// ── STAT ITEM ─────────────────────────────────────────────────────────────

class StatItem extends StatelessWidget {
  final String value;
  final String sup;
  final String label;

  const StatItem({
    super.key,
    required this.value,
    required this.sup,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: value,
                style: AppTheme.playfair(
                    size: 36, color: AppTheme.teal, weight: FontWeight.w700),
              ),
              TextSpan(
                text: sup,
                style: AppTheme.playfair(
                    size: 18, color: AppTheme.gold, weight: FontWeight.w700),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(label,
            textAlign: TextAlign.center,
            style: AppTheme.dmMono(size: 9, color: AppTheme.muted,
                letterSpacing: 1.0)),
      ],
    );
  }
}
