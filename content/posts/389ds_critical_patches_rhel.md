---
title: "پچ بحرانی 389 Directory Server روی خانواده RHEL؛ پنجره نگهداری معمولی کافی نیست"
date: 2026-09-15T11:20:00+03:30
draft: false
tags: ["389ds", "ldap", "rhel", "rocky", "oracle", "cve", "security"]
categories: ["Security", "Linux"]
description: "موج ۱۰ سپتامبر روی 389-ds-base در Rocky/RHEL/Oracle رتبه Critical گرفته؛ CVE-2026-18355 و CVE-2026-18453 به compromise دایرکتوری می‌رسند."
image: "/images/389ds-critical-patches.png"
---

<div dir="rtl">

اگر LDAP هویت سازمان را نگه می‌دارد، این هفته را مثل آپدیت معمولی kernel-tools نگذارید ته صف. [جمع‌بندی ۱۰ سپتامبر LinuxCompatible](https://www.linuxcompatible.org/story/linux-security-roundup-critical-patches-hit-389ds-xz-and-valkey-across-major-distributions/) صریح نوشته: Rocky و RHEL برای 389-ds-base رتبه **Critical** داده‌اند، از جمله **CVE-2026-18355** و **CVE-2026-18453** که overflow هیپ و NULL deref پیش از احراز هویت را تا **compromise کامل دایرکتوری** زنجیر می‌کنند. جملهٔ همان راندآپ: اگر LDAP دارید، این یکی برای پنجره نگهداری معمولی صبر نمی‌کند.

## پنج CVE در بسته Oracle

روی **Oracle Linux 9 و 10** بستهٔ `389-ds-base` با شدت Critical آمده و این شناسه‌ها را با هم فهرست کرده:

- CVE-2026-18355
- CVE-2026-18453
- CVE-2026-18922
- CVE-2026-76560
- CVE-2026-78701

همان جدول، نوع ضعف را heap overflow، pre-auth NULL deref، **PLAIN auth bypass** و **SELFDN ACI defeat** نوشته. یعنی فقط crash نیست؛ مسیر دور زدن auth و ACI هم داخل همین موج است.

## errata را با نام صدا کنید

Rocky:

- **RLSA-2026:64791** — `389-ds:1.4`، Critical، Rocky Linux **8** (امنیت + bugfix + enhancement)
- **RLSA-2026:64785** — `389-ds-base`، Critical، Rocky Linux **10**

راندآپ در مقدمه RHEL را هم Critical خوانده. جدول RHSA همان صفحه بیشتر روی kernel و glib2 و Thunderbird است؛ برای 389 روی Red Hat، errata رسمی کانال خودتان را ملاک بگیرید، نه فرض این‌که «RHEL همیشه یک روز بعد Rocky است».

دایرکتوری پچ‌نشده یعنی احراز هویت مرکزی، ACI، و غالباً حساب سرویس همه‌چیزِ اطراف. بعد از ارتقا، replication و pluginهای سفارشی را یک‌بار smoke-test کنید؛ Critical بودن این بسته از آن جنس است که reboot یا restart دیمون `dirsrv` را نباید به «بعداً» سپرد.

</div>
