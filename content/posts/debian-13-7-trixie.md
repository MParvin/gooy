---
title: "دبیان ۱۳٫۷ «Trixie»: ۱۰۷ به‌روزرسانی امنیتی و ۱۰۶ رفع باگ"
date: 2026-09-16T12:20:00+03:30
draft: false
slug: "debian-13-7-trixie"
tags: ["debian", "trixie", "linux", "security", "stable"]
categories: ["Linux"]
description: "نقطه‌ریلیز ۱۲ سپتامبر ۲۰۲۶ برای Debian 13؛ major تازه نیست. رسانهٔ نصب نو، اصلاح امنیتی و باگ جدی. پوشش: ۱۰۷ بستهٔ امنیتی و ۱۰۶ اصلاح متفرقه."
image: "/images/debian-13-7-trixie.png"
---

<div dir="rtl">

۱۲ سپتامبر ۲۰۲۶ پروژهٔ دبیان [هفتمین به‌روزرسانی پایدار Debian 13 با اسم رمز trixie](https://www.debian.org/News/2026/20260912) را اعلام کرد. جملهٔ اول اعلامیه را باید همان‌طور خواند که نوشته شده: این **نسخهٔ جدید Debian 13 نیست**؛ فقط بعضی بسته‌ها را اصلاح می‌کند. رسانهٔ نصب قدیمی را دور نریزید. بعد از نصب، با آینهٔ به‌روز به همین بازنگری می‌رسید.

کسانی که مدام از `security.debian.org` می‌گیرند «نباید بسته‌های زیادی برای به‌روزرسانی داشته باشند» — بیشتر همان advisoryهایی که جدا منتشر شده بودند داخل نقطه‌ریلیز آمده‌اند. [Phoronix](https://www.phoronix.com/news/Debian-13.7-Released) همان روز آن را «تازه‌ترین رسانهٔ نصب Trixie با باگ‌فیکس و امنیت» خلاصه کرد. Debian 14 به‌عنوان major بعدی، به نوشتهٔ Larabel، نیمهٔ دوم ۲۰۲۷ است.

## عددهایی که تیتر شده‌اند از جدول‌های خود اعلامیه‌اند

اعلامیهٔ رسمی دو جدول دارد، نه یک شمارش در پاراگراف اول. [9to5Linux](https://9to5linux.com/debian-13-7-trixie-released-with-106-bug-fixes-and-107-security-updates) و [Linuxiac](https://linuxiac.com/debian-13-7-released-with-107-security-updates-and-106-bug-fixes/) همان جدول‌ها را **۱۰۷ به‌روزرسانی امنیتی** و **۱۰۶ اصلاح متفرقه** شمرده‌اند. [Help Net Security](https://www.helpnetsecurity.com/2026/09/14/debian-13-7-point-release/) به‌جای ۱۰۷، از **۹۲ advisory امنیتی** حرف می‌زند — چون چند DSA مثل هسته سه بستهٔ `linux` / `linux-signed-amd64` / `linux-signed-arm64` را با یک شماره می‌آورند.

روی جدول Security Updates، هسته چند بار آمده (DSA-6381، 6393، 6405، 6415، 6466، 6477). بقیهٔ نام‌های آشنا: Chromium، NTFS-3G، Roundcube، Samba، PHP 8.4، Postfix، Zip/Unzip، Cockpit، Wireshark، Firefox ESR، Bind9، Exim4، Flatpak، PostgreSQL 17، OpenJDK، WebKitGTK، GIMP، ZFS، OpenSSL. همان فهرستی که Phoronix از روی اعلامیه برداشته.

جدول Miscellaneous Bugfixes همان ۱۰۶تاست. نمونه‌هایی که خود دبیان دلیل‌شان را نوشته:

- **debian-installer**: ABI لینوکس به **6.12.107+deb13** و بازسازی برای نقطه‌ریلیز
- **akonadi-search**: کرش با ورودی خالی
- **cinnamon**: دانلود و به‌روزرسانی spices
- **llvm-toolchain-22**: بستهٔ تازه برای بیلد Chromium
- **glibc**: سرریز/زیرریز بافر (CVE-2026-5928، CVE-2026-5450) و سازگاری با هدرهای Linux 7.0؛ چند بسته فقط به‌خاطر glibc نو rebuild شده‌اند (bash، busybox، docker.io، gnupg2، snapd، zsh و بقیه)
- **audit**: پشتیبانی riscv64
- **openssl** و **samba**: ریلیز پایدار بالادستی تازه
- **qemu**: ریلیز پایدار با فهرست بلند CVE

رسانهٔ نصب تازه «به‌زودی در محل‌های همیشگی» می‌آید — برای کسی که می‌خواهد ماشین نو را بدون صف آپدیت بعد از نصب راه بیندازد. سیستم موجود کافی است package manager را به یکی از [آینه‌های HTTP دبیان](https://www.debian.org/mirror/list) بدهد. ChangeLog کامل: `dists/trixie/ChangeLog` روی deb.debian.org.

</div>
