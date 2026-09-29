---
title: "Flatpak 1.18.4 شش باگ امنیتی بست؛ از overwrite میزبان تا نشت OCI token"
date: 2026-09-29T16:15:00+03:30
draft: false
slug: "flatpak-1-18-4-security"
tags: ["flatpak", "linux", "cve-2026-97023", "cve-2026-97024", "cve-2026-97025", "sandbox", "desktop"]
categories: ["Security", "Linux"]
description: "ریلیز ۲۸ سپتامبر: CVE-2026-97023/97024 overwrite یا حذف فایل میزبان هنگام نصب بدخواه، نشت auth token OCI، پرمیشن ضعیف کش، فیلتر .desktop/D-Bus و DoS سیگنال. هدف: ۱٫۱۸٫۴ یا ۱٫۱۹٫۲ prerelease."
image: "/images/flatpak-1-18-4-security.png"
---

<div dir="rtl">

۲۸ سپتامبر ۲۰۲۶ [Flatpak 1.18.4](https://github.com/flatpak/flatpak/releases/tag/1.18.4) آمد و [اعلام oss-security](https://www.openwall.com/lists/oss-security/2026/09/28/6) شش اصلاح امنیتی را فهرست کرد؛ [Phoronix](https://www.phoronix.com/news/Flatpak-1.18.4-Released) هم همان روز ریلیز را پوشش داد. این یک «نسخهٔ جزیی با باگ UI» نیست؛ چندتایش مرز sandbox و میزبان را لمس می‌کند.

| CVE | خلاصه |
| --- | --- |
| **CVE-2026-97023 / 97024** | اپ مخرب هنگام نصب می‌تواند فایل دلخواه میزبان را با امتیاز بالا overwrite یا delete کند |
| **CVE-2026-97025** | نشت auth token مربوط به OCI |
| **CVE-2026-97026** | پرمیشن ضعیف روی `/var/tmp/flatpak-cache-*` |
| **CVE-2026-97027** | فیلتر ناکافی فیلدهای خطرناک `.desktop` / D-Bus |
| **CVE-2026-97029** | DoS با سیگنال به process group |

علاوه بر این‌ها، مسیر symlink traversal هم سخت‌گیرانه‌تر شده است. هدف ارتقا **1.18.4** است؛ اگر روی شاخهٔ توسعه هستید **1.19.2** prerelease همان فیکس‌ها را دارد. برای دسکتاپ‌هایی که Flatpak پیش‌فرض فروشگاه نرم‌افزار است، این آپدیت را هم‌سطح آپدیت کرنل ببینید: نصب از منبع نامطمئن، قبل از پچ، دیگر فقط «ریسک اپ» نیست و می‌تواند مستقیم فایل میزبان را هدف بگیرد.

</div>
