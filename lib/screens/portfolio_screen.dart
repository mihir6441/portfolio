// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../models/data.dart';
import '../widgets/widgets.dart';
import 'hero_section.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final ScrollController _scrollController = ScrollController();

  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _testimonialsKey = GlobalKey();
  final _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.navy,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HeroSection(
                  onViewWork: () => _scrollTo(_projectsKey),
                  onContact: () => _scrollTo(_contactKey),
                ),
                _SkillsSection(key: _skillsKey),
                _ProjectsSection(key: _projectsKey),
                _ExperienceSection(key: _experienceKey),
                _TestimonialsSection(key: _testimonialsKey),
                _ContactSection(key: _contactKey),
                _Footer(
                    onTop: () => _scrollController.animateTo(0,
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeInOut)),
              ],
            ),
          ),
          _NavBar(
            onSkills: () => _scrollTo(_skillsKey),
            onProjects: () => _scrollTo(_projectsKey),
            onExperience: () => _scrollTo(_experienceKey),
            onTestimonials: () => _scrollTo(_testimonialsKey),
            onHire: () => _scrollTo(_contactKey),
          ),
        ],
      ),
    );
  }
}

// ── HELPERS ───────────────────────────────────────────────────────────────

double _hPad(double w) => w >= AppTheme.bpTablet ? 60 : (w >= AppTheme.bpMobile ? 40 : 20);

EdgeInsets _sectionPadding(double w) => EdgeInsets.symmetric(
      horizontal: _hPad(w),
      vertical: w >= AppTheme.bpMobile ? 80 : 48,
    );

Widget _contentBox({required Widget child}) {
  return Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: AppTheme.maxContentWidth),
      child: child,
    ),
  );
}

// ── RESPONSIVE GRID ──────────────────────────────────────────────────────

class _ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final int mobileColumns;
  final int tabletColumns;
  final int desktopColumns;
  final double spacing;

  const _ResponsiveGrid({
    required this.children,
    this.mobileColumns = 1,
    this.tabletColumns = 2,
    this.desktopColumns = 3,
    this.spacing = 20,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final cols = w >= 800
            ? desktopColumns
            : (w >= 460 ? tabletColumns : mobileColumns);
        final itemWidth = (w - spacing * (cols - 1)) / cols;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: children
              .map((child) => SizedBox(width: itemWidth, child: child))
              .toList(),
        );
      },
    );
  }
}

// ── NAV BAR ───────────────────────────────────────────────────────────────

class _NavBar extends StatelessWidget {
  final VoidCallback onSkills;
  final VoidCallback onProjects;
  final VoidCallback onExperience;
  final VoidCallback onTestimonials;
  final VoidCallback onHire;

  const _NavBar({
    required this.onSkills,
    required this.onProjects,
    required this.onExperience,
    required this.onTestimonials,
    required this.onHire,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final showFullNav = w >= AppTheme.bpMobile;

    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: AppTheme.navy.withValues(alpha: 0.92),
        border: const Border(
          bottom: BorderSide(color: AppTheme.borderColor),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: _hPad(w)),
      child: _contentBox(
        child: Row(
          children: [
            // Logo
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Mihir',
                    style: AppTheme.playfair(size: 18, color: AppTheme.teal),
                  ),
                  TextSpan(
                    text: '.',
                    style: AppTheme.playfair(size: 18, color: AppTheme.gold),
                  ),
                  TextSpan(
                    text: 'Bhojani',
                    style: AppTheme.playfair(size: 18, color: AppTheme.teal),
                  ),
                ],
              ),
            ),
            const Spacer(),
            if (showFullNav) ...[
              NavLink(label: 'Skills', onTap: onSkills),
              const SizedBox(width: 32),
              NavLink(label: 'Projects', onTap: onProjects),
              const SizedBox(width: 32),
              NavLink(label: 'Experience', onTap: onExperience),
              const SizedBox(width: 32),
              NavLink(label: 'Reviews', onTap: onTestimonials),
              const SizedBox(width: 32),
              NavLink(label: 'Hire Me', onTap: onHire, isCta: true),
            ] else ...[
              NavLink(label: 'Hire Me', onTap: onHire, isCta: true),
              const SizedBox(width: 8),
              _MobileMenuButton(
                onSkills: onSkills,
                onProjects: onProjects,
                onExperience: onExperience,
                onTestimonials: onTestimonials,
                onHire: onHire,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MobileMenuButton extends StatelessWidget {
  final VoidCallback onSkills;
  final VoidCallback onProjects;
  final VoidCallback onExperience;
  final VoidCallback onTestimonials;
  final VoidCallback onHire;

  const _MobileMenuButton({
    required this.onSkills,
    required this.onProjects,
    required this.onExperience,
    required this.onTestimonials,
    required this.onHire,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu, color: AppTheme.teal, size: 22),
      color: AppTheme.navyMid,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppTheme.borderColor),
      ),
      offset: const Offset(0, 48),
      onSelected: (value) {
        switch (value) {
          case 'skills':
            onSkills();
          case 'projects':
            onProjects();
          case 'experience':
            onExperience();
          case 'reviews':
            onTestimonials();
          case 'hire':
            onHire();
        }
      },
      itemBuilder: (_) => [
        _menuItem('skills', 'Skills'),
        _menuItem('projects', 'Projects'),
        _menuItem('experience', 'Experience'),
        _menuItem('reviews', 'Reviews'),
        _menuItem('hire', 'Hire Me'),
      ],
    );
  }

  PopupMenuItem<String> _menuItem(String value, String label) {
    return PopupMenuItem(
      value: value,
      child: Text(label,
          style: AppTheme.dmMono(
              size: 11, color: AppTheme.white, letterSpacing: 1.0)),
    );
  }
}

// ── SKILLS SECTION ────────────────────────────────────────────────────────

class _SkillsSection extends StatelessWidget {
  const _SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Container(
      color: AppTheme.navyMid,
      width: double.infinity,
      padding: _sectionPadding(w),
      child: _contentBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              label: 'Core Expertise',
              title: 'What I Bring to\nYour Project',
              subtitle:
                  'A full-stack Flutter skillset — from architecture planning to App Store submission — across mobile and web platforms.',
            ),
            _ResponsiveGrid(
              mobileColumns: 1,
              tabletColumns: 2,
              desktopColumns: 3,
              spacing: 20,
              children:
                  skillCards.map((c) => SkillCardWidget(card: c)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// ── PROJECTS SECTION ──────────────────────────────────────────────────────

class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Container(
      color: AppTheme.navy,
      width: double.infinity,
      padding: _sectionPadding(w),
      child: _contentBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              label: 'Selected Work',
              title: 'Projects That\nDelivered Results',
              subtitle:
                  'A curated selection of client engagements across industries — each built with scalability, performance, and user experience at the forefront.',
            ),
            _ResponsiveGrid(
              mobileColumns: 1,
              tabletColumns: 2,
              desktopColumns: 2,
              spacing: 24,
              children: projects
                  .map((p) => ProjectCardWidget(project: p))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// ── EXPERIENCE SECTION ────────────────────────────────────────────────────

class _ExperienceSection extends StatelessWidget {
  const _ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Container(
      color: AppTheme.navyMid,
      width: double.infinity,
      padding: _sectionPadding(w),
      child: _contentBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              label: 'Career Timeline',
              title: 'Professional\nExperience',
              subtitle:
                  '4.5+ years of progressive growth — from training programs to senior Flutter development across multiple industries.',
            ),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 40,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 19,
                          top: 8,
                          bottom: 0,
                          child: Container(
                            width: 1,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppTheme.teal,
                                  AppTheme.teal.withValues(alpha: 0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: experiences
                          .map((e) => _TimelineItem(experience: e))
                          .toList(),
                    ),
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

class _TimelineItem extends StatelessWidget {
  final Experience experience;
  const _TimelineItem({required this.experience});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 17,
            height: 17,
            margin: const EdgeInsets.only(right: 28, top: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.navy,
              border: Border.all(color: AppTheme.teal, width: 2),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.teal.withValues(alpha: 0.4),
                  blurRadius: 10,
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 12,
                  runSpacing: 6,
                  children: [
                    Text(experience.period,
                        style: AppTheme.dmMono(
                            size: 10,
                            color: AppTheme.gold,
                            letterSpacing: 1.0)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(color: AppTheme.borderColor),
                      ),
                      child: Text(experience.badge.toUpperCase(),
                          style: AppTheme.dmMono(
                              size: 8,
                              color: AppTheme.muted,
                              letterSpacing: 0.8)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(experience.role,
                    style:
                        AppTheme.playfair(size: 18, color: AppTheme.white)),
                const SizedBox(height: 4),
                Text(experience.company,
                    style: AppTheme.dmSans(
                        size: 13,
                        color: AppTheme.teal,
                        weight: FontWeight.w500)),
                const SizedBox(height: 14),
                ...experience.points.map((p) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('▸ ',
                              style: AppTheme.dmSans(
                                  size: 13, color: AppTheme.teal)),
                          Expanded(
                            child: Text(p,
                                style: AppTheme.dmSans(
                                    size: 13,
                                    color: AppTheme.muted,
                                    height: 1.65)),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── TESTIMONIALS SECTION ──────────────────────────────────────────────────

class _TestimonialsSection extends StatelessWidget {
  const _TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Container(
      color: AppTheme.navy,
      width: double.infinity,
      padding: _sectionPadding(w),
      child: _contentBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              label: 'Client Reviews',
              title: 'What Clients\nSay',
              subtitle:
                  'Feedback from Upwork clients and long-term collaborators.',
            ),
            _ResponsiveGrid(
              mobileColumns: 1,
              tabletColumns: 2,
              desktopColumns: 3,
              spacing: 20,
              children: testimonials
                  .map((t) => TestimonialCardWidget(testimonial: t))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// ── CONTACT SECTION ───────────────────────────────────────────────────────

class _ContactSection extends StatelessWidget {
  const _ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Container(
      color: AppTheme.navyMid,
      width: double.infinity,
      padding: _sectionPadding(w),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 50,
                      height: 1,
                      color: AppTheme.teal.withValues(alpha: 0.5)),
                  const SizedBox(width: 12),
                  Text('GET IN TOUCH',
                      style: AppTheme.dmMono(
                          size: 11,
                          color: AppTheme.teal,
                          letterSpacing: 2.5)),
                  const SizedBox(width: 12),
                  Container(
                      width: 50,
                      height: 1,
                      color: AppTheme.teal.withValues(alpha: 0.5)),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Ready to Build\nSomething Great?',
                textAlign: TextAlign.center,
                style: AppTheme.playfair(
                    size: w >= AppTheme.bpMobile ? 36 : 28, height: 1.15),
              ),
              const SizedBox(height: 16),
              Text(
                "I'm currently accepting new Flutter projects. Whether you need a full app built from scratch or an existing codebase improved, let's talk.",
                textAlign: TextAlign.center,
                style: AppTheme.dmSans(
                    size: 15, color: AppTheme.muted, height: 1.7),
              ),
              const SizedBox(height: 36),
              Wrap(
                spacing: 16,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  _ContactCTAButton(
                    label: 'Email Me',
                    onTap: () => launchUrl(
                        Uri.parse('mailto:mvbhojani007@gmail.com')),
                  ),
                  _ContactCTAButton(
                    label: 'LinkedIn',
                    onTap: () => launchUrl(Uri.parse(
                        'https://www.linkedin.com/in/mihir-bhojani-bha1542')),
                    isSecondary: true,
                  ),
                ],
              ),
              const SizedBox(height: 44),
              Container(height: 1, color: AppTheme.borderColor),
              const SizedBox(height: 36),
              const Wrap(
                spacing: 36,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _ContactInfoItem(
                      label: 'Email', value: 'mvbhojani007@gmail.com'),
                  _ContactInfoItem(
                      label: 'Phone', value: '+91 97732 55821'),
                  _ContactInfoItem(
                      label: 'Timezone', value: 'IST (UTC+5:30)'),
                  _ContactInfoItem(
                      label: 'Education',
                      value: 'BCA · Veer Narmad South Gujarat University'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactCTAButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool isSecondary;

  const _ContactCTAButton({
    required this.label,
    required this.onTap,
    this.isSecondary = false,
  });

  @override
  State<_ContactCTAButton> createState() => _ContactCTAButtonState();
}

class _ContactCTAButtonState extends State<_ContactCTAButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 16),
          decoration: BoxDecoration(
            color: widget.isSecondary
                ? (_hovered
                    ? AppTheme.teal.withValues(alpha: 0.1)
                    : Colors.transparent)
                : (_hovered ? AppTheme.tealSoft : AppTheme.teal),
            borderRadius: BorderRadius.circular(4),
            border: widget.isSecondary
                ? Border.all(
                    color: _hovered
                        ? AppTheme.teal
                        : AppTheme.white.withValues(alpha: 0.25))
                : null,
          ),
          child: Text(widget.label,
              style: AppTheme.dmSans(
                  size: 15,
                  weight: FontWeight.w600,
                  color: widget.isSecondary
                      ? (_hovered ? AppTheme.teal : AppTheme.white)
                      : AppTheme.navy)),
        ),
      ),
    );
  }
}

class _ContactInfoItem extends StatelessWidget {
  final String label;
  final String value;
  const _ContactInfoItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label.toUpperCase(),
            style: AppTheme.dmMono(
                size: 9, color: AppTheme.muted, letterSpacing: 1.0)),
        const SizedBox(height: 6),
        Text(value,
            style: AppTheme.dmSans(
                size: 14, color: AppTheme.teal, weight: FontWeight.w500)),
      ],
    );
  }
}

// ── FOOTER ────────────────────────────────────────────────────────────────

class _Footer extends StatelessWidget {
  final VoidCallback onTop;
  const _Footer({required this.onTop});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < AppTheme.bpMobile;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: _hPad(w), vertical: 24),
      decoration: const BoxDecoration(
        color: AppTheme.navy,
        border: Border(top: BorderSide(color: AppTheme.borderColor)),
      ),
      child: _contentBox(
        child: isMobile
            ? Column(
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: onTop,
                      child: Text('↑ BACK TO TOP',
                          style: AppTheme.dmMono(
                              size: 10,
                              color: AppTheme.teal,
                              letterSpacing: 1.0)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('© 2026 Mihir Bhojani · Flutter Developer',
                      style:
                          AppTheme.dmMono(size: 10, color: AppTheme.muted)),
                ],
              )
            : Row(
                children: [
                  Text('© 2026 Mihir Bhojani · Flutter Developer',
                      style:
                          AppTheme.dmMono(size: 10, color: AppTheme.muted)),
                  const Spacer(),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: onTop,
                      child: Text('↑ BACK TO TOP',
                          style: AppTheme.dmMono(
                              size: 10,
                              color: AppTheme.teal,
                              letterSpacing: 1.0)),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
