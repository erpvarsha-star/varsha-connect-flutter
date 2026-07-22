# Varsha Connect - Lovable/GitHub Gap Audit

## Source Checked

Lovable public URL found in files:

- `https://varsha-connect-app.lovable.app`

GitHub repo found in files and cloned locally:

- `https://github.com/yashmunot-sudo/varsha-connect`
- Local clone: `lovable_github_current`

Lovable connector note:

- Real Lovable project ID received from user: `2e0ee012-d1c3-457b-9e20-afa967c67e43`.
- Project inspection succeeded.
- Supabase database is enabled.
- Read-only database query was blocked by Lovable scope permission: `403 insufficient_scope`.
- No further database query attempts were made.

Lovable project metadata:

- Name: `varsha-connect-app`
- Display name: `Varsha Connect`
- Tech stack: `vite_react_shadcn_ts_2026-03-20`
- Status: completed/ready
- Published URL: `https://varsha-connect-app.lovable.app`
- Editor URL: `https://lovable.dev/projects/2e0ee012-d1c3-457b-9e20-afa967c67e43`
- Latest commit SHA: `46bc884d99605d9c33361a8e67d12443bd7e1e4c`

## Existing Lovable App Stack

The old app is:

- React PWA
- Supabase
- Lovable
- Tailwind/shadcn-style components

Current frozen build remains:

- Flutter mobile app
- Firebase/Firestore
- Firebase Cloud Messaging
- Google Sheets reporting mirror

Therefore, the GitHub repo is a source of working business logic and screen ideas, not the target architecture.

## Useful Existing Pieces To Carry Forward

### 1. Geofence Logic

File:

- `src/lib/geofence.ts`

Useful logic:

- Haversine distance calculation
- `isInsideGeofence(lat, lng)`
- high-accuracy location request
- Confirmed plant geofence from Lovable project:
  - latitude: `19.8383935925407`
  - longitude: `75.23638998304483`
  - radius: `200m`

Mobile action:

- Port Haversine distance function to Flutter attendance service.
- Keep Firestore `plant_config/main` as the source of plant lat/lng/radius.

### 2. Role Pages

Existing pages:

- `PlantHeadHome.tsx`
- `ManagerHome.tsx`
- `SupervisorHome.tsx`
- `WorkerHome.tsx`
- `SecurityGuardHome.tsx`
- `HRAdminHome.tsx`
- `OwnerHome.tsx`

Mobile Phase 1 carry-forward:

- Plant Head dashboard: plant attendance, department stats, average score, exceptions.
- Manager dashboard: department attendance, KPI view, task/form completion.
- Supervisor dashboard: team execution and due forms/tasks.
- Worker/Shift Incharge behavior: own attendance, tasks, forms, score view.

Deferred:

- HR Admin
- Owner
- Security Guard unless QR/vehicle gate is brought into Phase 1

### 3. Task Workflow

Existing component:

- `TaskDelegationScreen.tsx`

Useful behavior:

- Assigned to me
- Assigned by me
- Filters: all, pending, overdue, done
- Statuses: Assigned, Acknowledged, In Progress, Done
- Manager/supervisor/plant head can create tasks
- Assignee can acknowledge and complete
- Due date and priority displayed
- Notification inserted when task is assigned

Mobile action:

- Port this structure into Flutter `TasksScreen`.
- Use Firestore collection `tasks`.
- Keep notification routing to task detail.

### 4. Plant Head Dashboard

Existing `PlantHeadHome.tsx` includes:

- total active employee count
- present count
- attendance percentage
- average score
- department performance ranking
- pending approvals
- MRM/email/purchase/match tabs

Mobile Phase 1 carry-forward:

- employee count
- present count
- attendance percent
- average score
- department exception list

Deferred:

- leave approvals
- advance approvals
- MRM
- email tab
- purchase requisition
- three-way match

### 5. Manager Dashboard

Existing `ManagerHome.tsx` includes:

- department attendance
- KPI summary
- absent count
- late count
- average score
- pending approvals

Mobile Phase 1 carry-forward:

- department attendance
- KPI summary
- absent/late counts
- average score
- task/form accountability

Deferred:

- leave/advance approvals

### 6. Bilingual Layer

Existing files:

- `src/i18n/LanguageContext.tsx`
- `src/i18n/translations.ts`
- `BilingualText`

Mobile action:

- Keep English first.
- Preserve app architecture so Hindi/Marathi can be added later.
- Do not block Phase 1 on full translation.

### 7. Logo/Branding

Existing repo has:

- `src/assets/vfl-logo.jpeg`

User-provided final logo:

- `D:\YJM_PROJECTS_SORTED\11_VFL_Website_Company_Content\VFL logo no background.png`

Mobile action completed:

- Copied into Flutter app as `assets/images/varsha_logo.png`.
- Login screen now references this asset.

## Modules Present In Lovable But Deferred From Mobile Phase 1

Do not build now:

- Leave application
- Leave encashment
- Payroll
- Payslip
- PF/ESIC challans
- Advance approvals
- Contract labour payroll
- Minimum wages compliance
- Probation
- Holiday master
- Regularisation approvals
- Purchase requisition
- GRN
- Three-way match
- Email task inbox
- MRM review
- Vehicle log/security gate
- Part master

These are useful future modules, but they will confuse Phase 1 if included now.

## Gaps Filled In Current Build Pack

The old Lovable repo had a strong app, but the new mobile/Firebase build pack fills these gaps:

- Native mobile direction instead of PWA
- FCM push notifications with sound
- Firestore as production database
- Google Sheets only as reporting mirror
- Role-safe performance scoring
- Staff read-only score path
- Explicit dashboard refresh logic
- Priority 1 in-app operational forms
- Firestore rules/indexes deployed
- Firebase Android app created
- Seed converter for users, departments, KRA, KPI
- Confirmed plant GPS from Lovable project added to Firebase seed template

## Still Needed From Lovable Directly

Only if deeper database inspection is required:

- Lovable connector/query permission with database scope

The project metadata plus GitHub clone already provide enough code reference for Phase 1 logic.
