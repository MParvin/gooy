---
title: "حمله زنجیره‌ای به JFrog Artifactory: از توکن ناشناس تا backdoor"
date: 2026-09-14T12:00:00+03:30
draft: false
tags: ["jfrog", "artifactory", "cve", "supply-chain", "malware", "security"]
categories: ["Security", "DevOps"]
description: "Wiz زنجیره CVE-2026-42018 / 42016 / 82329 را در طبیعت روی Artifactory دیده: ادمین، پلاگین Groovy و backdoorهای Rust."
image: "/images/jfrog-artifactory-attack-chain.png"
---

<div dir="rtl">

در بعضی محیط‌های نفوذشده، از اولین درخواست تا حساب ادمین **کمتر از پنج دقیقه** طول کشیده.

[Wiz Research](https://www.wiz.io/blog/artifactory-under-attack-in-the-wild-exploitation-of-cve-2026-42016-cve-2026-4201) در ۱۰–۱۱ سپتامبر ۲۰۲۶ گزارش داد که سه آسیب‌پذیری JFrog Artifactory **در طبیعت exploit می‌شوند** و با هم زنجیر می‌شوند تا از یک درخواست بدون لاگین به کنترل ادمین برسند. [BleepingComputer](https://www.bleepingcomputer.com/news/security/artifactory-flaws-chained-in-attacks-deploying-backdoor-malware/) همین روایت را جمع کرده است.

| CVE | نقش در زنجیره |
| --- | --- |
| CVE-2026-42018 | برگرداندن توکن کاربر داخلی anonymous حتی وقتی anonymous access خاموش است |
| CVE-2026-42016 | توکن معتبر را به‌خاطر ضعف اعتبارسنجی scope تا سطح ادمین بالا می‌برد |
| CVE-2026-82329 | دور زدن احراز هویت؛ در پیکربندی پیش‌فرض، مهاجم بدون لاگین می‌تواند privilege ادمین بگیرد |

هیچ‌کدام از 42018 و 42016 به‌تنهایی ادمین کامل نمی‌دهند. اولی JWT کاربر داخلی anonymous را لو می‌دهد؛ دومی scope همان توکن را عوض می‌کند. با هم، دو قدم تا ادمین است. CVE-2026-82329 قبلاً از سوی چند فروشنده actively exploited گزارش شده و به CISA KEV هم اضافه شده.

Wiz در ۱۱ سپتامبر changelog گذاشت: HTTP method مربوط به CVE-2026-82329 و نسخه‌های پچ CVE-2026-42018 اصلاح شد. اگر از روی کپی قدیمی جدول نسخه می‌روید، به متن به‌روز مقاله Wiz برگردید.

## الگوی دیده‌شده بین ۱۵ اوت تا ۸ سپتامبر

1. `POST /access/api/v1/aws/token/` (با trailing slash) → HTTP 200 و JWT کاربر anonymous (CVE-2026-42018)
2. `POST /access/api/v1/tokens` → توکن با scope ادمین (CVE-2026-42016)
3. ساخت کاربر ادمین ماندگار با `PUT /api/security/users/` یا معادل UI

درخواست‌های بعدی در لاگ ممکن است با هویت `token:anonymous` دیده شوند؛ یعنی «anonymous» بودن اسم، ادمین نبودن privilege را نشان نمی‌دهد.

برای CVE-2026-82329 الگوی اولیه این بوده: `POST /access/api/v1/registry/join` بدون احراز هویت، پاسخ ۲۰۰/۲۰۱ با توکن ادمین در body.

بعد از ادمین شدن، در محیط‌های نفوذشده دیده‌اند: ساخت حساب ادمین ماندگار، نصب **Groovy plugin** مخرب برای اجرای کد روی سرور، و کاشتن **backdoor نوشته‌شده با Rust** با قابلیت C2. همه بازیگران همه قدم‌ها را نزده‌اند. بقیهٔ post-exploitation: اجرای دستور از `/api/plugins/execute/`، ریختن باینری در `/dev/shm` یا `/tmp` یا `/var/tmp`، آپلود web shell داخل Repository، کش رفتن configuration و join key کلاستر، enumeration کاربر/ریپو/توکن، و گاهی چسباندن SSH key مهاجم به کاربر ساخته‌شده.

نام‌های حساب جعلی رایج: الگوهایی مثل `Nxploited_*`، `labadmin_*`، `svc_*`، `0xTerror`، و اسم‌های «موجه» مثل `jfrog-distribution`، `jfrog-insight`، `repo-service`.

Artifactory یعنی artifact، cred، و غالباً مسیر CI/CD. ادمین شدن روی آن یعنی هم دزدیدن پکیج، هم گذاشتن پکیج مسموم، هم اجرای کد روی سرور از طریق Groovy plugin. این دیگر «باگ رجیستری» نیست؛ supply chain داخلی شماست.

## نسخه هدف، نه حداقل پچ یک CVE

Wiz می‌گوید بسته به شاخه، به یکی از این نسخه‌ها یا جدیدتر بروید:

- 7.111.21
- 7.117.28
- 7.125.20
- 7.133.29
- 7.146.38
- 7.161.20

جدول «کدام CVE کدام شاخه را می‌زند» بین CVEها فرق دارد (مثلاً 42016 در گزارش Wiz «قبل از 7.133.11» آمده). برای بستن هر سه، همان نسخه‌های بالا را هدف بگیرید.

وقتی 42016 اول بار ۲۷ ژوئیه منتشر شد، Wiz حدود ۶۷٪ سازمان‌های دارای Artifactory را حداقل یک instance آسیب‌پذیر دیده. سرعت پچ برای CVEهای «کم‌سروصداتر» کند بوده؛ 82329 به‌خاطر Critical سریع‌تر پایین آمده، اما هنوز درصد قابل توجهی آسیب‌پذیر مانده‌اند.

Instanceهای self-hosted را به نسخه ثابت بالا برسانید؛ اینترنت‌اکسپوز را اول ببندید یا محدود کنید. لاگ را برای join بدون احراز هویت، mint توکن توسط anonymous، ساخت کاربر ادمین، و فعالیت plugin چک کنید. حساب‌های ناشناس و SSH key اضافه‌شده را پاک کنید؛ tokenهای بلندعمر را revoke کنید. IOCهای مقاله Wiz (دامنه/IP/C2 و hash) را در شبکه و روی دیسک تطبیق دهید.

</div>
