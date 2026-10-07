# SubTrack — Smart Subscription Tracker

## 1. Project Overview

**SubTrack** — oddiy foydalanuvchilar uchun mo‘ljallangan mobil ilova bo‘lib, foydalanuvchining pullik obunalarini bir joyda kuzatish, kelayotgan to‘lovlarni eslatish, umumiy subscription xarajatlarini hisoblash va foydalanilmayotgan yoki keraksiz obunalarni aniqlashga yordam beradi.

Projectning asosiy g‘oyasi oddiy subscription list yaratish emas.

Asosiy value proposition:

**“SubTrack foydalanuvchining recurring to‘lovlarini topadi, ularni nazorat qiladi va keraksiz obunalarga ketayotgan pulni kamaytirishga yordam beradi.”**

App consumer-focused bo‘ladi va texnik bo‘lmagan oddiy foydalanuvchi uchun maksimal sodda UX bilan ishlab chiqiladi.

---

# 2. Main Goals

SubTrack foydalanuvchiga quyidagi savollarga tez javob berishi kerak:

- Men nechta pullik subscription ishlatyapman?
- Oyiga subscriptionlarga qancha pul sarflayapman?
- Yiliga bu qancha bo‘ladi?
- Keyingi subscription payment qachon?
- Qaysi subscription narxi oshgan?
- Qaysi subscriptiondan anchadan beri foydalanmaganman?
- Qaysi subscriptionni bekor qilsam pul tejayman?
- Oldin ishlatgan subscriptionim hali ham aktivmi?
- Qaysi recurring paymentlarni unutib qo‘yganman?

---

# 3. Target Audience

Asosiy auditoriya:

- Netflix, Spotify, YouTube Premium, ChatGPT, iCloud, Google One, Canva, Adobe va boshqa subscriptionlardan foydalanadigan odamlar
- bir nechta digital xizmatlarga obuna bo‘lgan foydalanuvchilar
- subscription paymentlarini unutib qo‘yadigan odamlar
- personal finance’ni nazorat qilishni istaydigan odamlar
- keraksiz recurring paymentlarni kamaytirishni istaydigan foydalanuvchilar

App global bozor uchun mo‘ljallanishi mumkin.

---

# 4. Platforms

Dastlab:

- Android
- iOS

Frontend:

**Flutter**

Keyinchalik web dashboard qo‘shilishi mumkin.

---

# 5. Authentication

Authentication uchun:

**Firebase Authentication**

Asosiy login providerlar:

- Continue with Google
- Continue with Apple

Muhim architecture principle:

**Authentication provider va subscription data source bir-biridan mustaqil bo‘ladi.**

Masalan foydalanuvchi:

- Apple orqali login qilishi
- lekin Gmail accountini subscription scanning uchun alohida ulashi

mumkin.

Google Sign-In faqat authentication qilish uchun ishlatilishi mumkin.

Gmail access esa alohida permission/integration sifatida qaraladi.

---

# 6. Backend

Backend asosan Firebase ecosystem asosida quriladi.

Stack:

- Firebase Authentication
- Cloud Firestore
- Firebase Cloud Functions
- Firebase Cloud Messaging
- Firebase Analytics
- Firebase Crashlytics
- Firebase Remote Config

Kerak bo‘lsa:

- Firebase App Check
- Cloud Scheduler
- Secret Manager

ishlatiladi.

---

# 7. Gmail Integration

SubTrackning asosiy avtomatik subscription detection manbalaridan biri Gmail bo‘ladi.

User app ichida alohida:

**Connect Gmail**

yoki:

**Scan my Gmail**

funksiyasini ishga tushiradi.

Google login qilgan bo‘lish Gmail’ni avtomatik o‘qish huquqini bermaydi.

Gmail scanning uchun alohida Google OAuth permission olinadi.

Taxminiy scope:

`gmail.readonly`

Gmail permission login vaqtida majburiy so‘ralmaydi.

Recommended flow:

1. User Google yoki Apple orqali login qiladi.
2. Dashboard ochiladi.
3. User “Find my subscriptions automatically” funksiyasini tanlaydi.
4. App Gmail access nima uchun kerakligini tushuntiradi.
5. User Gmail permission beradi.
6. Subscription scanning boshlanadi.

---

# 8. Gmail Privacy Principle

SubTrack barcha email kontentini Firestore’da saqlamasligi kerak.

Asosiy privacy principle:

**Email → Analyze → Extract subscription information → Discard email content**

Firestore’da faqat kerakli structured subscription information saqlanadi.

Masalan:

- provider
- subscription name
- plan
- price
- currency
- billing cycle
- last payment
- next estimated payment
- confidence score
- source

Email body doimiy database’da saqlanmaydi.

SubTrack personal correspondence reader sifatida emas, billing/subscription detection service sifatida ishlaydi.

---

# 9. Automatic Subscription Detection

Gmail scanning bir nechta bosqichdan iborat bo‘ladi.

## Stage 1 — Gmail Search

Barcha emailni backendga olib kelish o‘rniga Gmail search orqali candidate email topiladi.

Possible keywords:

- subscription
- subscribed
- membership
- renewed
- renewal
- recurring
- invoice
- receipt
- payment successful
- payment received
- charged
- billing
- premium
- plan
- monthly
- annual
- yearly

Known service domains ham ishlatilishi mumkin.

Masalan:

- spotify.com
- netflix.com
- google.com
- apple.com
- adobe.com
- canva.com
- openai.com

---

# 10. Detection Pipeline

Recommended architecture:

Gmail Inbox

↓

Gmail Search / Filtering

↓

Candidate Billing Emails

↓

Known Merchant Detection

↓

Rule-based Parser

↓

Payment Extraction

↓

Recurring Payment Detection

↓

Confidence Score

↓

AI Analysis only if needed

↓

User Confirmation

↓

Firestore Subscription

Bu orqali AI har bir emailga ishlatilmaydi.

---

# 11. Rule-Based Detection

Subscription aniqlashda avval deterministic/rule-based algorithm ishlatiladi.

Signals:

- known merchant
- subscription keywords
- renewal keywords
- billing cycle
- recurring dates
- similar amounts
- payment receipt
- next renewal date
- plan name

Example scoring:

Known merchant:\
+30

Explicit subscription keyword:\
+25

Recurring interval:\
+30

Same/similar amount:\
+10

Explicit next renewal date:\
+5

Total confidence:

0–100

Masalan:

95/100 → Very likely subscription

---

# 12. Recurrence Detection

Bir merchantdan kelgan bir nechta payment email orqali recurring payment aniqlanadi.

Example:

Spotify

July 4 — $10.99\
August 4 — $10.99\
September 4 — $10.99

Algorithm:

- merchant bir xil
- amount bir xil yoki yaqin
- payment interval \~30 kun

Natija:

Spotify Premium\
$10.99/month\
Confidence: 98%

Annual subscriptions uchun \~365 kunlik pattern aniqlanishi mumkin.

---

# 13. AI Usage

AI SubTrackning asosiy detection engine’i bo‘lmaydi.

AI faqat ambiguous yoki parser tushunmagan billing email uchun ishlatiladi.

Masalan AI structured data qaytaradi:

```json
{
  "service": "Spotify",
  "type": "subscription",
  "plan": "Premium Individual",
  "amount": 10.99,
  "currency": "USD",
  "billing_cycle": "monthly",
  "next_billing_date": "2026-11-04",
  "confidence": 0.98
}
```

Bu AI costni sezilarli kamaytiradi.

Ideal pipeline:

20,000 emails

↓

300 possible billing emails

↓

50 possible recurring payment emails

↓

12 subscription candidates

↓

faqat noaniq 2–5 ta candidate AI orqali tekshiriladi.

---

# 14. User Confirmation

SubTrack avtomatik detection natijasini hech qachon ko‘r-ko‘rona aktiv subscription sifatida qabul qilmasligi kerak.

User confirmation screen:

**We found a possible subscription**

Spotify Premium

$10.99/month

Last payments:

- September 4 — $10.99
- August 4 — $10.99
- July 4 — $10.99

Actions:

- Yes, add it
- No
- Not anymore

Faqat tasdiqlangandan keyin asosiy subscription listga qo‘shish mumkin.

---

# 15. Manual Subscription

User xohlasa subscriptionni qo‘lda ham qo‘sha oladi.

Fields:

- service
- subscription name
- category
- amount
- currency
- billing cycle
- next payment date
- payment method
- notes

Popular services catalog bo‘lishi mumkin.

Masalan:

- Netflix
- Spotify
- YouTube Premium
- ChatGPT
- iCloud+
- Google One
- Amazon Prime
- Canva
- Adobe
- Microsoft 365
- PlayStation Plus
- Xbox Game Pass

---

# 16. Subscription Model

Taxminiy subscription model:

```text
id
userId

service
serviceLogo
planName

amount
currency

billingCycle
billingInterval

startDate
lastPaymentDate
nextPaymentDate

source
status

confidence

category

createdAt
updatedAt
```

Source:

- manual
- gmail
- bank
- detected

Status:

- active
- trial
- cancelled
- expired
- unknown

---

# 17. Dashboard

Dashboard SubTrackning eng muhim ekranlaridan biri.

Asosiy ko‘rsatkichlar:

**Monthly subscriptions**

$47.92

**Active subscriptions**

8

**Yearly cost**

$575.04

**Upcoming payments**

3

**Potentially unused**

2

**Potential savings**

$14/month

yoki:

$168/year

---

# 18. Upcoming Payments

User kelayotgan paymentlarni timeline/calendar shaklida ko‘radi.

Example:

October 8\
Spotify — $10.99

October 12\
iCloud — $2.99

October 18\
Netflix — $15.49

October 25\
ChatGPT — $20

---

# 19. Notifications

FCM orqali subscription reminder yuboriladi.

Masalan:

**Spotify renews tomorrow**

$10.99 will be charged tomorrow.

Yoki:

**Netflix payment in 3 days**

$15.49

User reminder intervalni o‘zi belgilashi mumkin.

Masalan:

- 1 day before
- 3 days before
- 7 days before

---

# 20. Unused Subscription Detection

SubTrack unused subscriptionni 100% fakt sifatida emas, ehtimoliy signal sifatida ko‘rsatadi.

Termin:

**Potentially unused**

yoki:

**Seems unused**

ishlatiladi.

Signals:

- user manually says rarely used
- Android app usage
- app last opened date
- subscription payment davom etmoqda
- faqat receipt kelmoqda, boshqa activity signal yo‘q
- uzoq vaqt davomida service ishlatilmagan

Example:

Spotify Premium

$5.99/month

Last app usage:\
54 days ago

Paid during this period:\
$11.98

Potential saving:\
$71.88/year

---

# 21. Android App Usage

Android’da user alohida permission bersa app usage informationdan foydalanish mumkin.

Masalan:

Spotify

Last opened:\
47 days ago

Subscription:\
$5.99/month

SubTrack:

**Spotify hasn't been opened for 47 days.**

You may be paying for a subscription you no longer use.

Bu optional feature bo‘ladi.

---

# 22. iOS Limitation

iOS’da boshqa applarning usage ma’lumotlarini Android’dagidek erkin olish mumkin emas.

Shuning uchun unused detection Android va iOS’da bir xil bo‘lmasligi mumkin.

iOS uchun asosiy signals:

- Gmail receipts
- user feedback
- payment recurrence
- manual usage status

---

# 23. Cancellation Detection

Gmail orqali cancellation email ham aniqlanishi mumkin.

Possible keywords:

- subscription cancelled
- membership cancelled
- plan cancelled
- membership ended
- subscription ended
- auto-renew turned off

Agar shunday email aniqlansa:

**Spotify Premium may have been cancelled.**

Actions:

- Mark as cancelled
- Keep active

---

# 24. Price Change Detection

Subscription narxi o‘zgarsa SubTrack userga ko‘rsatishi mumkin.

Example:

Netflix

Previous:\
$13.99/month

New:\
$15.49/month

Increase:\
+$1.50

+10.7%

Notification:

**Netflix increased its price.**

---

# 25. Forgotten Subscription Detection

SubTrackning eng kuchli featurelaridan biri user unutgan subscriptionni aniqlash.

Example:

**We found 9 recurring subscriptions**

Monthly total:\
$84.74

Yearly:\
$1,016.88

Possible forgotten subscriptions:\
3

Potential savings:\
$286/year

Bu appning asosiy wow momentlaridan biri bo‘ladi.

---

# 26. Apple Authentication

Sign in with Apple Firebase Auth orqali ishlaydi.

Apple login faqat identity/authentication uchun.

Important:

**Sign in with Apple ≠ iCloud Mail access**

Apple ID orqali login qilish iCloud inboxni avtomatik o‘qish huquqini bermaydi.

Shuning uchun Apple orqali login qilgan user ham Gmail accountini alohida ulashi mumkin.

Example:

Account

Signed in with:\
Apple

Connected services:

Gmail — Connected

Bank — Not connected

App Usage — Not available

---

# 27. Future Bank Integration

Kelajakda bank/Open Banking integration qo‘shilishi mumkin.

Recurring transaction detection:

merchant bir xil

-

amount bir xil yoki yaqin

-

30-day / yearly recurrence

\=

possible subscription

Example:

NETFLIX.COM

Jan — $15.49\
Feb — $15.49\
Mar — $15.49

SubTrack:

**Recurring payment detected**

Netflix — $15.49/month

Add as subscription?

Bu Gmail’dan ham kuchli detection source bo‘lishi mumkin.

---

# 28. Data Sources

SubTrack kelajakda bir nechta data source bilan ishlashi mumkin.

Sources:

1. Manual
2. Gmail
3. Bank transactions
4. Android app usage
5. Service integrations
6. AI extraction

Har bir subscription qayerdan topilganini ko‘rsatish mumkin.

Example:

Spotify Premium

Detected from:\
Gmail

Usage:\
Android

---

# 29. Firestore Structure

Taxminiy architecture:

```text
users/
  {uid}/
    profile
    settings

    integrations/
      gmail
      bank

    subscriptions/
      {subscriptionId}

    detectedSubscriptions/
      {candidateId}

    notifications/
      {notificationId}
```

User profile:

```json
{
  "uid": "...",
  "email": "...",
  "authProvider": "google",
  "createdAt": "..."
}
```

Gmail integration:

```json
{
  "connected": true,
  "email": "user@gmail.com",
  "lastScanAt": "...",
  "scanEnabled": true
}
```

---

# 30. Cloud Functions Responsibilities

Cloud Functions quyidagilar uchun ishlatiladi:

- Gmail API communication
- OAuth token handling
- Gmail scanning
- subscription candidate detection
- receipt parsing
- recurrence detection
- AI classification
- price change detection
- cancellation detection
- subscription reminders
- scheduled scans
- notification sending

Mobile clientda sensitive logic yoki secret saqlanmaydi.

---

# 31. Security

Security juda muhim.

Principles:

- OAuth tokenlarni secure saqlash
- minimum required permissions
- email body’larini Firestore’da saqlamaslik
- least privilege
- Firebase App Check
- Firestore Security Rules
- Cloud Functions orqali protected operations
- sensitive API keys faqat server-side
- account disconnect imkoniyati
- Gmail access revoke imkoniyati

User istalgan paytda Gmail integrationni uzishi mumkin.

---

# 32. Gmail Verification

Gmail readonly permission Google tomonidan sensitive/restricted permission bo‘lishi mumkin.

Production release uchun Google OAuth verification talab qilinishi mumkin.

Shuning uchun Gmail integration architecture va privacy policy boshidan to‘g‘ri qurilishi kerak.

App userga aniq tushuntiradi:

- qaysi ma’lumot olinadi
- nima uchun olinadi
- nima saqlanadi
- nima saqlanmaydi
- qanday disconnect qilish mumkin

---

# 33. UX Philosophy

SubTrack UX quyidagicha bo‘lishi kerak:

- clean
- minimal
- consumer friendly
- technical terminology kam
- onboarding juda qisqa
- automation first
- manual work minimal

User appni ochganda spreadsheet yoki accounting app hissini olmasligi kerak.

Appning asosiy hissi:

**“Men subscriptionlar haqida o‘ylamasam ham SubTrack meni ogohlantirib turadi.”**

---

# 34. Main Navigation

Possible bottom navigation:

**Home**

**Subscriptions**

**Calendar**

**Insights**

**Profile**

Yoki MVP uchun soddaroq:

**Home**

**Subscriptions**

**Profile**

---

# 35. Onboarding

Recommended onboarding:

### Screen 1

**Know where your money goes.**

Track every subscription in one place.

### Screen 2

**Never miss a renewal.**

Get notified before you're charged.

### Screen 3

**Find subscriptions you've forgotten.**

Connect Gmail and let SubTrack do the work.

### Screen 4

Continue with Google

Continue with Apple

---

# 36. First Wow Moment

User Gmail scan boshlaydi.

Loading:

**Finding your subscriptions...**

Keyin:

**We found 11 recurring subscriptions**

$73.42 / month

$881.04 / year

3 subscriptions may be unused.

Potential savings:

$214/year

Bu SubTrackning eng muhim activation momenti.

---

# 37. Subscription Detail

Detail screen:

Spotify Premium

$10.99/month

Next payment:\
November 4

Last payment:\
October 4

Yearly cost:\
$131.88

Status:\
Active

Source:\
Gmail

Usage:\
Last opened 18 days ago

Payment history:

October — $10.99\
September — $10.99\
August — $10.99

Actions:

- Edit
- Mark cancelled
- Remind me
- Delete

---

# 38. Insights

Insights userga quruq statistika emas, useful information beradi.

Examples:

**You spend $74/month on subscriptions.**

**That's $888/year.**

**Entertainment accounts for 46% of your subscription spending.**

**Your subscription spending increased by 18% in the last 6 months.**

**Cancelling these 3 subscriptions could save you $216/year.**

---

# 39. Categories

Possible categories:

- Entertainment
- Music
- Video
- Gaming
- AI
- Productivity
- Cloud Storage
- Education
- Fitness
- Finance
- News
- Shopping
- Software
- Other

---

# 40. Free vs Premium

Possible monetization:

## Free

- manual subscriptions
- limited number of subscriptions
- basic reminders
- monthly spending
- basic dashboard

## Premium

- unlimited subscriptions
- Gmail auto detection
- automatic scanning
- unused subscription detection
- price change detection
- cancellation detection
- advanced insights
- yearly savings analysis
- multiple Gmail accounts
- future bank integrations

Pricing keyinchalik market validation asosida belgilanadi.

Possible range:

$1.99–$4.99/month

yoki:

$19–$39/year

---

# 41. MVP Scope

Birinchi MVP haddan tashqari katta bo‘lmasligi kerak.

Recommended MVP:

### Authentication

- Google
- Apple

### Subscription management

- add manually
- edit
- delete
- mark cancelled

### Dashboard

- monthly spend
- yearly spend
- active count
- upcoming payments

### Gmail

- connect Gmail
- search billing emails
- detect known subscriptions
- recurring payment detection
- user confirmation

### Notifications

- renewal reminder

### Basic insights

- monthly cost
- yearly cost

---

# 42. MVPdan keyingi versiyalar

## V1.1

- price change detection
- cancellation email detection
- better Gmail parsers

## V1.2

- Android usage detection
- potentially unused subscription

## V1.3

- AI parsing
- smarter confidence scoring

## V2

- bank integration
- recurring transaction detection

## V3

- family subscriptions
- shared subscriptions
- household subscription dashboard

---

# 43. Architecture Preference

Flutter project professional va scalable architecture asosida quriladi.

Preferred stack:

- Flutter
- BLoC
- Equatable
- Clean Architecture
- GoRouter
- GetIt
- Dio
- Firebase
- Secure Storage
- localization
- logger

`setState` imkon qadar business logic uchun ishlatilmaydi.

Business logic BLoC orqali boshqariladi.

Backend integration abstractions orqali yoziladi.

---

# 44. Design Direction

Design zamonaviy fintech/personal-finance uslubida bo‘lishi mumkin.

Key concepts:

- clean cards
- large financial numbers
- clear progress indicators
- subscription logos
- simple charts
- minimal clutter
- light/dark mode

App qo‘rqinchli “finance software” emas, yengil consumer product ko‘rinishida bo‘lishi kerak.

---

# 45. Product Principles

SubTrack uchun asosiy product principles:

### Automation over manual entry

User imkon qadar kam ma’lumot kiritishi kerak.

### Privacy first

Personal email kontenti keraksiz saqlanmasligi kerak.

### Explain every detection

Nega subscription deb topilganini user tushuna olishi kerak.

### User has final control

Algorithm hech qachon user nomidan subscription statusini mutlaq o‘zgartirmaydi.

### Focus on savings

Appning asosiy qiymati statistikadan ko‘ra foydalanuvchiga pul tejash imkoniyatini ko‘rsatish.

---

# 46. Core Product Statement

SubTrack — foydalanuvchining digital subscriptionlarini avtomatik topadigan, recurring to‘lovlarni kuzatadigan, kelayotgan paymentlarni eslatadigan va foydalanilmayotgan obunalarni aniqlash orqali pul tejashga yordam beradigan smart subscription management app.

Asosiy tagline variantlari:

**Track subscriptions. Save money.**

**Know what you're paying for.**

**Stop paying for subscriptions you forgot.**

**Every subscription. One place.**

**Find it. Track it. Cancel what you don't need.**

---

# 47. Current Project Decision

Hozirgi asosiy texnik qarorlar:

- Flutter mobile application
- Firebase backend
- Firebase Authentication
- Google Sign-In
- Sign in with Apple
- Cloud Firestore
- Cloud Functions
- FCM
- Gmail API integration
- Gmail scanning optional
- Gmail permission authenticationdan alohida
- email body database’da doimiy saqlanmaydi
- subscription detection rule-based + recurrence-based
- AI faqat murakkab/noaniq candidate’lar uchun
- detected subscription user tomonidan tasdiqlanadi
- Apple login iCloud Mail access bermaydi
- Apple user Gmail’ni alohida connect qilishi mumkin
- future bank integration rejalashtirilgan
- unused subscription detection keyingi bosqichlarda Android usage va boshqa signal orqali amalga oshiriladi

---

# 48. Main Vision

SubTrack oddiy subscription reminder app bo‘lib qolmasligi kerak.

U vaqt o‘tishi bilan foydalanuvchining barcha recurring digital expenseslarini tushunadigan **personal subscription assistant**ga aylanishi kerak.

Long-term vision:

**SubTrack automatically knows what you're subscribed to, what you're paying, what's changing, what you no longer use, and where you can save money.**
