# Developer Build Prompt - Varsha Connect Phase 1

## Role

You are building Varsha Connect, a mobile-first factory accountability app for Varsha Forgings.

Build exactly Phase 1. Do not expand into leave, payroll, web portal, WhatsApp, email reminders, or old PWA behavior unless explicitly requested.

## Fixed Decisions

- App name: Varsha Connect
- Platform: Flutter mobile app
- Backend: Firebase
- Database: Firestore
- Push notifications: Firebase Cloud Messaging with sound
- Reporting/export: Google Sheets mirror
- Source of truth: Firestore
- No web-first/PWA build
- No Supabase dependency
- No WhatsApp reminders
- No email reminders

## Phase 1 Business Goal

Build performance and accountability for factory staff.

The first users are the people who must file daily operational forms, mark attendance, complete tasks, and be measured through KPI/KRA.

## Roles

Build these roles:

- Plant Head
- Manager
- Supervisor
- Shift Incharge

Role scope:

- Plant Head: all plant visibility and overrides.
- Manager: department visibility, task assignment, score entry.
- Supervisor: team visibility, task assignment, form follow-up.
- Shift Incharge: own attendance, due forms, own tasks, own performance view.

## Required Modules

### 1. Login

Build:

- Phone/PIN login screen
- Load user profile from Firestore
- Save FCM token
- Block inactive users

### 2. Home Dashboard

Build:

- Role-specific dashboard
- Attendance card
- Due forms card
- Pending tasks card
- Performance score card
- Notifications card
- Department/team exception list for supervisors/managers/plant head

Dashboard must refresh after any attendance, form, task, or score save.

### 3. Attendance

Build:

- Runtime location permission
- Geofence validation
- Check-in/check-out
- Late detection
- Shift mapping
- EOD confirmation flag

If permission is denied, show explanation and return to dashboard.

If outside geofence, reject attendance and return to dashboard.

### 4. Daily Forms

Build in-app forms, not Google Forms.

Priority 1 forms:

- N1 Forge Shop hourly production log
- N2 Press Shop hourly production log
- N3 Heat Treatment batch log
- N4 Maintenance daily PM checklist - Mechanical
- N5 Electricity daily consumption log - Electrical
- N6 Shift report for all production departments

Forms must:

- Load by role and department
- Validate required fields
- Save to Firestore
- Mirror to Google Sheets
- Mark overdue if not submitted by due time

### 5. Tasks

Build:

- My tasks
- Assigned by me
- Task detail
- Status updates
- Completion note
- One-time tasks
- Recurring daily/weekly/monthly tasks
- App push reminder when due

Task notification tap must open the task.

Dismiss must leave user on current screen.

### 6. Performance

Build:

- Role KRA/KPI display
- Score history
- Staff/Shift Incharge read-only score view
- Manager/Plant Head score entry
- Composite score calculation

Formula:

- Attendance score: 40%
- Task/Form performance score: 40%
- Manager observation/accountability score: 20%

Critical rule:

Non-manager users must never calculate or save performance scores. They only view.

### 7. Notifications

Build:

- FCM push notification
- Sound-enabled alerts
- Notification inbox
- Read/unread state
- Tap routing to task/form/performance
- Dismiss without navigation

No email reminders.

No WhatsApp reminders.

### 8. Reporting Sync

Build Firestore-to-Google-Sheets sync.

Sheets:

- Users_Master
- Attendance_Log
- Form_Templates
- Form_Submissions
- Task_Status
- Performance_Log
- Dashboard_Summary
- Notification_Log
- Exceptions_Review
- Config

Sheets are for visibility/reporting only.

## Required Firebase Collections

Implement:

- users
- departments
- shifts
- plant_config
- attendance_logs
- form_templates
- form_responses
- tasks
- role_kras
- role_kpis
- performance_scores
- notifications
- audit_logs

Use the included `01_Firebase_Firestore_Blueprint.md`, `firestore.rules`, and `firestore.indexes.json`.

## Required Flutter Packages

Recommended packages:

- firebase_core
- firebase_auth
- cloud_firestore
- firebase_messaging
- firebase_crashlytics
- firebase_analytics
- geolocator
- permission_handler
- flutter_local_notifications
- provider or riverpod
- intl
- go_router

## Build Order

1. Create Flutter project
2. Connect Firebase Android app
3. Configure Firestore/Auth/FCM
4. Add app theme and navigation shell
5. Build login
6. Build dashboard
7. Build attendance
8. Build daily forms
9. Build tasks
10. Build notifications
11. Build performance
12. Build Sheets sync
13. Test pilot role data
14. Build signed Android APK/AAB

## Acceptance Criteria

The app is ready for pilot when:

- Plant Head can log in and see plant dashboard.
- Manager can see department dashboard and enter scores.
- Supervisor can see team forms/tasks.
- Shift Incharge can mark attendance, submit due forms, complete tasks, and view score.
- Attendance rejects outside geofence.
- Due task/form notification arrives with sound.
- Tapping notification opens correct screen.
- Dashboard refreshes after saves.
- Google Sheets mirror receives data.
- Non-manager cannot edit/save performance score.
- Save buttons cannot be spammed into duplicate writes.

## Do Not Build

- Leave
- Payroll
- Salary screens
- Web/PWA
- WhatsApp reminders
- Email reminders
- Supabase backend
- Zoho integration

## Source Files To Use As Reference

Use these files as business reference only:

- `VFL_Forms_Required_Per_Department (2).txt`
- `homework_and_hcm_gaps (2).txt`
- `varsha_kra_operations (2).sql`
- `varsha_complete_seed_v2 (2).sql`
- `employees_active_109_seed.sql`
- `lovable_complete_prompt (2).txt`
- `cowork_complete_scripts (2).txt`

Older Lovable/Supabase/PWA details should not override the frozen Flutter/Firebase direction.
