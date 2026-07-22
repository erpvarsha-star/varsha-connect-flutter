# Attached Lovable Request Triage

Source:

- `C:\Users\admin\.codex\attachments\d7815e3c-4f6f-4f39-b96d-c15ba0c95c6b\pasted-text.txt`

## Decision

This attached request is for the old Lovable/Supabase PWA. It should be used as reference only.

Do not execute the instruction literally because it says:

- use Supabase migrations
- deploy after each task
- edit existing Lovable role screens
- add leave/payroll/PF/ESIC/HR modules

That conflicts with the frozen direction:

- Flutter mobile app
- Firebase/Firestore
- Firebase push notifications
- Google Sheets reporting mirror
- Phase 1 focused on performance and accountability

## Phase 1 Carry Forward

These items support the current Phase 1 accountability app and should be adapted into Flutter/Firebase.

### Task 1 - Casual Worker Count - Supervisor

Carry forward, but adapt:

- Build as an in-app Firebase form.
- Role: Supervisor.
- Inputs: Unskilled, Skilled, Operator.
- Department and shift auto-filled.
- Save to Firestore collection `casual_worker_counts`.
- Mirror to Google Sheets.

Firebase collection:

- casual_worker_counts

Fields:

- id
- supervisor_emp_code
- department
- shift_date
- shift_type
- unskilled_count
- skilled_count
- operator_count
- created_at
- updated_at

Unique app rule:

- one record per supervisor + shift_date + shift_type

### Task 2 - Casual Worker Count - Security Guard

Partially carry forward.

Decision:

- Security Guard is not in the current four locked roles.
- If gate/security is needed in pilot, map this to `shift_incharge` with department `GATE`, or add Security Guard as a later role.

Status:

- Phase 1 optional.

### Task 3 - Contract Labour Summary - HR Admin

Do not build HR Admin module in Phase 1.

Carry forward only as Google Sheets/reporting view:

- Department
- Shift date
- Unskilled
- Skilled
- Operator
- Total
- Submitted by
- Time

### Task 5 - Fraud Detection On Supervisor Floor Confirmation

Carry forward conceptually.

Adapt to Firebase later:

- Detect suspicious bulk confirmations.
- Save to `fraud_flags`.
- Notify Plant Head.

Status:

- Phase 1.5 / accountability hardening.

## Deferred To Phase 2 Or Later

These should not be built now.

### Task 4 - Three-Way Match Screen

Deferred.

Reason:

- Procurement/GRN/payment release belongs to procurement/finance system, not Phase 1 staff accountability.

### Task 6 - Probation Tracking

Deferred.

Reason:

- HR lifecycle module, not current Phase 1.

### Task 7 - Holiday Master

Deferred, except attendance can later read a holiday list.

Reason:

- Useful for attendance/payroll, but not required for first accountability pilot.

### Task 8 - Comp-Off Management

Deferred.

Reason:

- Leave/comp-off is outside current Phase 1.

### Task 9 - Leave Encashment

Deferred.

Reason:

- Payroll/leave encashment is outside current Phase 1.

### Task 10 - Attendance Regularisation

Deferred.

Reason:

- Useful later, but Phase 1 should first stabilize geofence attendance and manager accountability.

### Task 11 - Minimum Wages Compliance Check

Deferred.

Reason:

- HR/payroll compliance module, not Phase 1.

### Task 12 - PF Challan Report

Deferred.

Reason:

- Payroll statutory reporting, not Phase 1.

### Task 13 - ESIC Challan Report

Deferred.

Reason:

- Payroll statutory reporting, not Phase 1.

## New Firebase Backlog Collections

Add later when corresponding features are approved:

- casual_worker_counts
- fraud_flags
- public_holidays
- attendance_regularisation
- comp_off_balance
- payroll_components
- compliance_checks

## Immediate Build Pack Update Needed

Add `casual_worker_counts` to Firebase blueprint as a Phase 1 optional collection because it directly supports daily supervisor accountability.

Do not add leave/payroll/compliance collections to Phase 1 deploy rules yet.
