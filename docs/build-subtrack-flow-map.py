from pathlib import Path
import json, html

root = Path(__file__).parent
lanes = [
 ('Sign in & session', ['00–03 Welcome', '04 Sign in', 'Google / Apple', '05 or 07 Home'], '58 Sign-in failure → retry 04. 62 Session renewal → same provider → restore 07.'),
 ('Connect Gmail & discover', ['05 → 06 Privacy', '15 Choose inbox', 'Google consent', '11 Scan → 12 Review'], '16 Permission declined → retry / manual. 17 Interrupted → resume / review partial. 18 No results → manual / other inbox.'),
 ('Review & import', ['12 Candidates', '19 Verify details', '20 Merge duplicate', '21 Imported → 07'], '22 Cancellation detected → confirm → 36, or keep active → 09. Only selected, confirmed candidates are imported.'),
 ('Manual subscription', ['08 → 10 Add', '23 / 56 Service', '24–28 Field pickers', '55 Valid → 30 Saved'], '29 Validation → correct draft. 52 Save failed → retry same draft. 57 No search results → custom service 56.'),
 ('Manage a subscription', ['09 Details → 13 Edit', '35 Provider cancel', '36 Cancelled', '37 Delete → 08'], 'Cancellation happens at the service. SubTrack records the status. Reactivate → set next date 28 → save 13.'),
 ('Payments & calendar', ['07 See all → 31', '31 Calendar → 09', '09 Payments → 33', '32 Record → 34 Edit'], '34 Save → payment history 33. Upcoming payments open their subscription. 38 Trial → details / reminder.'),
 ('Insights & decisions', ['39 Insights', '42 Categories', '40 Review usage', '41 Review price'], 'Category → filtered subscriptions. Keep service → 09. Cancel → 35. Price confirm → update 09; reject → keep current price.'),
 ('Profile & connections', ['43 Profile → 59', '44 Gmail connected', '45 Disconnect', '60 Reconnect → 15'], '44 Scan again → 11. Disconnect preserves saved subscriptions. 46 Preferences → currency 26 / reminder 48.'),
 ('Notifications', ['Home bell → 47', '14 Preferences', '48 Reminder timing', '49 System settings'], 'Inbox links: renewal → 09; price → 41; found → 12; cancellation → 22. 61 Empty inbox → 31 / 14.'),
 ('Privacy & recovery', ['50 Privacy / export', '53 Sign out → 04', '54 Delete account', '51 Offline / 52 Retry'], 'Export → native share sheet. Delete → identity verification → 04. Offline uses cached data. Help → email composer.'),
]
parts=['<svg xmlns="http://www.w3.org/2000/svg" width="1800" height="1760" viewBox="0 0 1800 1760">', '<rect width="1800" height="1760" fill="#f4f4f4"/>']
def t(x,y,text,size=18,color='#111',weight=400):
 parts.append(f'<text x="{x}" y="{y}" font-family="SF Pro Display,Arial" font-size="{size}" font-weight="{weight}" fill="{color}">{html.escape(text)}</text>')
t(64,78,'SubTrack · Complete screen flow',40,weight=700)
t(64,116,'63 screen states · 00–14 existing · 15–62 added · arrows show intended transitions',20,'#666')
t(64,149,'Google consent, service cancellation and system settings are external handoffs.',18,'#777')
for i,(title,nodes,note) in enumerate(lanes):
 y=184+i*148
 parts.append(f'<g id="{html.escape(title)}"><rect x="48" y="{y}" width="1704" height="132" rx="24" fill="white" stroke="#e8e8e8"/>')
 t(72,y+36,title,21,weight=650)
 for j,n in enumerate(nodes):
  x=440+j*313
  parts.append(f'<rect x="{x}" y="{y+16}" width="284" height="45" rx="22" fill="{"#111" if j==0 else "#f5f5f5"}"/>')
  t(x+18,y+45,n,18,'white' if j==0 else '#111',550)
  if j<3: parts.append(f'<path d="M{x+290} {y+39}h17m-5-5 5 5-5 5" fill="none" stroke="#888" stroke-width="2"/>')
 t(72,y+97,note,17,'#666')
 parts.append('</g>')
t(64,1705,'Back returns to the originating screen. Drafts survive recoverable failures; retries do not create duplicate records.',18,'#666')
parts.append('</svg>')
(root/'subtrack-flow-map.svg').write_text(''.join(parts),encoding='utf8')
manifest=json.loads((root/'subtrack-missing-flows-manifest.json').read_text())
md=['# SubTrack screen transitions','', 'Design routes for the current MVP. Screen numbers match the Figma frame names. These routes document behavior; they are not wired prototype interactions.', '']
for title,nodes,note in lanes:
 md += ['## '+title, '', ' → '.join(nodes), '', note, '']
md += ['## Screen inventory', '', '| Screen | Name |', '|---|---|']
for b in manifest:
 for s in b['screens']: md.append(f"| {s['number']} | {s['name']} |")
md += ['', '## Business rules', '', '- Authentication and Gmail consent are separate. Cancelling Gmail consent keeps the signed-in session.', '- Scanning produces candidates; importing requires selection and confirmation. Merge into an existing subscription instead of duplicating it, keeping notes and payment history.', '- Validate positive price, currency, billing interval, and a next payment date before saving. Preserve drafts on errors and make retries idempotent.', '- Show yearly projections from the actual billing interval and currency. Display currency preference does not overwrite original subscription currency.', '- Payment history records and future reminders are separate. Recording a payment updates the relevant cycle without creating duplicate history.', '- Usage and savings are estimates that users review. Confirm price and cancellation changes before updating the tracked subscription.', '- Cancelling at a provider, marking cancelled in SubTrack, deleting a tracked subscription, disconnecting Gmail, and deleting an account are distinct actions.', '- Disconnecting Gmail stops scans and retains saved structured data. Account deletion requires verification and does not cancel provider plans.', '- Notification permission denied, offline, expired sessions, empty results, and failed saves each have a recovery route.', '- Native consent, settings, share sheet, identity verification, photo picker, browser cancellation, and email composer are platform handoffs.', '- Bank connections and payments are outside the current MVP design.', '']
(root/'subtrack-screen-transitions.md').write_text('\n'.join(md),encoding='utf8')
print('Flow map and 48-screen route inventory written.')
