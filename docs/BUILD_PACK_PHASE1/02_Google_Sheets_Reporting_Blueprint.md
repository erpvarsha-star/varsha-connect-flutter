# Varsha Connect - Google Sheets Reporting Blueprint

## Purpose

Google Sheets is the reporting/export layer for Varsha Connect.

Firestore remains the source of truth. The app should not depend on Sheets for live attendance, tasks, forms, or performance logic.

## Workbook Name

`Varsha_Connect_Phase1_Reporting`

## Sheet Tabs

### 1. Users_Master

Purpose: staff identity and hierarchy reporting.

Columns:

- emp_code
- name
- phone
- role
- legacy_role
- department
- designation
- shift_id
- reporting_manager_emp_code
- active
- last_login_at

### 2. Attendance_Log

Purpose: daily attendance audit.

Columns:

- date
- emp_code
- name
- role
- department
- shift_id
- check_in_time
- check_out_time
- geofence_status
- attendance_status
- late_minutes
- overtime_minutes
- eod_confirmed
- source_record_id
- synced_at

### 3. Form_Templates

Purpose: list of all active app forms.

Columns:

- form_code
- title
- department
- frequency
- due_time
- role_scope
- priority
- active

### 4. Form_Submissions

Purpose: daily/weekly/monthly form filing status.

Columns:

- response_date
- form_code
- form_title
- emp_code
- name
- role
- department
- shift_id
- status
- submitted_at
- reviewed_by
- reviewed_at
- response_json
- source_record_id
- synced_at

### 5. Task_Status

Purpose: task accountability tracker.

Columns:

- task_id
- title
- task_type
- assigned_to
- assigned_to_name
- assigned_by
- assigned_by_name
- department
- priority
- status
- due_date
- due_time
- completed_at
- overdue
- completion_note
- source_record_id
- synced_at

### 6. Performance_Log

Purpose: KPI/KRA score history.

Columns:

- period_type
- period_start
- period_end
- emp_code
- name
- role
- department
- attendance_score
- task_score
- form_score
- manager_observation_score
- composite_score
- entered_by
- approved_by
- status
- source_record_id
- synced_at

### 7. Dashboard_Summary

Purpose: management dashboard data.

Columns:

- date
- department
- total_staff
- present
- absent
- late
- attendance_percent
- forms_due
- forms_submitted
- forms_missed
- form_completion_percent
- tasks_due
- tasks_completed
- tasks_overdue
- task_completion_percent
- average_composite_score
- synced_at

### 8. Notification_Log

Purpose: notification trace.

Columns:

- notification_id
- created_at
- recipient_emp_code
- recipient_name
- type
- title
- related_module
- related_id
- pushed
- sound
- read
- read_at

### 9. Exceptions_Review

Purpose: items that need human follow-up.

Columns:

- date
- module
- emp_code
- name
- department
- issue_type
- issue_detail
- owner_emp_code
- owner_name
- status
- resolved_at
- notes

### 10. Config

Purpose: visible config review.

Columns:

- config_key
- config_value
- source
- last_updated_at
- notes

## Priority 1 Form Templates

These should be created first in the app and mirrored to Sheets.

### N1 - Forge Shop Hourly Production Log

Department: Forge Shop

Frequency: Daily, every shift

Fields:

- date
- shift_id
- heat_no
- part_no
- machine_or_hammer_no
- operator_emp_code
- hour_slot
- parts_made
- target_qty
- rejection_qty
- remarks

### N2 - Press Shop Hourly Production Log

Department: Press Shop

Frequency: Daily, every shift

Fields:

- date
- shift_id
- machine_no
- part_no
- operator_emp_code
- hour_slot
- parts_made
- target_qty
- tonnage_used
- rejection_qty
- remarks

### N3 - Heat Treatment Batch Log

Department: Heat Treatment

Frequency: Daily, every shift

Fields:

- date
- shift_id
- furnace_no
- batch_no
- part_no
- quantity
- cycle_start_time
- cycle_end_time
- set_temperature
- actual_temperature
- result
- operator_emp_code
- remarks

### N4 - Maintenance Daily PM Checklist - Mechanical

Department: Maintenance

Frequency: Daily

Fields:

- date
- shift_id
- machine_no
- pm_task
- done
- issue_found
- action_taken
- spare_required
- checked_by_emp_code
- remarks

### N5 - Electricity Daily Consumption Log - Electrical

Department: Maintenance / Electrical

Frequency: Daily

Fields:

- date
- shift_id
- meter_or_panel_no
- start_reading
- end_reading
- units_consumed
- department_area
- checked_by_emp_code
- abnormality_found
- remarks

### N6 - Shift Report For Production Departments

Department: Forge Shop, Press Shop, Heat Treatment, Die Shop, Machine Shop, VMC Shop, Cutting Shop

Frequency: Daily, every shift

Fields:

- date
- shift_id
- department
- shift_incharge_emp_code
- production_target
- production_actual
- rejection_qty
- downtime_minutes
- downtime_reason
- safety_observation
- pending_work
- handover_notes
- submitted_by_emp_code

## Sync Rules

- Firestore writes should be synced to Sheets through Cloud Functions or a scheduled backend job.
- Failed syncs should be written to `Exceptions_Review`.
- Sheet rows should include `source_record_id` so records can be traced back to Firestore.
- Sheets should not be manually edited as an operational database.

## Reporting Views To Build Later

- Department daily scorecard
- Plant Head daily accountability view
- Form completion tracker
- Late attendance tracker
- Overdue task tracker
- Monthly KPI/KRA scorecard
