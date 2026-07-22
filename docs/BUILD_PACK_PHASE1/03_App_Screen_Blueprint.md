# Varsha Connect - Screen By Screen App Blueprint

## Design Direction

The app should feel like a factory operations tool, not a marketing app.

Principles:

- Fast daily use
- Large tap targets
- Clear status colors
- Role-based screens
- No unnecessary text explanations inside the app
- English first, Hindi/Marathi ready later
- Works with weak factory-floor connectivity

Brand:

- App name: Varsha Connect
- Use existing Varsha logo asset where available
- Primary color can use Varsha orange
- Neutral background, high contrast cards, compact dashboard layout

## Screen 1 - Login

Users:

- All roles

Purpose:

- Staff opens app and enters PIN/phone.

Elements:

- Varsha logo
- Phone number input
- PIN input
- Login button
- Error state

Behavior:

- Validate with Firebase Auth/custom token flow.
- Load `users/{emp_code}`.
- If inactive, block login.
- Save FCM token after login.

## Screen 2 - Home Dashboard

Users:

- Plant Head
- Manager
- Supervisor
- Shift Incharge

Purpose:

- One-page daily accountability view.

Common cards:

- Attendance status
- Due forms
- Pending tasks
- Notifications
- Today's score/accountability

Role-specific cards:

- Plant Head: plant summary, departments with exceptions, overdue managers
- Manager: department attendance, form completion, staff score, overdue tasks
- Supervisor: team attendance, shift forms due, open tasks, missed confirmations
- Shift Incharge: own attendance, due shift forms, assigned tasks, own score

Behavior:

- Dashboard reads live data from Firestore.
- Dashboard refreshes after attendance, task, form, or score saves.

## Screen 3 - Attendance

Users:

- All roles

Purpose:

- Mark location-based check-in/check-out.

Elements:

- Current shift
- Current time
- Check-in/check-out button
- Location permission state
- Geofence status
- Late warning if applicable

Behavior:

- Request runtime location permission.
- Capture current location.
- Compare with `plant_config/main`.
- If outside geofence, reject attendance.
- If inside, save attendance record.
- If check-out, mark EOD confirmation if required.

## Screen 4 - Daily Forms

Users:

- Mostly Shift Incharge, Supervisor, Manager

Purpose:

- File required daily operational forms.

Elements:

- Due today tab
- Submitted tab
- Overdue tab
- Form list by department
- Form detail entry screen
- Submit button with loading state

Priority forms:

- N1 Forge Shop hourly production log
- N2 Press Shop hourly production log
- N3 Heat Treatment batch log
- N4 Maintenance daily PM checklist
- N5 Electricity daily consumption log
- N6 Shift report for production departments

Behavior:

- Load forms by role and department.
- Validate required fields.
- Disable submit during save.
- Save response to Firestore.
- Return to dashboard refresh.

## Screen 5 - Tasks

Users:

- All roles

Purpose:

- Assign, track, and complete accountability tasks.

Elements:

- My tasks
- Assigned by me
- Overdue
- Task detail
- Status selector
- Completion note
- Proof attachment placeholder

Behavior:

- Shift Incharge can update own assigned tasks.
- Supervisor can assign to team.
- Manager can assign within department.
- Plant Head can assign across plant.
- App notifications route directly to task detail.

## Screen 6 - Performance

Users:

- All roles, with role restrictions

Purpose:

- Show KPI/KRA performance and accountability score.

Elements:

- Current period score
- Attendance score
- Task score
- Form score
- Manager observation score
- KRA/KPI list
- Score entry screen for Manager/Plant Head only

Behavior:

- Staff/Shift Incharge view only.
- Supervisor views team if permitted.
- Manager enters score inputs.
- Plant Head views all and can approve/override.
- Non-manager view must never save/calculate score.

## Screen 7 - Notifications

Users:

- All roles

Purpose:

- View app notification history.

Elements:

- Unread notifications
- All notifications
- Notification detail

Behavior:

- Push notifications arrive outside this screen.
- Tapping push opens related task/form/performance page.
- Dismiss keeps user on current screen.
- No email or WhatsApp reminder flow.

## Screen 8 - Manager Score Entry

Users:

- Manager
- Plant Head

Purpose:

- Enter accountability observation and finalize performance score.

Elements:

- Select employee
- Show attendance/form/task metrics
- Observation score input
- Notes
- Calculate score button
- Save button

Behavior:

- Before calculation, read latest task/form/attendance data from Firestore.
- Disable save while saving.
- Write to performance_scores.
- Write audit log.

## Navigation

Bottom navigation:

- Home
- Attendance
- Forms
- Tasks
- Performance
- Notifications

Plant Head and Manager may also see:

- Team/Department switcher
- Exceptions

## Offline Behavior

Required:

- Firestore offline persistence enabled.
- If attendance/form/task save fails, keep pending local write.
- Show visible pending sync status.
- Do not duplicate saves when user taps repeatedly.

## Must Not Build In Phase 1

- Leave application
- Payroll
- Salary display
- Zoho direct push
- Full HR admin module
- Document storage
