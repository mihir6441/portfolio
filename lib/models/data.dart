class SkillCard {
  final String icon;
  final String title;
  final List<String> tags;

  const SkillCard({
    required this.icon,
    required this.title,
    required this.tags,
  });
}

class Project {
  final String domain;
  final DomainType domainType;
  final String platform;
  final String title;
  final String description;
  final List<String> tech;
  final List<ProjectMetric> metrics;
  final String? appStoreUrl;
  final String? playStoreUrl;

  const Project({
    required this.domain,
    required this.domainType,
    required this.platform,
    required this.title,
    required this.description,
    required this.tech,
    required this.metrics,
    this.appStoreUrl,
    this.playStoreUrl,
  });
}

enum DomainType { fintech, health, social, enterprise, travel, education }

class ProjectMetric {
  final String value;
  final String label;

  const ProjectMetric(this.value, this.label);
}

class Experience {
  final String period;
  final String badge;
  final String role;
  final String company;
  final List<String> points;

  const Experience({
    required this.period,
    required this.badge,
    required this.role,
    required this.company,
    required this.points,
  });
}

class Testimonial {
  final String quote;
  final String name;
  final String role;
  final String initials;

  const Testimonial({
    required this.quote,
    required this.name,
    required this.role,
    required this.initials,
  });
}

// ── DATA ──────────────────────────────────────────────────────────────────

final List<SkillCard> skillCards = [
  const SkillCard(
    icon: '📱',
    title: 'Mobile App Development',
    tags: [
      'Flutter iOS & Android Apps',
      'Cross-Platform Development',
      'App Store & Play Store Deployment',
      'Performance Optimization',
      'Push Notifications & Deep Linking',
    ],
  ),
  const SkillCard(
    icon: '🌐',
    title: 'Flutter Web Apps',
    tags: [
      'Responsive Web Applications',
      'Progressive Web Apps (PWA)',
      'Web Socket Integration',
      'SEO-Friendly Flutter Web',
      'Admin Dashboards & Portals',
    ],
  ),
  const SkillCard(
    icon: '🏗️',
    title: 'Architecture & State Management',
    tags: [
      'Clean Architecture Setup',
      'BLoC / Provider / GetX',
      'MVVM & MVC Patterns',
      'Scalable Codebase Design',
      'Code Review & Refactoring',
    ],
  ),
  const SkillCard(
    icon: '🔥',
    title: 'Firebase & Backend Integration',
    tags: [
      'Firestore & Realtime Database',
      'Cloud Messaging & Crashlytics',
      'REST API & GraphQL Integration',
      'Authentication & Security',
      'MySQL / SQLite / Remote Config',
    ],
  ),
  const SkillCard(
    icon: '🤖',
    title: 'AI & Machine Learning Integration',
    tags: [
      'OpenAI / GPT API Integration',
      'AI Chatbots & Virtual Assistants',
      'Smart Recommendations Engine',
      'Image Recognition & OCR',
      'TensorFlow Lite / On-Device ML',
      'AI-Powered Search & Filters',
    ],
  ),
  const SkillCard(
    icon: '💳',
    title: 'Third-Party SDK Integration',
    tags: [
      'Stripe / Razorpay Payments',
      'Google Maps & Location Services',
      'Sentry Error Tracking',
      'Auth0 & Social Login',
      'Analytics & Charts',
    ],
  ),
  const SkillCard(
    icon: '🚀',
    title: 'DevOps & App Maintenance',
    tags: [
      'CI/CD (GitHub Actions, CodeMagic)',
      'App Store & Play Store Submission',
      'Bug Fixing & Performance Tuning',
      'Version Control (Git)',
      'Ongoing Support & Maintenance',
    ],
  ),
];

final List<Project> projects = [
  const Project(
    domain: 'Education',
    domainType: DomainType.education,
    platform: '📱 iOS & Android',
    title: 'Digital Regenesys Education',
    description:
        'AI-enhanced mobile learning companion enabling seamless access to live classes, quizzes, session recordings, and adaptive progress tracking. Integrated smart content recommendations and personalized learning paths for an intelligent education experience.',
    tech: ['Flutter', 'Dart', 'Firebase', 'REST API', 'BLoC', 'AI/ML'],
    metrics: [
      ProjectMetric('Live', 'Classes'),
      ProjectMetric('Quiz', 'Engine'),
      ProjectMetric('Track', 'Progress'),
    ],
    appStoreUrl:
        'https://apps.apple.com/in/app/digital-regenesys-education/id6740993018',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.digitalregenesys.app',
  ),
  const Project(
    domain: 'Travel',
    domainType: DomainType.travel,
    platform: '📱 iOS & Android',
    title: 'Trip Attendynt',
    description:
        'AI-driven travel assistant app enabling seamless trip management with intelligent itinerary suggestions, airport pickups, curated sightseeing, and personalised shopping. Integrated real-time updates and AI-powered recommendations for a smart travel companion.',
    tech: ['Flutter', 'Dart', 'Google Maps', 'REST API', 'Firebase', 'AI Recommendations'],
    metrics: [
      ProjectMetric('Real-time', 'Updates'),
      ProjectMetric('Curated', 'Trips'),
      ProjectMetric('Custom', 'Itinerary'),
    ],
    appStoreUrl: 'https://apps.apple.com/in/app/tripattendynt/id6670303549',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.trip.attendynt',
  ),
  const Project(
    domain: 'AI / Crypto',
    domainType: DomainType.fintech,
    platform: '📱 Mobile App',
    title: 'Ailtra — AI-Powered Crypto Bot',
    description:
        'AI-powered cryptocurrency trading bot leveraging advanced algorithms to make real-time buy/sell decisions, achieving a 98.5% success rate in profit generation. Enhanced reliability through continuous improvements for consistent, trustworthy performance.',
    tech: ['Flutter', 'Dart', 'AI/ML', 'WebSocket', 'REST API', 'BLoC'],
    metrics: [
      ProjectMetric('98.5%', 'Success Rate'),
      ProjectMetric('Real-time', 'Trading'),
      ProjectMetric('AI', 'Powered'),
    ],
  ),
  const Project(
    domain: 'E-commerce',
    domainType: DomainType.enterprise,
    platform: '📱 iOS & Android',
    title: 'Teustar App',
    description:
        'Browse through local store promotions, coupons, and discounts, and conveniently make purchases from nearby businesses. Promotes eco-friendly practices by minimizing consumption of traditional paper fliers and coupons.',
    tech: ['Flutter', 'Dart', 'Firebase', 'REST API', 'Google Maps'],
    metrics: [
      ProjectMetric('Local', 'Deals'),
      ProjectMetric('Eco', 'Friendly'),
      ProjectMetric('Nearby', 'Stores'),
    ],
    appStoreUrl: 'https://apps.apple.com/in/app/teustar/id1627667445',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.teustar.teustar',
  ),
  const Project(
    domain: 'Social',
    domainType: DomainType.social,
    platform: '📱 iOS & Android',
    title: 'Mangalya Jodi',
    description:
        'AI-powered matchmaking app designed for various groups of people seeking life partners. Leverages intelligent algorithms and preference-based scoring to connect individuals through detailed profiles, compatibility insights, and smart matching.',
    tech: ['Flutter', 'Dart', 'Firebase', 'REST API', 'AI Matching', 'Provider'],
    metrics: [
      ProjectMetric('Smart', 'Matching'),
      ProjectMetric('Profile', 'Verified'),
      ProjectMetric('Secure', 'Chat'),
    ],
    appStoreUrl: 'https://apps.apple.com/in/app/mangalya-jodi/id6443634966',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.app.mangalyajodi',
  ),
  const Project(
    domain: 'Healthcare',
    domainType: DomainType.health,
    platform: '📱 iOS & Android',
    title: 'InjuryTrak',
    description:
        'Real-time injury data collection and tracking platform for businesses. Effortlessly access real-time information delivered directly to mobile devices, eliminating delays and ensuring you stay ahead of the competition.',
    tech: ['Flutter', 'Dart', 'REST API', 'Firebase', 'SQLite'],
    metrics: [
      ProjectMetric('Real-time', 'Data'),
      ProjectMetric('Mobile', 'First'),
      ProjectMetric('Business', 'Ready'),
    ],
    appStoreUrl: 'https://apps.apple.com/in/app/injurytrak-v2/id6449781011',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.chirotrack.injurytrak',
  ),
  const Project(
    domain: 'Property',
    domainType: DomainType.enterprise,
    platform: '📱 iOS & Android',
    title: 'Teustar Property Management',
    description:
        'Streamlined property management platform facilitating efficient communication and connecting stakeholders for prompt action. Contributes to environmental sustainability by diminishing reliance on paper-based communication.',
    tech: ['Flutter', 'Dart', 'Firebase', 'REST API', 'Google Maps'],
    metrics: [
      ProjectMetric('Eco', 'Friendly'),
      ProjectMetric('Multi', 'Tenant'),
      ProjectMetric('Revenue', 'Driven'),
    ],
    appStoreUrl:
        'https://apps.apple.com/in/app/teustar-property-management/id1667314435',
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.teustarpm',
  ),
  const Project(
    domain: 'Business',
    domainType: DomainType.enterprise,
    platform: '📱 iOS & Android',
    title: 'Teustar Business Account',
    description:
        'Businesses engage nearby customers through tailored discounts, promotions, coupons, and notifications within a 10 km radius. Eco-friendly approach replacing traditional paper ads with convenient digital offers accessible in the app.',
    tech: ['Flutter', 'Dart', 'Firebase', 'REST API', 'Geolocation'],
    metrics: [
      ProjectMetric('10km', 'Radius'),
      ProjectMetric('Digital', 'Coupons'),
      ProjectMetric('Geo', 'Targeted'),
    ],
    appStoreUrl:
        'https://apps.apple.com/in/app/teustar-business-account/id1639046086',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.epistlz.epistlz_tab',
  ),
];

final List<Experience> experiences = [
  const Experience(
    period: 'Mar 2025 — Present',
    badge: 'Current',
    role: 'Senior Flutter & AI Developer',
    company: 'Regenesys Education',
    points: [
      'Integrated AI-powered features including smart content recommendations and adaptive learning paths into the education platform.',
      'Improved and corrected existing software and system applications using data-driven debugging.',
      'Analyzed user needs and software requirements to determine design feasibility, leveraging AI tools for rapid prototyping.',
    ],
  ),
  const Experience(
    period: 'Jan 2023 — Feb 2025',
    badge: 'Full-Time',
    role: 'Flutter & AI Integration Developer',
    company: 'Onviqa PVT LTD',
    points: [
      'Built AI-powered crypto trading bot (Ailtra) with real-time ML-driven buy/sell decisions achieving 98.5% success rate.',
      'Collaborated with cross-functional teams to integrate OpenAI APIs, chatbot interfaces, and intelligent recommendation engines into Flutter apps.',
      'Stayed updated on latest AI/ML trends and emerging technologies, contributing to continuous improvement of development processes.',
    ],
  ),
  const Experience(
    period: 'Oct 2021 — Nov 2022',
    badge: 'Full-Time',
    role: 'Flutter App Developer',
    company: 'Koolmind TechnoLab LLP',
    points: [
      'Developed user-friendly applications with a strong understanding of design fundamentals.',
      'Conducted code reviews and provided feedback to improve code quality and maintainability.',
    ],
  ),
  const Experience(
    period: 'Jan 2021 — Jun 2021',
    badge: 'Training',
    role: 'Flutter App Developer (Training)',
    company: 'FreshCodes Technology',
    points: [
      'Completed intensive Flutter & Dart development training program.',
      'Built hands-on projects covering state management, REST API integration, and Firebase.',
    ],
  ),
  const Experience(
    period: 'May 2020 — Dec 2020',
    badge: 'Training',
    role: 'Android App Developer (Training)',
    company: 'The Creative Concept',
    points: [
      'Gained foundational experience in Android development with Java and Kotlin.',
      'Learned core concepts of mobile UI design and application lifecycle management.',
    ],
  ),
];

final List<Testimonial> testimonials = [
  const Testimonial(
    quote:
        'Mihir delivered our education platform with exceptional attention to detail. His Flutter expertise and clean architecture made the codebase highly maintainable. The app handles live classes and quizzes flawlessly.',
    name: 'Regenesys Team',
    role: 'Product Lead · Regenesys Education',
    initials: 'RE',
  ),
  const Testimonial(
    quote:
        'Working with Mihir on the Trip Attendynt app was a great experience. He integrated complex features like real-time updates and curated travel itineraries seamlessly. Highly professional and reliable developer.',
    name: 'Onviqa Team',
    role: 'Project Manager · Onviqa PVT LTD',
    initials: 'OT',
  ),
  const Testimonial(
    quote:
        'Mihir brought deep Flutter expertise to our Teustar ecosystem of apps. From property management to business accounts, he consistently delivered high-quality, scalable mobile solutions on time.',
    name: 'Koolmind Team',
    role: 'Tech Lead · Koolmind TechnoLab',
    initials: 'KT',
  ),
];
