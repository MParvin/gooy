---
title: "OpenSSL ۲۹ سپتامبر: DTLS retransmission حافظه را لو می‌دهد (CVE-2026-84782)"
date: 2026-09-30T14:20:00+03:30
draft: false
slug: "openssl-secadv-20260929-dtls"
tags: ["openssl", "dtls", "tls", "quic", "cve-2026-84782", "security"]
categories: ["Security"]
description: "Advisory رسمی OpenSSL: CVE-2026-84782 با شدت High در retransmission DTLS؛ به‌علاوه ۱۳ مورد دیگر. فیکس در 4.0.3، 3.6.5، 3.5.9، 3.4.8 و شاخه‌های premium."
image: "/images/openssl-secadv-20260929-dtls.png"
---

<div dir="rtl">

[متن advisory رسمی OpenSSL برای ۲۹ سپتامبر ۲۰۲۶](https://openssl-library.org/news/secadv/20260929.txt) ۱۴ شناسه دارد؛ سنگین‌ترین‌شان **CVE-2026-84782** با شدت **High** است. مسیر مشکل، retransmission در **DTLS** است: در شرایطی که پکت دوباره فرستاده می‌شود، پیاده‌سازی می‌تواند محتوای heap را به‌صورت plaintext بیرون بدهد یا سرویس را crash کند. برای هر چیزی که روی UDP و DTLS نشسته — VoIP، بعضی تونل‌ها، پروتکل‌های بلادرنگ — این جمله کافی است که نسخهٔ کتابخانه را چک کنید، نه اینکه «TLS ما روی TCP است پس بی‌خیال».

همان advisory یک **use-after-free** متوسط در cache افزونهٔ X.509 زیر استفادهٔ همزمان ثبت کرده: **CVE-2026-84783**، محدود به **OpenSSL 4.0**. کنارش مجموعه‌ای از مسائل Low در مسیرهای QUIC، DTLS و timing آمده‌اند؛ جزئیات در همان فایل متنی و در [بحث oss-security](https://seclists.org/oss-sec/2026/q3/1001) جمع شده است.

نسخه‌های اصلاح‌شدهٔ اعلام‌شده:

| شاخه | فیکس |
|------|------|
| 4.0 | **4.0.3** |
| 3.6 | **3.6.5** |
| 3.5 | **3.5.9** |
| 3.4 | **3.4.8** |
| premium 3.0 | **3.0.23** |
| premium 1.1.1 | **1.1.1zj** |
| premium 1.0.2 | **1.0.2zs** |

اگر OpenSSL را از توزیع لینوکس می‌گیرید، بستهٔ vendor را با این شماره ردیابی کنید؛ اگر خودتان static link کرده‌اید، بیلد را از سورس فیکس‌شده دوباره ببندید. ریسک عملی CVE-2026-84782 افشای حافظه یا قطع سرویس در مسیر retransmission است — نه یک RCE تیتر‌باز، ولی برای سرویس‌های DTLS رو به اینترنت، همان افشای heap کافی است که ارتقا در صف اول قرار بگیرد.

</div>
