---
title: "داکر سندباکس ۰٫۴۲٫۰ حفره‌های TOCTOU سوکت یونیکس و فرار virtio-fs در macOS را بست"
date: 2026-09-17T02:00:00+03:30
draft: false
slug: "docker-sandboxes-0-42-cves"
tags: ["docker", "sandboxes", "cve", "toctou", "virtio-fs", "macos"]
categories: ["Security", "DevOps", "AI"]
description: "سندباکس ۰٫۴۲٫۰ در ۷ سپتامبر: CVE-2026-79994 High برای مسابقه symlink در رله UDS، و CVE-2026-77179 Critical روی macOS برای دنبال کردن symlink در virtio-fs. Workaround: clone mode، بدون mount RW میزبان."
image: "/images/docker-sandboxes-0-42-cves.png"
---

<div dir="rtl">

Docker Sandboxes قرار است agent را داخل microVM نگه دارد، نه روی فایل‌سیستم و سوکت‌های میزبان. ریلیز **۰٫۴۲٫۰** در ۷ سپتامبر ۲۰۲۶ دو راه خروج از همان حصار را بست؛ یکی مسابقه روی سوکت، یکی دنبال کردن symlink روی virtio-fs مک.

[اعلام امنیتی Docker](https://docs.docker.com/security/security-announcements/) و [تگ v0.42.0](https://github.com/docker/sbx-releases/releases/tag/v0.42.0) هر دو همان روزند.

## دو CVE، دو سطح، دو سطح حمله

**CVE-2026-79994** — High. رله Unix-domain socket از guest به host مسیر را داخل workspace مجاز چک می‌کند، بعد با همان pathname دوباره وصل می‌شود. بین check و connect، guest می‌تواند دایرکتوری میانی را با symlink عوض کند تا host به یک `AF_UNIX` دلخواه بیرون workspace وصل شود. داده یا قابلیت سمت میزبانِ آن سوکت لو می‌رود. بازه: **۰٫۳۷٫۰ تا قبل از ۰٫۴۲٫۰**. CWE-367 (TOCTOU).

**CVE-2026-77179** — Critical، فقط **macOS**. سرور virtio-fs هنگام بازکردن مجدد فایل unlinkشده از stored path، symlink را دنبال می‌کند. guest مخرب parent directory را با symlink عوض می‌کند، از workspace مشترک بیرون می‌زند، و فایل دلخواه میزبان را با هویت کاربر VMM می‌خواند یا می‌نویسد — تا حد code execution روی host. بازه: **۰٫۲۸٫۰ تا قبل از ۰٫۴۲٫۰**. امتیاز گزارش‌شده CVSS 4.0 حدود **۹٫۴**.

اگر ۰٫۴۲٫۰ را همین حالا نمی‌توانید بگذارید، advisory همان دو کار را می‌گوید: سندباکس را در **clone mode** اجرا کنید و **mount خواندنی-نوشتنی میزبان** اضافه نکنید. نوت ریلیز ۰٫۴۲٫۰ پر از تغییر CLI و kit است؛ این دو CVE را با «پورت پیش‌فرض tcp4 شد» قاطی نکنید. مرز امنیتی همان دو advisory بالاست، نه فهرست Highlights.

</div>
