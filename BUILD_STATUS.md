# Varsha Connect Build Status

Last updated: 2026-07-22

## Current Build Branch

- GitHub repo: `erpvarsha-star/varsha-connect-flutter`
- Active branch: `varsha-connect-flutter-build`
- Latest pushed commit: `230399d`

## Completed

- Firebase project selected: `yoyo-491123`
- Android package selected: `com.varshaforgings.varshaconnect`
- Firestore rules and indexes deployed earlier from build pack
- Varsha logo added to Flutter assets
- Flutter app shell created
- Role-aware homes added for Worker, Supervisor, Manager, HR Admin, and Owner
- Worker attendance screen includes arrival, checkout, geofence messaging, QR checkpoint placeholder, and maintenance observation prompt
- In-app leave and salary advance forms added
- Manager approvals UI added
- HR shift planner UI added
- Supervisor individual attendance confirmation UI added
- Owner attention dashboard UI added
- Score screen shows attendance/performance/observation weighting
- Notification screen lists frozen push reminder events
- Firestore service methods added for attendance checkpoints, leave requests, advance requests, manager review, MRM review, and scoring helpers

## Current Blocker

GitHub Actions reaches `Build debug APK`, then fails. Public API does not expose the build log, and artifact download returns `401` without logged-in GitHub access.

Needed from signed-in GitHub browser:

- Open the latest failed run.
- Expand `Build debug APK`.
- Paste the failing lines here.

Analyzer is no longer blocking the latest runs; it passes before APK packaging.

## Continue Next

After the APK packaging error is visible:

1. Fix the concrete Android/Gradle/Firebase build error.
2. Re-run GitHub Actions until APK artifact uploads.
3. Wire live UI submit buttons to `FirestoreService`.
4. Add phone OTP authentication screen behavior.
5. Add Firebase Messaging token registration.
6. Add release signing path for installable APK/AAB.
