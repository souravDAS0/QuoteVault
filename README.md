# QuoteVault

QuoteVault is a modern Flutter application designed for discovering, collecting, and sharing inspiring quotes. Built with a "Feature-First" Clean Architecture, it leverages Supabase for backend services and Riverpod for state management to deliver a premium, offline-capable user experience.

## ✨ Features

- **Daily Inspiration**: Receive a new quote every day with scheduled local notifications.
- **Explore & Discover**: Browse a vast collection of quotes from various authors.
- **Curated Collections**: Save and organize your favorite quotes into custom collections.
- **Offline Support**: Access your collections and content even without an internet connection.
- **Shareable Art**: Generate beautiful, social-media-ready images of quotes to share with friends.
- **Premium Aesthetics**: A stunning UI with dark mode support, smooth animations, and dynamic theming.
- **Profile Management**: Customize your profile and manage your account settings.

## 📲 Download APK

Scan the QR code below to download the latest APK from App landing page:

![Download APK QR Code](assets/images/quotevault_landing_page.png)

## 🛠️ Architecture

The project follows a **Feature-First** architecture pattern, promoting modularity and maintainability.

### Directory Structure

```
lib/
├── core/                   # Shared utilities, widgets, and configurations
│   ├── application/        # Global controllers (e.g., Connectivity)
│   ├── config/             # Theme, Router, Environment config
│   ├── services/           # External services (Supabase, Notifications)
│   └── widgets/            # Reusable UI components
├── features/               # Feature-specific modules
│   ├── auth/               # Authentication logic & UI
│   ├── collections/        # Quote collections management
│   ├── home_feed/          # Main quote feed
│   ├── profile/            # User profile & account editing
│   ├── settings/           # App settings (Notifications, Theme)
│   └── sharing/            # Image generation & sharing logic
└── main.dart               # App entry point & initialization
```

### Key Technologies

- **Framework**: Flutter
- **State Management**: [Riverpod](https://riverpod.dev/) (Providers, ConsumerWidgets)
- **Backend / Auth**: [Supabase](https://supabase.com/) (Postgres, Auth, Edge Functions)
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router)
- **Local Storage**: Shared Preferences & Local Database
- **Background Tasks**: [WorkManager](https://pub.dev/packages/workmanager)
- **Notifications**: Flutter Local Notifications

## 🚀 Setup Instructions

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- A Supabase project

### 1. Clone the repository

```bash
git clone https://github.com/yourusername/quote_vault.git
cd quote_vault
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Supabase Configuration

Create a `.env` file in the root directory (add to `.gitignore` to keep it safe). Add your Supabase project credentials:

```env
SUPABASE_URL=YOUR_SUPABASE_PROJECT_URL
SUPABASE_ANON_KEY=YOUR_SUPABASE_ANON_KEY
```

> **Note**: You can find these in your Supabase Dashboard under `Settings > API`.

### 4. Run the App

```bash
flutter run
```

## 🤖 AI Development Workflow

This project was built using an advanced agentic AI workflow, treating AI as a pair programmer.

### The Agentic Stack

- **Claude Code (Pro)**: The primary coding agent.
- **Antigravity**: Powered by **Sonnet 3.5** and **Gemini 1.5 Pro**, utilized for complex architectural planning and refactoring.
- **Supabase MCP**: Used for direct interaction with the backend database for migrations and queries.

### Workflow Process

1.  **Task Scoping**:
    - Tasks are defined and scoped using `.claude/commands/scope/md`.
    - Individual task files are generated to break down complex features.
2.  **Context Loading**:
    - The `/scope <task-name>.md` command is used to load specific task contexts into the agent's memory (`current_task.md`).
3.  **Visual Implementation**:
    - **Stitch / Figma** Designs are used as the source of truth for UI.
    - AI agents read `Claude.md` instructions and "look" at the design specs to generate pixel-perfect UI screens.
4.  **Refinement**:
    - Logic is stitched together with the UI.
    - Final polish (colors, micro-interactions) is done manually or via targeted AI prompts.

## 🎨 Design

The UI is implemented based on the designs hosted on Stitch:
**[View Designs on Stitch](https://stitch.withgoogle.com/projects/9171164127382182728)**

## ⚠️ Known Limitations

- **Android Home Screen Widget**: This feature is currently incomplete/missing due to time constraints in the initial development phase.

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.
