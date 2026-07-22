# Varsha Connect Flutter App

This is the Phase 1 Flutter source starter for Varsha Connect.

Firebase project:

- Project ID: `yoyo-491123`
- Android app id: `1:21534636847:android:2b0f9363cabf714f9fffda`
- Android package: `com.varshaforgings.varshaconnect`

## Current Machine Note

Firebase CLI is installed and Firestore is deployed.

Flutter was downloaded to `D:\tools\flutter`, but Flutter startup is hanging on this machine during first SDK cache setup. The app source is prepared here so it can be built once Flutter is repaired/reinstalled.

## Build Commands

After Flutter is available:

```powershell
cd "D:\YJM_PROJECTS_SORTED\02_Varsha_Connect_Staff_App_PENDING_DEPLOY\varsha_connect_flutter"
flutter pub get
flutter build apk --debug
```

Release:

```powershell
flutter build apk --release
flutter build appbundle --release
```

## Phase 1 Modules

- Login
- Home dashboard
- Attendance
- Daily forms
- Tasks
- Performance
- Notifications
