# Varsha Connect Phase 1 Build Pack

This folder contains the deploy/build handoff for Varsha Connect Phase 1.

## Files

- `01_Firebase_Firestore_Blueprint.md` - Firestore collections, access, and Cloud Functions
- `02_Google_Sheets_Reporting_Blueprint.md` - reporting workbook tabs and columns
- `03_App_Screen_Blueprint.md` - mobile app screens and behavior
- `04_Developer_Build_Prompt.md` - direct build prompt for developer/AI builder
- `05_Deployment_Checklist.md` - deployment and pilot checklist
- `06_Seed_Data_Mapping.md` - how old seed files map into Phase 1
- `07_Lovable_GitHub_Gap_Audit.md` - what was carried forward from the old Lovable/GitHub app
- `08_Attached_Lovable_Request_Triage.md` - triage of the attached old Lovable/Supabase task list
- `09_Branding_And_Leave_Advance_Reference.md` - brand colors/logo rules and leave/advance reference mapping
- `10_Lovable_Final_Clean_32_Section_Reference.md` - complete 32-section old Lovable prompt mapped to current build
- `11_Downloads_April_File_Comparison.md` - comparison of Downloads April source files vs sorted project copies
- `firestore.rules` - Firebase security rules starter
- `firestore.indexes.json` - Firestore indexes starter
- `firebase.json` - Firebase deployment config starter
- `functions/` - Cloud Functions skeleton
- `seed_templates/` - starter seed JSON files

## Current Readiness

Ready:

- Architecture
- Database blueprint
- Security rules starter
- Index starter
- Cloud Functions skeleton
- Sheets reporting structure
- Screen blueprint
- Build prompt
- Deployment checklist
- Lovable/GitHub gap audit
- Seed conversion output

Blocked only by environment/setup:

- Flutter SDK is not installed on this machine.
- Firebase CLI is not installed on this machine.
- Firebase project has not been created/connected yet.
- Exact plant GPS latitude/longitude is not confirmed in the inspected files.

## Frozen Direction

Build one Flutter mobile app with Firebase/Firestore. Do not restart as PWA, Supabase, Lovable, WhatsApp reminders, or email reminders.
