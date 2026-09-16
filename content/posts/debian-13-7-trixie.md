---
title: "انتشار Debian ۱۳٫۷ (Trixie) با انبوهی از اصلاحات امنیتی"
date: 2026-09-16T12:20:00+03:30
draft: false
slug: "debian-13-7-trixie"
tags: ["debian", "trixie", "linux", "security", "stable"]
categories: ["Linux"]
description: "نقطه‌ریلیز ۱۲ سپتامبر ۲۰۲۶ برای Debian 13 «trixie»: major تازه نیست؛ اصلاح امنیتی و باگ جدی، به‌علاوه رسانهٔ نصب نو."
image: "/images/debian-13-7-trixie.png"
---

<div dir="rtl">

۱۲ سپتامبر ۲۰۲۶ پروژهٔ دبیان در [Updated Debian 13: 13.7 released](https://www.debian.org/News/2026/20260912) هفتمین به‌روزرسانی پایدار Debian 13 با اسم رمز **trixie** را اعلام کرد. جملهٔ اول اعلامیه را باید همان‌طور خواند که نوشته شده: این **نسخهٔ جدید Debian 13 نیست**؛ فقط بعضی بسته‌ها را اصلاح می‌کند. رسانهٔ نصب قدیمی را دور نریزید. بعد از نصب، با آینهٔ به‌روز به همین بازنگری می‌رسید.

کسانی که مدام از `security.debian.org` می‌گیرند «نباید بسته‌های زیادی برای به‌روزرسانی داشته باشند» — بیشتر همان advisoryهایی که جدا منتشر شده بودند داخل نقطه‌ریلیز آمده‌اند. رسانهٔ نصب تازه «به‌زودی در محل‌های همیشگی» می‌آید.

## دو جدول، نه یک major

اعلامیه دو فهرست دارد: Miscellaneous Bugfixes و Security Updates. پوشش جدا همان جدول‌ها را حدود **۱۰۷ به‌روزرسانی امنیتی** و **۱۰۶ اصلاح متفرقه** شمرده؛ Help Net Security به‌جای ۱۰۷ از **۹۲ advisory** حرف می‌زند چون چند DSA مثل هسته سه بستهٔ `linux` / `linux-signed-amd64` / `linux-signed-arm64` را با یک شماره می‌آورند. خود debian.org آن دو عدد را در پاراگراف اول ننوشته.

روی جدول Security Updates هسته چند بار آمده (DSA-6381، 6393، 6405، 6415، 6466، 6477). بقیهٔ نام‌های آشنا از همان صفحه: Chromium، NTFS-3G، Roundcube، Samba، PHP 8.4، Postfix، Zip/Unzip، Cockpit، Wireshark، Firefox ESR، Bind9، Exim4، Flatpak، PostgreSQL 17، OpenJDK، WebKitGTK، GIMP، ZFS، OpenSSL.

نمونه‌هایی که خود دبیان برای bugfix متفرقه دلیل نوشته:

- **debian-installer**: ABI لینوکس به **6.12.107+deb13** و بازسازی برای نقطه‌ریلیز
- **akonadi-search**: کرش با ورودی خالی
- **cinnamon**: دانلود و به‌روزرسانی spices
- **llvm-toolchain-22**: بستهٔ تازه برای بیلد Chromium
- **glibc**: سرریز/زیرریز بافر (CVE-2026-5928، CVE-2026-5450) و سازگاری با هدرهای Linux 7.0؛ چند بسته فقط به‌خاطر glibc نو rebuild شده‌اند
- **audit**: پشتیبانی riscv64
- **openssl** و **samba**: ریلیز پایدار بالادستی تازه
- **qemu**: ریلیز پایدار با فهرست بلند CVE

سیستم موجود کافی است package manager را به یکی از [آینه‌های HTTP دبیان](https://www.debian.org/mirror/list) بدهد. ChangeLog کامل روی `dists/trixie/ChangeLog` است. Debian 14 به‌عنوان major بعدی هنوز در این اعلامیه نیست؛ Phoronix همان روز نیمهٔ دوم ۲۰۲۷ را برایش نوشته.

</div>
