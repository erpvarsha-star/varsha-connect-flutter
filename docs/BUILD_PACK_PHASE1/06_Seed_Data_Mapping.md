# Varsha Connect - Seed Data Mapping

## Source Files

Primary source files:

- `employees_active_109_seed.sql`
- `employees_fixed_seed (2).sql`
- `varsha_complete_seed_v2 (2).sql`
- `varsha_kra_operations (2).sql`
- `VFL_Forms_Required_Per_Department (2).txt`

## Role Mapping

Old source roles:

- worker
- supervisor
- manager
- hr_admin
- plant_head
- owner

Phase 1 roles:

- plant_head
- manager
- supervisor
- shift_incharge

Mapping:

- plant_head -> plant_head
- manager -> manager
- supervisor -> supervisor
- worker -> shift_incharge only when the employee is responsible for shift form filing or task completion
- hr_admin -> deferred unless assigned as manager for Phase 1
- owner -> deferred

## Staff Seed Notes

The active employee seed includes 109 employees.

It contains useful fields:

- emp_code
- name
- department
- designation
- role
- category
- salary_type
- gross salary
- active flag

Salary fields should not be imported into the Phase 1 app visible profile.

## Plant Head Found In Seed

The seed file contains:

- VFL1386
- Fazal Ilahi Khan
- role: plant_head

Use only after business confirmation.

## Departments Found Across Files

Departments include:

- Forge Shop
- Press Shop
- Heat Treatment
- Die Shop
- Machine Shop
- VMC Shop
- Cutting Shop
- Quality
- Maintenance
- Stores
- Purchase
- Design
- Human Resource
- Accounts
- Sales & Logistics
- Final Shop
- PPC
- QMS
- Management
- Administration

Phase 1 priority departments:

- Forge Shop
- Press Shop
- Heat Treatment
- Maintenance

## KRA/KPI Mapping

`varsha_kra_operations (2).sql` defines:

- role_kras
- role_kpis

Relevant KRA/KPI themes:

- Attendance discipline
- Work completion
- Safety compliance
- Team attendance management
- Operational reporting
- Team development
- Department performance
- Response time and approvals
- Data accountability
- Plant-wide operations
- Process integrity
- Customer response

Phase 1 should use:

- Attendance discipline
- Work/form completion
- Operational reporting
- Department performance
- Data accountability
- Plant-wide operations

Leave approval KPIs should be disabled for Phase 1 because leave is deferred.

## Form Template Mapping

From `VFL_Forms_Required_Per_Department (2).txt`, build Priority 1 first:

- N1 Forge Shop hourly production log
- N2 Press Shop hourly production log
- N3 Heat Treatment batch log
- N4 Maintenance daily PM checklist - Mechanical
- N5 Electricity daily consumption log - Electrical
- N6 Shift report for all production departments

Later forms remain backlog.

## Config Mapping

Shift times from source:

- general: 09:00-18:00
- first: 07:00-15:30
- second: 15:30-00:00
- third: 00:00-07:00
- day: 07:00-19:00
- night: 19:00-07:00

Geofence:

- Radius appears as 200m in an earlier seed block.
- Radius appears as 100m in a later QR/fraud seed block.
- Use 100m for pilot unless owner confirms otherwise.
- Exact latitude/longitude still needs confirmation if not present in another file.

## Import Order

1. departments
2. shifts
3. plant_config
4. users
5. role_kras
6. role_kpis
7. form_templates
8. sample tasks

## Data Safety

Do not import salary, payroll, bank, PAN, PF, ESI, or personal sensitive fields into the visible Phase 1 mobile app.

Keep Phase 1 identity minimal:

- emp_code
- name
- phone
- role
- department
- designation
- shift
- reporting manager
- active status
