---
title: "بتای فدورا ۴۵: کنسول KMSCON، GNOME ۵۱ و امضای بسته به‌صورت پیش‌فرض"
date: 2026-09-16T06:40:00+03:30
draft: false
slug: "fedora-45-beta"
tags: ["fedora", "linux", "gnome", "kmscon", "rpm"]
categories: ["Linux"]
description: "بتای فدورا ۴۵ در ۱۵ سپتامبر ۲۰۲۶: KMSCON جای کنسول درون‌کرنل، اجبار بررسی امضا، محدودسازی ptrace، GNOME 51 و زنجیره ابزار تازه‌تر. هدف GA حدود ۲۰ اکتبر."
image: "/images/fedora-45-beta.png"
---

<div dir="rtl">

سه‌شنبه ۱۵ سپتامبر ۲۰۲۶ فدورا بتای ۴۵ را طبق برنامه گذاشت. [اعلام Fedora Magazine](https://fedoramagazine.org/announcing-fedora-linux-45-beta/) دعوت به تست است، نه نصب production: Workstation، KDE Plasma Desktop، Server، Cloud، IoT، به‌علاوه Atomic و اغلب Spin/Lab (به‌جز ISOهای MiracleWM و Budgie-Atomic و Sway-Atomic). ارتقا از سیستم موجود با DNF system-upgrade ممکن است. هدف GA حدود **۲۰ اکتبر ۲۰۲۶** است، با تاریخ ذخیره **۲۷ اکتبر** — همان تقویمی که [Phoronix](https://www.phoronix.com/news/Fedora-45-Beta) نوشته.

چیزی که این بتا را از «GNOME یک شماره جلوتر» جدا می‌کند، چند پیش‌فرض سطح سیستم است که روی جعبهٔ سیاه نصب‌شده می‌نشینند.

## کنسول دیگر آن بافر کرنل قدیمی نیست

فدورا ۴۵ کنسول legacy درون‌کرنل را با **KMSCON** عوض می‌کند. Magazine از رندر نرم‌تر، Unicode/فونت بهتر و پایداری بیشتر حرف زده. اگر روی سرور بدون نمایشگر یا روی بازیابی از tty کار می‌کنید، همین باید اولین جایی باشد که در بتا فشار می‌آورید — تعویض کنسول نوعی تغییری است که در یادداشت ریلیز قشنگ به‌نظر می‌رسد و روی ماشین واقعی فونت و کیبورد را خراب می‌کند.

Anaconda هم **Stratis** را native برای پارتیشن می‌شناسد؛ Phoronix همان را «Stratis Storage support within the Anaconda installer» نوشته. روی Atomic Desktop، ISOها با image-builder ساخته می‌شوند و Anaconda جریان WebUI اولیه برای Atomic دارد. CoreOS در ۴۵ بتا **systemd-oomd** و zram swap می‌گیرد.

## امضا اجباری است؛ ptrace دیگر پیش‌فرض باز نیست

از این بتا، نصب بسته بدون امضای معتبر پیش‌فرض رد می‌شود — Magazine: «now requires valid package signatures by default». Phoronix کنارش **محدودسازی ptrace به‌صورت پیش‌فرض** و انتظار **بازتولیدپذیر بودن بیلد بسته** را آورده، به‌علاوه front-end **DRM Panic** برای وقتی کرنل واقعاً می‌ترکد. مدیریت رمز دسکتاپ هم با **oo7** یکدست شده و backendهای قدیمی مثل GNOME Keyring و KWallet را کنار می‌زند؛ روی KDE هنوز سؤال GUI جدا در بحث انجمن باز است.

زنجیرهٔ ابزار از همان دو منبع:

- دسکتاپ Workstation: **GNOME 51**
- **Go 1.27**، **Python 3.15**، **GCC 16.2**، **Glibc 2.44**، **LLVM 23**، **RPM 6.1**

Magazine از Podman 6 و Pandas 3 هم اسم برده. این‌ها برای کسی که روی ۴۴ مانده عدد مهاجرت‌اند، نه بنر تبلیغاتی.

اگر می‌خواهید بتا را از آینه بگیرید و آینه عقب است — روز اعلام چند آینه KDE را نداشتند — torrent رسمی معمولاً زودتر پر می‌شود. باگ‌های شناخته‌شده را قبل از گزارش تکراری در تگ common-issues فدورا ۴۵ ببینید. این بتا برای شکستن چیزهاست؛ GA هنوز دو تاریخ در اکتبر دارد.

</div>
