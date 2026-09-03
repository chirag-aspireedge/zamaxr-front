## 1. Overview

This is a Flutter mobile app called **Zama-XR**, using **Role-Based Modular GetX Architecture (MVVM) with Repository Pattern**. No web views or web files are needed for this project (mobile app only).

Data flow (must always be followed):

```
View → Controller (ViewModel) → Repository → Service (API / WebSocket) or Local DB
```

## 2. Folder Structure (authoritative — match exactly)

```
lib/
├── main.dart                       # App initialization (Session, theme, clamp text scale)
├── firebase_options*.dart          # Firebase configuration (prod, staging)
└── app/
    ├── binding/
    │   └── all_controller_bindings.dart   # Central DI file — binds/lazily initializes all controllers
    │
    ├── core/
    │   ├── local_db/                      # SQLite helpers + offline data models
    │   ├── localizations/                 # translations.json + translation_service.dart
    │   ├── middleware/                    # Route guards, e.g. auth_guard.dart, role_guard.dart
    │   ├── themes/                        # app_color.dart, app_textstyle.dart
    │   ├── utils/                         # session_manager.dart, validators, helpers, app_assets.dart
    │   └── widgets/                       # Reusable UI components (buttons, textfields, loaders)
    │
    ├── modules/
    │   ├── auth/                          # Shared Auth Flow (Universal across all 5 roles)
    │   │   ├── select_role/               # "Choose Your Role" screen (Student, Teacher, etc.)
    │   │   ├── login/                     # Universal login screen (parameterized by role)
    │   │   ├── login_signup/              # Role landing / choice screen
    │   │   ├── registration/              # Role registration screen
    │   │   ├── forgot_password/           # Password recovery
    │   │   ├── onboarding/                # Onboarding carousel
    │   │   └── splash/                    # App boot & session check
    │   │
    │   ├── common/                        # Cross-Role Screens (Shared post-auth)
    │   │   ├── profile/                   # User profile view & controller
    │   │   └── notifications/             # Notification feed
    │   │
    │   ├── institution/                   # Flow 1: Institution Management (Completed)
    │   │   ├── dashboard/                 # Institution bottom navigation & shell
    │   │   ├── home/                      # Institution home overview
    │   │   ├── classes/                   # Class management
    │   │   ├── class_detail/
    │   │   ├── create_class/
    │   │   ├── teachers/                  # Teacher roster & management
    │   │   ├── teacher_detail/
    │   │   ├── edit_teacher/
    │   │   ├── create_teacher/
    │   │   ├── subjects/                  # Subject management
    │   │   ├── lessons/                   # Lesson management
    │   │   ├── lesson_detail/
    │   │   ├── quiz/                      # Quizzes & evaluation
    │   │   └── subscription/              # Institution licensing
    │   │
    │   ├── teacher/                       # Flow 2: Teacher Portal (Next)
    │   │   # - teacher_dashboard/
    │   │   # - my_classes/
    │   │   # - lesson_studio/
    │   │   # - grading/
    │   │
    │   ├── student/                       # Flow 3: Student Portal
    │   │   # - student_dashboard/
    │   │   # - enrolled_courses/
    │   │   # - xr_viewer/
    │   │   # - quiz_practice/
    │   │
    │   ├── parent/                        # Flow 4: Parent Portal
    │   │   # - parent_dashboard/
    │   │   # - child_progress/
    │   │   # - school_connect/
    │   │
    │   └── individual/                    # Flow 5: Individual Self-Learner Portal
    │       # - individual_dashboard/
    │       # - explore_catalog/
    │       # - personal_subscription/
    │
    ├── repositories/
    │   ├── auth_repo.dart
    │   ├── institution_repo.dart
    │   ├── teacher_repo.dart
    │   ├── student_repo.dart
    │   ├── parent_repo.dart
    │   └── individual_repo.dart
    │
    ├── routes/
    │   └── app_pages.dart                 # Central GetPage registry, route names, transitions
    │
    └── services/
        ├── api_service.dart               # HTTP client, headers, base URLs
        ├── api_constant.dart              # Endpoints
        ├── app_session_websocket_manager.dart
        └── iap_service.dart               # In-App Purchases / subscriptions
```

## 3. Naming Conventions

- Follow the exact casing already used in the project.
- Controllers end in `_controller.dart`, repos end in `_repo.dart`, services end in `_service.dart`.
- Views: `[module]_view.dart` for mobile UI. Do NOT create web view files.

## 4. Layer Rules

- **View**: UI only (mobile `GetView`). No direct API/DB calls. Reads state via `Obx`/`GetX` from the Controller.
- **Controller**: Extends `GetxController`. Holds reactive state (`.obs`). Calls Repository methods only — never calls `ApiService`, WebSocket manager, or local DB directly.
- **Repository**: The only layer allowed to call Services (`api_service.dart`, websocket manager) or Local DB. Handles payload serialization/parsing and returns structured data/errors to the Controller.
- **Service**: Pure network/websocket/IAP/integration logic. No business logic, no app state.
- **Binding**: Uses the single `all_controller_bindings.dart` file for dependency injection, as in the current project. Do not split into per-module binding files unless explicitly instructed later.

## 5. Models

- Module-specific models live inside `modules/[role]/[module]/models/` or directly inside the module if single file.
- If a model needs to be shared across multiple modules, flag it before creating a new shared location — don't duplicate silently.

## 6. Mobile Platform Focus

- This project strictly targets mobile platforms (Android & iOS).
- No web view files (`web_*_view.dart`) or web-specific branching should be created.

## 7. Offline & Real-Time

- Offline behavior goes through `core/local_db/`, coordinated by the relevant Repository — not called directly from Controllers.
- Real-time updates go through `app_session_websocket_manager.dart`, consumed by the relevant Repository, not directly by Controllers.

## 8. Multi-Role Architecture (5 Personas)

- The app supports 5 distinct personas:
  1. **Institution**: Organization management, teachers, classes, billing.
  2. **Teacher**: Teaching workflow, grading, class rosters, XR lessons.
  3. **Student**: Course exploration, 3D/XR lessons, quizzes, progress.
  4. **Parent**: Child progress monitoring, reports, teacher communication.
  5. **Individual**: Self-paced learning, public course catalog, subscriptions.
- **Role Isolation**: Keep all role-specific logic and UI inside its respective directory (`modules/[role]/`). Do NOT branch heavily inside shared controllers.
- **Shared Auth**: Auth screens (`select_role`, `login`, `registration`) adapt only minor labels/payloads depending on the selected role, then navigate to that role's primary dashboard.

## 9. Rules for Antigravity going forward

- Before writing any code, re-read this file.
- Match existing naming/casing exactly as documented above — do not "clean up" or rename existing files/folders on your own.
- Never skip the Repository layer.
- Never call `ApiService`, local DB, or WebSocket manager directly from a Controller or View.
- Do NOT generate web files or web views.
- If a request doesn't fit an existing layer/module, ask before inventing a new pattern, then update this `ARCHITECTURE.md` accordingly.

## 10. Mobile Optical Typography Guidelines (Strict Standard for All Screens)

All future screens MUST adhere to this mobile optical font hierarchy:
- **Font Family**: Always use `Google Sans Flex` via `AppTextStyle.fontFamily`.
- **Top Headings / Main Titles**: `26px - 28px` (`FontWeight.w600`/`w500`) for Auth headings, `20px - 21px` for Profile/Dashboard main titles.
- **Screen App Bar Titles / Section Headers**: `15px - 17px` (`FontWeight.w600`).
- **Primary Card Titles / List Item Names**: `15px` (`FontWeight.w500` / `w600`).
- **Secondary Text / Subtitles**: `12px - 13px` (`FontWeight.w400`).
- **Micro Badges / Chips / Counters**: `11px - 12px` (`FontWeight.w400` / `w500`).
- **Pill / Action Buttons**: `16px - 18px` (`FontWeight.w500` / `w600`).
- **Text Scaling**: Clamped in `main.dart` with `MediaQuery.textScaler.clamp(minScaleFactor: 0.9, maxScaleFactor: 1.05)`.

