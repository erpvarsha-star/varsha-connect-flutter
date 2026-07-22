# Varsha Connect - Firebase Firestore Blueprint

## Purpose

Firestore is the live operational database for Varsha Connect Phase 1.

Google Sheets is only a reporting/export mirror. Staff actions must not write directly to Sheets.

## Core Collections

### users

One document per staff member.

Document id: `emp_code`

Fields:

- emp_code: string
- name: string
- phone: string
- role: `plant_head | manager | supervisor | shift_incharge`
- legacy_role: string
- department: string
- designation: string
- shift_id: string
- reporting_manager_emp_code: string
- active: boolean
- pin_hash: string
- fcm_tokens: array
- language: `en | hi | mr`
- created_at: timestamp
- updated_at: timestamp

Access:

- User can read own profile.
- Supervisor can read assigned team users.
- Manager can read department users.
- Plant Head can read all users.
- Only admin/service account can create/update users.

### departments

Document id: normalized department name.

Fields:

- department_id: string
- name: string
- active: boolean
- manager_emp_code: string
- plant_head_emp_code: string

### shifts

Document id: shift code.

Initial shift definitions found in source files:

- general: 09:00-18:00
- first: 07:00-15:30
- second: 15:30-00:00
- third: 00:00-07:00
- day: 07:00-19:00
- night: 19:00-07:00

Fields:

- shift_id: string
- name: string
- start_time: string
- end_time: string
- grace_minutes: number
- active: boolean

### plant_config

Document id: `main`

Confirmed Lovable source values:

- geofence_lat: `19.8383935925407`
- geofence_lng: `75.23638998304483`
- geofence_radius_meters: `200`

Fields:

- plant_name: string
- geofence_lat: number
- geofence_lng: number
- geofence_radius_meters: number
- timezone: `Asia/Kolkata`
- attendance_enabled: boolean
- qr_required: boolean
- daily_qr_enabled: boolean
- updated_at: timestamp

### attendance_logs

Document id: `emp_code_yyyy_mm_dd`

Fields:

- attendance_id: string
- emp_code: string
- date: string
- shift_id: string
- check_in_time: timestamp
- check_out_time: timestamp
- check_in_location: geopoint
- check_out_location: geopoint
- geofence_status: `inside | outside | permission_denied | unavailable`
- status: `present | late | absent | overtime | incomplete`
- late_minutes: number
- overtime_minutes: number
- eod_confirmed: boolean
- created_at: timestamp
- updated_at: timestamp

Access:

- User can create own attendance.
- User can read own attendance.
- Supervisor can read team attendance.
- Manager can read department attendance.
- Plant Head can read all attendance.
- No user can edit another user's attendance from app.

### form_templates

Document id: form code, for example `N1`.

Fields:

- form_id: string
- form_code: string
- title: string
- department: string
- role_scope: array
- frequency: `daily | weekly | monthly | one_time`
- due_time: string
- fields: array
- active: boolean
- priority: number

### form_responses

Document id: auto id.

Fields:

- response_id: string
- form_id: string
- form_code: string
- emp_code: string
- department: string
- shift_id: string
- response_date: string
- response_data: map
- status: `submitted | late | reviewed | rejected`
- submitted_at: timestamp
- reviewed_by: string
- reviewed_at: timestamp

Access:

- User can create own response for assigned forms.
- User can read own responses.
- Supervisor can read team responses.
- Manager can read department responses.
- Plant Head can read all responses.

### casual_worker_counts

Phase 1 optional collection for supervisor accountability.

Document id: `supervisor_emp_code_shift_date_shift_type`

Fields:

- id: string
- supervisor_emp_code: string
- department: string
- shift_date: string
- shift_type: string
- unskilled_count: number
- skilled_count: number
- operator_count: number
- created_at: timestamp
- updated_at: timestamp

Access:

- Supervisor can create/update own count for own shift.
- Manager can read department counts.
- Plant Head can read all counts.

Rule:

- One record per supervisor, shift date, and shift type.

### tasks

Document id: auto id.

Fields:

- task_id: string
- title: string
- description: string
- task_type: `one_time | daily | weekly | monthly`
- assigned_to: string
- assigned_by: string
- department: string
- priority: `normal | urgent | critical`
- status: `assigned | acknowledged | in_progress | done | cancelled | overdue`
- due_date: string
- due_time: string
- recurrence_rule: string
- escalation_level: number
- completed_at: timestamp
- completion_note: string
- proof_attachment_url: string
- created_at: timestamp
- updated_at: timestamp

Access:

- Assigned user can read and update status fields.
- Supervisor/Manager/Plant Head can assign tasks within scope.
- Plant Head can read all tasks.

### role_kras

Document id: auto id.

Fields:

- kra_id: string
- role: string
- department: string
- kra_number: number
- title: string
- title_hi: string
- description: string
- weight_pct: number
- active: boolean

### role_kpis

Document id: auto id.

Fields:

- kpi_id: string
- kra_id: string
- role: string
- department: string
- kra_number: number
- title: string
- title_hi: string
- target_value: string
- target_operator: string
- unit: string
- frequency: string
- weight_pct: number
- penalty_pct: number
- auto_calculated: boolean
- active: boolean

### performance_scores

Document id: `emp_code_period`.

Fields:

- score_id: string
- emp_code: string
- period_type: `daily | weekly | monthly`
- period_start: string
- period_end: string
- attendance_score: number
- task_score: number
- form_score: number
- manager_observation_score: number
- composite_score: number
- entered_by: string
- approved_by: string
- status: `draft | submitted | approved | locked`
- created_at: timestamp
- updated_at: timestamp

Rules:

- Staff and Shift Incharge can view own scores only.
- Supervisor can view team scores.
- Manager can enter scores for department staff.
- Plant Head can view all and approve/override.
- Non-manager path must never calculate or save score.

### notifications

Document id: auto id.

Fields:

- notification_id: string
- recipient_emp_code: string
- type: string
- title: string
- body: string
- related_module: `attendance | forms | tasks | performance`
- related_id: string
- read: boolean
- pushed: boolean
- sound: boolean
- created_at: timestamp
- read_at: timestamp

### audit_logs

Document id: auto id.

Fields:

- audit_id: string
- actor_emp_code: string
- action: string
- module: string
- record_id: string
- before: map
- after: map
- created_at: timestamp

## Cloud Functions Needed

### scheduledTaskAndFormNotifications

Runs every 15 minutes.

Responsibilities:

- Find due tasks.
- Find due forms.
- Create notification document.
- Send FCM push with sound.

### syncFirestoreToSheets

Runs on write or scheduled every 5 minutes.

Responsibilities:

- Mirror attendance, forms, tasks, performance, and summaries to Google Sheets.
- Never use Sheets as the source of truth.

### calculateDailyDashboardSummary

Runs after writes or hourly.

Responsibilities:

- Build department summary for dashboard.
- Count present/late/absent.
- Count forms due/submitted/missed.
- Count tasks due/completed/overdue.
- Calculate average scores.

## Security Notes

- Phone numbers and salary data should not be exposed to regular users.
- Phase 1 should avoid salary/payroll screens.
- App must store minimal profile data locally.
- FCM tokens should be writeable only by the logged-in user.
- Manager writes must be audited.
