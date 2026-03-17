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

  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _testimonialsKey = GlobalKey();
  final _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx,
          duration: const Duration(milliseconds: 700), curve: Curves.easeInOut);
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
                _AboutSection(
                    key: _aboutKey, onHire: () => _scrollTo(_contactKey)),
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
            onAbout: () => _scrollTo(_aboutKey),
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

double _hPad(double w) =>
    w >= AppTheme.bpTablet ? 60 : (w >= AppTheme.bpMobile ? 40 : 20);

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
  final VoidCallback onAbout;
  final VoidCallback onSkills;
  final VoidCallback onProjects;
  final VoidCallback onExperience;
  final VoidCallback onTestimonials;
  final VoidCallback onHire;

  const _NavBar({
    required this.onAbout,
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
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'M',
                    style: AppTheme.playfair(size: 20, color: AppTheme.teal),
                  ),
                  TextSpan(
                    text: '/',
                    style: AppTheme.playfair(size: 20, color: AppTheme.gold),
                  ),
                  TextSpan(
                    text: 'B',
                    style: AppTheme.playfair(size: 20, color: AppTheme.teal),
                  ),
                ],
              ),
            ),
            const Spacer(),
            if (showFullNav) ...[
              NavLink(label: 'About', onTap: onAbout),
              const SizedBox(width: 28),
              NavLink(label: 'Services', onTap: onSkills),
              const SizedBox(width: 28),
              NavLink(label: 'Portfolio', onTap: onProjects),
              const SizedBox(width: 28),
              NavLink(label: 'Testimonial', onTap: onTestimonials),
              const SizedBox(width: 28),
              NavLink(label: 'Contact', onTap: onHire),
              const SizedBox(width: 28),
              NavLink(label: 'Hire Me', onTap: onHire, isCta: true),
            ] else ...[
              NavLink(label: 'Hire Me', onTap: onHire, isCta: true),
              const SizedBox(width: 8),
              _MobileMenuButton(
                onAbout: onAbout,
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
  final VoidCallback onAbout;
  final VoidCallback onSkills;
  final VoidCallback onProjects;
  final VoidCallback onExperience;
  final VoidCallback onTestimonials;
  final VoidCallback onHire;

  const _MobileMenuButton({
    required this.onAbout,
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
          case 'about':
            onAbout();
          case 'services':
            onSkills();
          case 'portfolio':
            onProjects();
          case 'experience':
            onExperience();
          case 'testimonial':
            onTestimonials();
          case 'contact':
            onHire();
        }
      },
      itemBuilder: (_) => [
        _menuItem('about', 'About'),
        _menuItem('services', 'Services'),
        _menuItem('portfolio', 'Portfolio'),
        _menuItem('experience', 'Experience'),
        _menuItem('testimonial', 'Testimonial'),
        _menuItem('contact', 'Contact'),
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

// ── ABOUT SECTION ─────────────────────────────────────────────────────────

class _AboutSection extends StatelessWidget {
  final VoidCallback onHire;
  const _AboutSection({super.key, required this.onHire});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < AppTheme.bpMobile;
    final isDesktop = w >= AppTheme.bpTablet;

    return Container(
      color: AppTheme.navy,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            left: -60,
            top: 30,
            child: _CircleDecor(
                size: isDesktop ? 500 : 350,
                color: AppTheme.teal,
                opacity: 0.18),
          ),
          Positioned(
            right: -40,
            bottom: 20,
            child: _CircleDecor(
                size: isDesktop ? 400 : 280,
                color: AppTheme.gold,
                opacity: 0.12),
          ),
          Padding(
            padding: _sectionPadding(w),
            child: _contentBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    label: 'About Me',
                    title:
                        'I Can Deliver Results\nThat Exceed Your Expectations',
                    subtitle: '',
                  ),
                  isDesktop
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: _aboutText(),
                            ),
                            const SizedBox(width: 60),
                            Expanded(
                              flex: 2,
                              child: _aboutStats(isMobile, onHire),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _aboutText(),
                            const SizedBox(height: 40),
                            _aboutStats(isMobile, onHire),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _aboutText() {
    return Text(
      'With over 4.5 years of professional experience as a Flutter developer in the IT industry, I am deeply passionate and dedicated to delivering exceptional work. My commitment to excellence is evident in every project I undertake.\n\n'
      'I specialize in building high-performance, AI-enabled mobile and web applications using Flutter, Dart, and Swift. From integrating OpenAI/GPT-powered chatbots and smart recommendation engines to implementing on-device ML with TensorFlow Lite — I bring cutting-edge AI capabilities into production-ready apps.\n\n'
      'My expertise spans clean architecture, state management, Firebase, and the complete development lifecycle. Whether you need an AI-powered MVP, an intelligent feature added to an existing app, or a dedicated Flutter developer — I bring reliability, clear communication, and future-ready solutions to every engagement.',
      style: AppTheme.dmSans(size: 15, color: AppTheme.muted, height: 1.85),
    );
  }

  Widget _aboutStats(bool isMobile, VoidCallback onHire) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _statBlock('8', '+', 'Projects\nCompleted')),
            const SizedBox(width: 20),
            Expanded(child: _statBlock('5', '+', 'Companies\nWorked With')),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: _statBlock('4.5', '+', 'Years of\nExperience')),
            const SizedBox(width: 20),
            Expanded(child: _statBlock('100', '%', 'Client\nSatisfaction')),
          ],
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: _HireButton(onTap: onHire),
        ),
      ],
    );
  }

  Widget _statBlock(String value, String suffix, String label) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  text: suffix,
                  style: AppTheme.playfair(
                      size: 20, color: AppTheme.gold, weight: FontWeight.w700),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(label,
              style: AppTheme.dmMono(
                  size: 10, color: AppTheme.muted, letterSpacing: 0.8)),
        ],
      ),
    );
  }
}

class _HireButton extends StatefulWidget {
  final VoidCallback onTap;
  const _HireButton({required this.onTap});

  @override
  State<_HireButton> createState() => _HireButtonState();
}

class _HireButtonState extends State<_HireButton> {
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
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: _hovered ? AppTheme.tealSoft : AppTheme.teal,
            borderRadius: BorderRadius.circular(6),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppTheme.teal.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    )
                  ]
                : [],
          ),
          child: Center(
            child: Text('Hire Me Now',
                style: AppTheme.dmSans(
                    size: 16, weight: FontWeight.w700, color: AppTheme.navy)),
          ),
        ),
      ),
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
      child: Stack(
        children: [
          const Positioned(
            right: -50,
            top: 60,
            child: _CircleDecor(size: 450, color: AppTheme.teal, opacity: 0.15),
          ),
          Padding(
            padding: _sectionPadding(w),
            child: _contentBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    label: 'Services',
                    title: 'Available Services\nI Can Work On',
                    subtitle:
                        'End-to-end Flutter development services — from initial consultation to App Store deployment and ongoing maintenance.',
                  ),
                  _ResponsiveGrid(
                    mobileColumns: 1,
                    tabletColumns: 2,
                    desktopColumns: 3,
                    spacing: 20,
                    children: skillCards
                        .map((c) => SkillCardWidget(card: c))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
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
      child: Stack(
        children: [
          const Positioned(
            right: -60,
            top: 80,
            child: _CircleDecor(
                size: 550,
                color: AppTheme.teal,
                opacity: 0.15,
                showRings: true),
          ),
          const Positioned(
            left: -40,
            bottom: 60,
            child: _CircleDecor(size: 400, color: AppTheme.gold, opacity: 0.10),
          ),
          Padding(
            padding: _sectionPadding(w),
            child: _contentBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    label: 'Portfolio',
                    title: 'Selected Works\n2020 — 2026',
                    subtitle:
                        'A curated selection of client projects across industries — each built with scalability, performance, and user experience at the forefront.',
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
          ),
        ],
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
      child: Stack(
        children: [
          const Positioned(
            left: -50,
            top: 80,
            child: _CircleDecor(size: 450, color: AppTheme.teal, opacity: 0.15),
          ),
          Padding(
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
          ),
        ],
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
                    style: AppTheme.playfair(size: 18, color: AppTheme.white)),
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
      child: Stack(
        children: [
          const Positioned(
            left: -40,
            top: 40,
            child: _CircleDecor(
                size: 450,
                color: AppTheme.teal,
                opacity: 0.15,
                showRings: true),
          ),
          Padding(
            padding: _sectionPadding(w),
            child: _contentBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    label: 'Client Reviews',
                    title: 'What Clients\nSay',
                    subtitle:
                        'Feedback from clients and long-term collaborators.',
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
          ),
        ],
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
      child: Stack(
        children: [
          const Positioned(
            right: -30,
            top: -20,
            child: _CircleDecor(size: 400, color: AppTheme.teal, opacity: 0.16),
          ),
          Padding(
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
                        Text('CONTACT',
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
                      "Let's Talk to\nCollaborate",
                      textAlign: TextAlign.center,
                      style: AppTheme.playfair(
                          size: w >= AppTheme.bpMobile ? 36 : 28, height: 1.15),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "I'm available on Upwork for new Flutter projects. Whether you need a full app built from scratch, an existing codebase improved, or ongoing maintenance — let's connect.",
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
                          label: 'Hire Me on Upwork',
                          onTap: () => launchUrl(Uri.parse(
                              'https://www.upwork.com/freelancers/~0189158d71e0960484?mp_source=share')),
                        ),
                        _ContactCTAButton(
                          label: 'Email Me',
                          onTap: () => launchUrl(
                              Uri.parse('mailto:mvbhojani007@gmail.com')),
                          isSecondary: true,
                        ),
                        _ContactCTAButton(
                          label: 'LinkedIn',
                          onTap: () => launchUrl(Uri.parse(
                              'https://www.linkedin.com/in/mihir-bhojani-bha1542/')),
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
                            value:
                                'BCA · Veer Narmad South Gujarat University'),
                      ],
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
                      style: AppTheme.dmMono(size: 10, color: AppTheme.muted)),
                ],
              )
            : Row(
                children: [
                  Text('© 2026 Mihir Bhojani · Flutter Developer',
                      style: AppTheme.dmMono(size: 10, color: AppTheme.muted)),
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

// ── BACKGROUND DECORATIONS ───────────────────────────────────────────────

class _CircleDecor extends StatelessWidget {
  final double size;
  final Color color;
  final double opacity;
  final bool showRings;

  const _CircleDecor({
    required this.size,
    required this.color,
    this.opacity = 0.07,
    this.showRings = false,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox(
        width: size,
        height: size,
        child: showRings
            ? Stack(
                children: [
                  _glowContainer(),
                  CustomPaint(
                    size: Size(size, size),
                    painter:
                        _RingsPainter(color: color, opacity: opacity * 0.7),
                  ),
                ],
              )
            : _glowContainer(),
      ),
    );
  }

  Widget _glowContainer() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withValues(alpha: opacity),
            color.withValues(alpha: opacity * 0.6),
            color.withValues(alpha: opacity * 0.2),
            Colors.transparent,
          ],
          stops: const [0.0, 0.3, 0.6, 1.0],
        ),
      ),
    );
  }
}

class _RingsPainter extends CustomPainter {
  final Color color;
  final double opacity;
  _RingsPainter({required this.color, required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxR = size.width * 0.42;

    for (var i = 1; i <= 3; i++) {
      final r = maxR * (0.4 + i * 0.25);
      final a = (opacity - (i - 1) * 0.02).clamp(0.02, opacity);
      canvas.drawCircle(
        center,
        r,
        Paint()
          ..color = color.withValues(alpha: a)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
    }
  }

  @override
  bool shouldRepaint(_RingsPainter old) => false;
}
