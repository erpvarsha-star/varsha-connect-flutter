# Lovable Final Clean - 32 Section Reference

Source read completely:

- `D:\YJM_PROJECTS_SORTED\02_Varsha_Connect_Staff_App_PENDING_DEPLOY\lovable_final_clean (2).txt`
- 609 lines

## Important Context

This file is the complete old Lovable/Supabase PWA instruction set.

It is reference only for the current Varsha Connect build.

Current locked build remains:

- Flutter mobile app
- Firebase/Firestore
- Firebase Cloud Messaging
- Google Sheets reporting mirror
- Lovable/Supabase/PWA used only for old logic and reference

## What The 32 Sections Contain

### Section 1 - Database

Old instruction:

- run `varsha_complete_seed_v2.sql`
- run `varsha_kra_operations.sql`
- expect 313 employees

Current use:

- Use SQL files as seed/reference.
- Convert useful schema into Firestore collections.
- Do not run Supabase SQL for final mobile app.

### Section 2 - Authentication

Old instruction:

- Supabase phone OTP
- route by employee role
- Hindi default for workers

Current use:

- Firebase Auth/custom claims or phone/PIN mapping.
- Preserve role routing and language behavior.

### Section 3 - 6 Role Screens

Old roles:

- Worker
- Supervisor
- Manager
- HR Admin
- Owner
- Plant Head

Current use:

- Current Phase 1 roles remain Plant Head, Manager, Supervisor, Shift Incharge.
- Worker maps to Shift Incharge/staff app user.
- Owner/HR Admin concepts are backlog unless explicitly approved.

### Section 4 - Scoring System

Carry forward:

- monthly score
- attendance/performance/observation weighting
- observation cap
- supervisor/manager rollups

Current scoring:

- Attendance 40%
- Tasks/forms/performance 40%
- Observation/accountability 20%

### Section 5 - Leave Approval Chain

Backlog unless approved.

Useful reference:

- reporting manager approval
- manager leave to Plant Head
- escalation after 48 hours
- coverage warning

### Section 6 - Attendance Warnings

Backlog / Phase 1.5.

Useful reference:

- 4th late creates warning
- 5th late final warning
- employee acknowledgment

### Section 7 - Payslip

Deferred.

Reason:

- payroll is outside current first accountability app.

### Section 8 - Profile Screen

Carry forward.

Current app should include:

- name
- emp_code
- designation
- department
- current shift
- language toggle
- logout

### Section 9 - Notifications

Carry forward.

Current Firebase mapping:

- notifications collection
- FCM push with sound
- inbox/read state
- bell icon later

### Section 10 - Leaderboard

Carry forward as performance/accountability module.

Phase 1:

- staff own score
- manager department/team view
- Plant Head all departments

### Section 11 - Task Delegation

Carry forward.

Current Firebase mapping:

- tasks collection
- assigned/acknowledged/in-progress/done
- due reminders
- escalation later

### Section 12 - Employee Records

Deferred.

Use only minimal staff profile in Phase 1.

### Section 13 - Missing Data Handling

Deferred.

Useful future HR feature.

### Section 14 - Google Sheets Output

Carry forward, but as Firebase-to-Sheets mirror.

Current build pack already defines Sheets reporting structure.

### Section 15 - PWA Install

Not current target.

Current target:

- Flutter Android app.

### Section 16 - Design Tokens

Carry forward.

Already applied:

- Orange `#E87722`
- light background
- white cards
- no dark background
- logo on login/top bar

Still to preserve:

- Hindi/English equal size, equal weight, equal color.

### Section 17 - Complete Table Reference

Use as schema reference only.

Current mapping is Firestore collections.

### Section 18 - 3 Checkpoint Attendance

Important future/hardening reference.

Core ideas:

- QR + GPS together
- security confirmation
- supervisor floor confirmation
- no bulk confirm
- 3 second tap gap
- fraud flags

Current recommendation:

- Phase 1 can start GPS geofence.
- QR/security checkpoint can be Phase 1.5 if factory wants stricter attendance immediately.

### Section 19 - CNC/VMC Production Incentive

Deferred.

Important future module for Machine Shop/VMC Shop.

### Section 20 - Leave Coverage Warning

Deferred with leave module.

### Section 21 - Advance Safety Check

Deferred with advance module.

### Section 22 - Security Guard Role

Deferred unless gate workflow is approved.

### Section 23 - Missing Data Modal

Deferred.

### Section 24 - Part Master Data Entry

Deferred with production incentive.

### Section 25 - Enriched KPIs From VFL Documents

Carry forward as KPI seed reference.

Use for:

- Forge Shop supervisor KPIs
- Production manager KPIs
- Maintenance KPIs
- Purchase KPIs
- Quality KPIs
- Sales/Marketing KPIs
- HR Admin KPIs

### Section 26 - 12 Critical Fixes

Carry forward selectively.

Current relevance:

- plant head routing
- equal Hindi/English labels
- frontend and backend role checks
- QR + GPS if 3-checkpoint attendance approved
- mock location checks
- no bulk supervisor confirm
- observation points only after acknowledgement
- override audit logs

### Section 27 - Gmail Email Task Tab

Deferred.

Reference only for future email accountability module.

### Section 28 - Vehicle Log Tab

Deferred.

Reference only for security/gate module.

### Section 29 - GRN And Three-Way Match

Deferred.

Reference only for procurement/accounts workflow.

### Section 30 - Settings Screen

Partial future admin module.

Carry forward later:

- plant config
- geofence radius
- shift timings
- integration URLs
- departments

### Section 31 - Purchase Requisition Tab

Deferred.

Reference:

- iframe URL: `https://erpvarsha-star.github.io/vfpl-procurement/vfpl_procurement_final.html`

### Section 32 - MRM Monthly Review Tab

Deferred.

Useful future management module.

## Current Build Pack Impacts

Already applied or created:

- Firebase backend deployed
- Flutter source starter created
- logo copied
- brand colors applied
- geofence GPS confirmed
- role/KRA/KPI seed conversion
- casual worker count added as optional Phase 1
- Lovable/GitHub gap audit created
- attached Lovable prompt triage created

Need future build decisions:

- Add leave/advance in Phase 1 or keep deferred?
- Add QR/security 3-checkpoint attendance in Phase 1 or Phase 1.5?
- Add HR Admin/Owner roles now or keep current four-role structure?

## Guardrail

Do not use this file to switch architecture back to Supabase/PWA.

Use it as a feature dictionary and business logic reference for the Flutter/Firebase app.
