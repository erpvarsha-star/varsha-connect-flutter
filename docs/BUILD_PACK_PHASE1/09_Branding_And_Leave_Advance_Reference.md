# Branding And Leave/Advance Reference

Source: user-provided reference message after Lovable project review.

## Brand Rules To Apply

Colors:

- Primary orange: `#E87722`
- Gray: `#6B6B6B`
- Background: `#F5F5F5`
- Card background: `#FFFFFF`
- Card/border: `#E0E0E0`
- Text: `#1A1A1A`
- Success: `#2E7D32`
- Danger: `#C62828`
- Warning: `#F57C00`

Logo:

- Login: large centered logo above app title.
- Top bar: small logo left, `Varsha Forgings` in gray next to it.
- Login footer: `VARSHA FORGINGS PVT LTD · AURANGABAD`.

UI:

- No dark/black backgrounds.
- Cards: white, 12px radius, 16px padding, subtle shadow.
- Worker buttons: minimum 56px height, orange, white text, bold, 12px radius.
- Bottom nav: active orange, inactive gray, white background, top border.

Applied to Flutter starter:

- Theme updated to these colors.
- Login screen logo/footer updated.
- App top bar added with logo and `Varsha Forgings`.

## Leave/Advance Reference

The reference requests leave and salary advance features.

Current project decision:

- This is reference.
- Do not switch to Supabase tables.
- If approved for mobile build, map to Firestore collections.

### leave_balances

Fields:

- emp_code
- year
- el_balance
- cl_balance
- sl_balance
- updated_at

### leave_requests

Fields:

- id
- emp_code
- leave_type
- from_date
- to_date
- reason
- status
- applied_at
- reviewed_by
- reviewed_at

### salary_advances

Fields:

- id
- emp_code
- opening_balance
- amount_sanctioned
- amount_deducted
- closing_balance
- month
- year
- entered_by
- created_at

### advance_requests

Fields:

- id
- emp_code
- amount_requested
- reason
- repayment_months
- status
- applied_at
- reviewed_by
- reviewed_at

## Scope Decision Needed

Leave/advance was previously deferred from Phase 1.

If the user approves these as Phase 1, add:

- Worker leave balance/apply card
- Worker salary advance/apply card
- Manager pending approvals
- HR advance entry
- Firestore rules for leave/advance collections
- Google Sheets reporting tabs

Until then, keep them as reference/backlog.
