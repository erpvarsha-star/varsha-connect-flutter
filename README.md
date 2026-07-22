# Varsha Connect

Flutter mobile app for Varsha Forgings factory performance and accountability.

## Current Architecture

- App: Flutter
- Backend: Firebase project `yoyo-491123`
- Database: Firestore
- Notifications: Firebase Cloud Messaging
- Reporting mirror: Google Sheets
- Android package: `com.varshaforgings.varshaconnect`

Lovable/Supabase files are reference only.

## What Is In This Repo

- `lib/` - Flutter source
- `assets/images/varsha_logo.png` - app logo
- `pubspec.yaml` - Flutter dependencies
- `google-services.json` - Firebase Android config
- `docs/BUILD_PACK_PHASE1/` - complete build pack, schemas, rules, seed files, audits

## First Cloud Build Steps

Run these in a cloud IDE with Flutter installed:

```bash
flutter create --platforms=android --org com.varshaforgings .
mkdir -p android/app
cp google-services.json android/app/google-services.json
flutter pub get
flutter build apk --debug
```

If Gradle asks for Firebase plugin setup, add Google services plugin to Android Gradle files using the standard Firebase Flutter setup.

## Firebase Already Done

- Firebase CLI installed on local machine
- Logged in as `yash.munot@gmail.com`
- Android app created
- Firestore database created
- Firestore rules deployed
- Firestore indexes deployed

## Seed Data

Seed output is in:

`docs/BUILD_PACK_PHASE1/seed_output`

Dry run confirmed:

- 109 users
- 31 departments
- 18 KRAs
- 29 KPIs
- 6 shifts
- 1 plant config
- 6 Priority 1 forms

Do not import all staff data until pilot list/timing is approved.

## Build Guardrails

- Do not switch to Supabase.
- Do not restart as Lovable/PWA.
- Keep mobile-first Android UX.
- Keep Hindi/English equal size when both shown.
- Keep branding clean/light with orange `#E87722`.
- Phase 1 focus: attendance, forms, tasks, performance/accountability, notifications.
