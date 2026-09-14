---
title: "Patch Tuesday سپتامبر ۲۰۲۶ مایکروسافت: نزدیک به هزار CVE و دو zero-day فعال"
date: 2026-09-14T21:00:00+03:30
draft: false
tags: ["microsoft", "patch-tuesday", "cve", "windows", "exchange", "security"]
categories: ["Security"]
description: "بزرگ‌ترین Patch Tuesday تاریخ مایکروسافت با حدود ۹۶۶ تا ۹۷۴ آسیب‌پذیری، دو zero-day در حال سوءاستفاده، و یک RCE مهم در Exchange."
---

<div dir="rtl">

## چه اتفاقی افتاد؟

سه‌شنبه ۸ سپتامبر ۲۰۲۶، مایکروسافت بزرگ‌ترین Patch Tuesday خودش را منتشر کرد. عددها آن‌قدر بزرگ است که حتی منابع معتبر هم روی یک رقم واحد توافق ندارند.

[BleepingComputer](https://www.bleepingcomputer.com/news/microsoft/microsoft-september-2026-patch-tuesday-fixes-966-flaws-2-zero-days/) فقط CVEهایی را می‌شمارد که همان روز Patch Tuesday منتشر شده‌اند و به **۹۶۶** می‌رسد. [The Register](https://www.theregister.com/security/2026/09/09/microsoft-breaks-patch-tuesday-record-with-974-cve-deluge/5295160) رقم **۹۷۴** را گزارش می‌کند. تفاوت از روش شمارش است، نه از این‌که یکی از دو منبع اشتباه کرده باشد: BleepingComputer حدود ۲۰۴ باگِ اوایل ماه (Azure، Edge، Fabric و مشابه) را جدا می‌گذارد. در هر دو روایت، این بزرگ‌ترین بسته امنیتی تاریخ مایکروسافت است.

طبق گزارش BleepingComputer، بین CVEهای همان روز تقریباً ۱۰۵ مورد Critical بوده‌اند؛ از جمله ۸۱ Remote Code Execution. دسته‌بندی تقریبی کل بسته:

- ۴۳۸ Elevation of Privilege
- ۲۵۸ Remote Code Execution
- ۱۷۳ Information Disclosure
- ۵۶ Denial of Service
- ۱۹ Security Feature Bypass
- ۱۶ Spoofing

افزایش حجم آپدیت‌ها بعد از این است که مایکروسافت از سیستم کشف آسیب‌پذیری مبتنی بر AI استفاده می‌کند؛ یعنی بخشی از این «سیل CVE» محصول پیدا کردن باگ‌های بیشتر است، نه لزوماً بدتر شدن کیفیت نرم‌افزار یک‌شبه.

---

## دو zero-day که همین حالا exploit می‌شوند

مایکروسافت دو آسیب‌پذیری را به‌عنوان zero-day در حال سوءاستفاده تأیید کرده است. هر دو Elevation of Privilege محلی هستند و به SYSTEM می‌رسند.

### CVE-2026-81963 — Windows Update Stack

باگ از نوع *improper link resolution* (link following) در Windows Update Stack است. مهاجم مجاز محلی می‌تواند privilege را بالا ببرد. کشف آن به Romain Deperne و Microsoft Threat Intelligence Centre نسبت داده شده. جزئیات exploit در حملات منتشر نشده است.

Dustin Childs از Zero Day Initiative می‌گوید محتمل است این باگ با یک RCE ترکیب شود تا malware یا ransomware پخش شود و توصیه می‌کند سریع پچ شود.

### CVE-2026-85880 — Windows ALPC

Heap-based buffer overflow در Windows Advanced Local Procedure Call. طبق توضیح مایکروسافت، مهاجمی که بتواند در یک AppContainer کم‌امتیاز کد اجرا کند، می‌تواند از sandbox خارج شود و روی سیستم privilege بگیرد؛ بدون تعامل اضافه کاربر. کشف: Volexity و تیمی در Proofpoint.

CISA هر دو را به کاتالوگ Known Exploited Vulnerabilities اضافه کرده و برای دستگاه‌های فدرال آمریکا مهلت ۲۲ سپتامبر گذاشته است.

---

## Exchange را جدا ببینید: CVE-2026-55007

این یکی zero-day فعال اعلام نشده، اما از نظر عملی برای ادمین Exchange از خیلی از CVEهای Critical مهم‌تر است.

طبق [بولتن MSRC](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2026-55007) و گزارش The Register:

- نوع: double-free و Remote Code Execution روی Microsoft Exchange Server
- مهاجم بدون احراز هویت یک ایمیل با پیوست Visio مخرب می‌فرستد
- سرور هنگام content indexing پیوست را پردازش می‌کند
- تعامل کاربر لازم نیست

مایکروسافت گفته trigger کردنش «سخت» است. پاسخ Childs این است که مهاجم فقط باید یک‌بار درست بزند. این ماه ۹ باگ Exchange آمده؛ همین یکی را Childs «مهم‌ترین پچ» سرور پیام‌رسانی خوانده است.

آپدیت‌های سپتامبر Exchange شامل KB5121608 (Subscription Edition)، KB5121609 / KB5121610 (Exchange 2019) و KB5121611 (Exchange 2016 CU23) است.

---

## چرا مهم است؟

۹۰۰-و-خرده‌ای CVE یعنی صف پچ واقعی است، نه یک سه‌شنبه معمولی. دو zero-day محلی یعنی اگر مهاجم یک‌بار روی سیستم جا باز کند، مسیر SYSTEM کوتاه است. Exchange هم اگر هنوز on-prem دارید، همان الگوی همیشگی است: ایمیل می‌آید، indexing کار خودش را می‌کند، شما پشت میز نیستید.

ZDI همچنین حدود ۲۰ پچ wormable در همین انتشار شمرده؛ یعنی بخشی از این بسته فقط «EoP داخلی» نیست.

---

## چه کار کنید؟

- Windows را با Patch Tuesday سپتامبر ۲۰۲۶ به‌روز کنید؛ CVE-2026-81963 و CVE-2026-85880 را در اولویت بگذارید.
- سرورهای Exchange را با KB مربوط به نسخه خودتان آپدیت کنید و CVE-2026-55007 را جدا پیگیری کنید.
- اگر به advisory برای Edge/Chromium تکیه می‌کنید: CVE-2026-85046 ابتدا در Chrome پچ شد؛ بعداً مایکروسافت تأیید کرد آپدیت Chromium در Edge نسخه 152.0.4191.62 آمده است. تا وقتی advisory رسمی نیاید، فرض امن این است که مرورگر را از کانال خودش به‌روز کنید.

---

## منابع

- [BleepingComputer: Microsoft September 2026 Patch Tuesday fixes 966 flaws, 2 zero-days](https://www.bleepingcomputer.com/news/microsoft/microsoft-september-2026-patch-tuesday-fixes-966-flaws-2-zero-days/)
- [The Register: Microsoft breaks Patch Tuesday record with 974-CVE deluge](https://www.theregister.com/security/2026/09/09/microsoft-breaks-patch-tuesday-record-with-974-cve-deluge/5295160)
- [MSRC: CVE-2026-55007](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2026-55007)
- [MSRC September 2026 release notes](https://msrc.microsoft.com/update-guide/releaseNote/2026-Sep)

</div>
