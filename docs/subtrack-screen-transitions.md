# SubTrack screen transitions

Design routes for the current MVP. Screen numbers match the Figma frame names. These routes document behavior; they are not wired prototype interactions.

## Sign in & session

00–03 Welcome → 04 Sign in → Google / Apple → 05 or 07 Home

58 Sign-in failure → retry 04. 62 Session renewal → same provider → restore 07.

## Connect Gmail & discover

05 → 06 Privacy → 15 Choose inbox → Google consent → 11 Scan → 12 Review

16 Permission declined → retry / manual. 17 Interrupted → resume / review partial. 18 No results → manual / other inbox.

## Review & import

12 Candidates → 19 Verify details → 20 Merge duplicate → 21 Imported → 07

22 Cancellation detected → confirm → 36, or keep active → 09. Only selected, confirmed candidates are imported.

## Manual subscription

08 → 10 Add → 23 / 56 Service → 24–28 Field pickers → 55 Valid → 30 Saved

29 Validation → correct draft. 52 Save failed → retry same draft. 57 No search results → custom service 56.

## Manage a subscription

09 Details → 13 Edit → 35 Provider cancel → 36 Cancelled → 37 Delete → 08

Cancellation happens at the service. SubTrack records the status. Reactivate → set next date 28 → save 13.

## Payments & calendar

07 See all → 31 → 31 Calendar → 09 → 09 Payments → 33 → 32 Record → 34 Edit

34 Save → payment history 33. Upcoming payments open their subscription. 38 Trial → details / reminder.

## Insights & decisions

39 Insights → 42 Categories → 40 Review usage → 41 Review price

Category → filtered subscriptions. Keep service → 09. Cancel → 35. Price confirm → update 09; reject → keep current price.

## Profile & connections

43 Profile → 59 → 44 Gmail connected → 45 Disconnect → 60 Reconnect → 15

44 Scan again → 11. Disconnect preserves saved subscriptions. 46 Preferences → currency 26 / reminder 48.

## Notifications

Home bell → 47 → 14 Preferences → 48 Reminder timing → 49 System settings

Inbox links: renewal → 09; price → 41; found → 12; cancellation → 22. 61 Empty inbox → 31 / 14.

## Privacy & recovery

50 Privacy / export → 53 Sign out → 04 → 54 Delete account → 51 Offline / 52 Retry

Export → native share sheet. Delete → identity verification → 04. Offline uses cached data. Help → email composer.

## Screen inventory

| Screen | Name |
|---|---|
| 15 | Confirm Gmail account |
| 16 | Gmail permission declined |
| 17 | Scan interrupted |
| 18 | No subscriptions found |
| 19 | Verify detected subscription |
| 20 | Resolve duplicate subscription |
| 21 | Import completed |
| 22 | Confirm detected cancellation |
| 23 | Service catalog |
| 24 | Category selection |
| 25 | Billing cycle selection |
| 26 | Currency selection |
| 27 | Payment method selection |
| 28 | Renewal date picker |
| 29 | Manual form validation |
| 30 | Subscription saved |
| 31 | Upcoming payments |
| 32 | Payment record |
| 33 | Subscription payments tab |
| 34 | Record a payment |
| 35 | Cancellation guide |
| 36 | Cancelled subscription |
| 37 | Delete subscription confirmation |
| 38 | Search and trial states |
| 39 | Insights overview |
| 40 | Potentially unused review |
| 41 | Price change review |
| 42 | Category spending detail |
| 43 | Profile |
| 44 | Connected accounts |
| 45 | Disconnect Gmail confirmation |
| 46 | Preferences |
| 47 | Notification inbox |
| 48 | Reminder timing selection |
| 49 | Notifications unavailable |
| 50 | Privacy and data controls |
| 51 | Offline state |
| 52 | Save failed recovery |
| 53 | Sign out confirmation |
| 54 | Delete account confirmation |
| 55 | Completed manual subscription |
| 56 | Custom service entry |
| 57 | No search results |
| 58 | Sign-in recovery |
| 59 | Account details |
| 60 | Gmail disconnected state |
| 61 | Empty notification inbox |
| 62 | Session renewal |

## Business rules

- Authentication and Gmail consent are separate. Cancelling Gmail consent keeps the signed-in session.
- Scanning produces candidates; importing requires selection and confirmation. Merge into an existing subscription instead of duplicating it, keeping notes and payment history.
- Validate positive price, currency, billing interval, and a next payment date before saving. Preserve drafts on errors and make retries idempotent.
- Show yearly projections from the actual billing interval and currency. Display currency preference does not overwrite original subscription currency.
- Payment history records and future reminders are separate. Recording a payment updates the relevant cycle without creating duplicate history.
- Usage and savings are estimates that users review. Confirm price and cancellation changes before updating the tracked subscription.
- Cancelling at a provider, marking cancelled in SubTrack, deleting a tracked subscription, disconnecting Gmail, and deleting an account are distinct actions.
- Disconnecting Gmail stops scans and retains saved structured data. Account deletion requires verification and does not cancel provider plans.
- Notification permission denied, offline, expired sessions, empty results, and failed saves each have a recovery route.
- Native consent, settings, share sheet, identity verification, photo picker, browser cancellation, and email composer are platform handoffs.
- Bank connections and payments are outside the current MVP design.
