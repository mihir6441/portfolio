# Flutter Developer Portfolio App

A professional, fully responsive Flutter portfolio app — built for Upwork profiles.

## Features
- 🎨 Navy + Teal + Gold design system
- ✨ Smooth scroll animations & hover effects
- 📱 Responsive layout (mobile, tablet, desktop)
- 🌐 Works on Flutter Web, iOS & Android
- 🗂 Sections: Hero, Skills, Projects, Experience, Testimonials, Contact

## Project Structure
```
lib/
├── main.dart                  # App entry point
├── theme/
│   └── app_theme.dart         # Colors, fonts, text styles
├── models/
│   └── data.dart              # All portfolio data (edit this!)
├── widgets/
│   └── widgets.dart           # Reusable UI components
└── screens/
    ├── hero_section.dart      # Hero with animations
    └── portfolio_screen.dart  # Main screen + all sections
```

## Quick Start

### 1. Install Flutter
https://docs.flutter.dev/get-started/install

### 2. Install dependencies
```bash
cd portfolio_app
flutter pub get
```

### 3. Run on web (recommended for portfolio)
```bash
flutter run -d chrome
```

### 4. Run on mobile
```bash
flutter run -d ios      # or android
```

## Personalise It

### Change your info
Edit `lib/models/data.dart`:
- Update project names, descriptions, and metrics
- Edit experience timeline entries
- Replace testimonial quotes and client names

### Change your name
Search and replace `Alex Morgan` with your name in:
- `lib/screens/portfolio_screen.dart` (NavBar logo + footer)
- `lib/main.dart` (app title)

### Add Upwork profile link
In `lib/screens/portfolio_screen.dart`, find `_ContactCTAButton` and update:
```dart
onTap: () async {
  await launchUrl(Uri.parse('https://www.upwork.com/freelancers/~YOUR_ID'));
},
```

## Dependencies Used
| Package | Purpose |
|---------|---------|
| `google_fonts` | Playfair Display + DM Sans + DM Mono fonts |
| `animate_do` | Entry animations (optional) |
| `url_launcher` | Open Upwork profile link |

## Deploy to Web
```bash
flutter build web --release
# Output in: build/web/
```
Upload the `build/web` folder to Netlify, Vercel, or Firebase Hosting for a live portfolio link you can add to your Upwork profile.
