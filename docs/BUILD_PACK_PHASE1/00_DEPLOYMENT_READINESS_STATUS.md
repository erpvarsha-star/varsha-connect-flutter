# Varsha Connect - Deployment Readiness Status

## Status

Phase 1 build pack is ready and Firebase Firestore is deployed.

The project is ready to hand to a Flutter/Firebase developer or AI builder without reopening the architecture.

## Completed

- Frozen architecture documented
- Firebase Firestore schema created
- Firebase security rules starter created
- Firestore indexes starter created
- Firebase config starter created
- Cloud Functions starter created
- Google Sheets reporting workbook defined
- Role-based screen blueprint created
- Developer build prompt created
- Deployment checklist created
- Seed mapping created from existing project files
- Current GitHub repo cloned from `https://github.com/yashmunot-sudo/varsha-connect`
- Lovable/GitHub gap audit created
- Lovable project inspected directly: `2e0ee012-d1c3-457b-9e20-afa967c67e43`
- Confirmed plant GPS: `19.8383935925407, 75.23638998304483`
- Confirmed geofence radius: `200m`
- `lovable_final_clean (2).txt` read completely and mapped into `10_Lovable_Final_Clean_32_Section_Reference.md`
- Downloads April source files compared against sorted project copies.
- Downloads `SessionLog_Playbook.html` identified as different and relevant to Firebase/Firestore planning.
- Priority 1 forms extracted and converted to app form templates
- Firebase project selected: `yoyo-491123`
- Android Firebase app created: `1:21534636847:android:2b0f9363cabf714f9fffda`
- Android package: `com.varshaforgings.varshaconnect`
- Firestore API enabled
- Default Firestore database created
- Firestore rules deployed
- Firestore indexes deployed

## Ready Files

- `README.md`
- `01_Firebase_Firestore_Blueprint.md`
- `02_Google_Sheets_Reporting_Blueprint.md`
- `03_App_Screen_Blueprint.md`
- `04_Developer_Build_Prompt.md`
- `05_Deployment_Checklist.md`
- `06_Seed_Data_Mapping.md`
- `07_Lovable_GitHub_Gap_Audit.md`
- `firebase.json`
- `firestore.rules`
- `firestore.indexes.json`
- `functions/package.json`
- `functions/index.js`
- `seed_templates/plant_config.json`
- `seed_templates/shifts.json`
- `seed_templates/form_templates_priority1.json`

## Verified

- Cloud Functions JavaScript syntax check passed with Node.
- Required build pack files exist in `BUILD_PACK_PHASE1`.
- Firebase deploy completed for Firestore.
- Flutter source starter created at `varsha_connect_flutter`.
- Firebase Android config downloaded as `google-services.json`.
- App logo copied to `varsha_connect_flutter/assets/images/varsha_logo.png`.
- Seed converter generated 109 users, 31 departments, 18 KRAs, 29 KPIs, 6 shifts, 1 plant config, and 6 Priority 1 forms.

## Environment Blockers

These are not architecture blockers. They are machine/setup blockers.

- Flutter SDK was downloaded to `D:\tools\flutter`, but Flutter startup is hanging during first cache setup on this machine.
- Firebase CLI is installed and logged in as `yash.munot@gmail.com`.
- New Firebase project creation was blocked by Google project quota, so existing project `yoyo-491123` is being used with approval.

## Business Values Still Needed Before Pilot

These are the only real inputs still needed from Yash/Varsha before plant pilot:

- Pilot staff phone numbers
- Final pilot role mapping
- Reporting manager mapping gaps
- Shift assignment for pilot staff
- Whether QR attendance is Phase 1 or Phase 2

## Important Build Guardrails

- Do not build a web/PWA version first.
- Do not use Supabase as the Phase 1 backend.
- Do not make Google Sheets the operational database.
- Do not add WhatsApp reminders.
- Do not add email reminders.
- Do not add leave/payroll into Phase 1.
- Do not allow staff/shift-incharge users to save performance scores.

## Next Physical Step

Repair or reinstall Flutter SDK, then run the prepared Flutter app at `varsha_connect_flutter` using Firebase project `yoyo-491123` and Android package `com.varshaforgings.varshaconnect`.
