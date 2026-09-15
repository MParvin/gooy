---
title: "RCE در Valkey و Redis: rebase به ۸.۰.۱۰ و ۸.۰.۱۱ روی توزیع‌های اصلی"
date: 2026-09-15T11:40:00+03:30
draft: false
tags: ["valkey", "redis", "rce", "cve", "almalinux", "oracle", "rocky"]
categories: ["Security", "Linux"]
description: "موج ۱۰ سپتامبر Valkey را روی Alma/Oracle/Rocky به ۸.۰.۱۰ (و OL10 به ۸.۰.۱۱) رساند؛ CVE-2026-66373 در RESTORE و چند بردار RCE دیگر بسته شده‌اند."
image: "/images/valkey-redis-rce-fixes.png"
---

<div dir="rtl">

کش و data-plane معمولاً «بعد از LDAP و firewall» پچ می‌شوند. این موج خلاف آن عادت است. همان [راندآپ ۱۰ سپتامبر LinuxCompatible](https://www.linuxcompatible.org/story/linux-security-roundup-critical-patches-hit-389ds-xz-and-valkey-across-major-distributions/) Redis و Valkey را «بازیگر تکراری RCE» خوانده.

بردارهایی که اسم برده:

- **CVE-2026-66373** — RCE از مسیر payload **RESTORE**
- **CVE-2026-81934** — use-after-free روی pending-data در **TLS**
- **CVE-2026-63639** و **CVE-2026-56684** — بردارهای RCE اضافی در بستهٔ Valkey

اگر نمونه به شبکهٔ داخلی یا بدتر به اینترنت وصل است و دستور RESTORE یا TLS ترمینیشن روی خود پروسه است، این‌ها باگ «فقط local» نیستند.

## کدام نسخه روی کدام distro آمده

طبق جدول‌های همان راندآپ:

- **AlmaLinux 9:** `valkey` با شدت Important، rebase به **۸٫۰٫۱۰**، فیکس CVE-2026-66373 / 63639 / 56684. کانال `redis` روی Alma 9 جداگانه CVE-2026-66373 و CVE-2026-81934 را Important گرفته.
- **Oracle Linux 9:** `valkey` rebase به **۸٫۰٫۱۰** (CVE-2026-56684، 63639، 66373). ماژول `redis:7` rebase به **۷٫۲٫۱۶** با CVE-2026-66373، CVE-2026-72568، CVE-2026-81934.
- **Oracle Linux 10:** `valkey` rebase به **۸٫۰٫۱۱** با همان سه CVE.
- **Rocky Linux 10:** **RLSA-2026:64796** برای `valkey` (امنیت + bugfix + enhancement). Rocky 8 و 9 به‌ترتیب **RLSA-2026:64823** (`redis:6`) و **RLSA-2026:64824** (`redis`) را Important گرفته‌اند.

Fedora 43 در همان موج `valkey 8.1.10-1` دارد، با فیکس‌هایی از جنس CLIENT KILL روی RDMA و ACL؛ آن را با rebase ۸٫۰٫۱۰ خانواده RHEL قاطی نکنید.

اپراتور کش: نسخهٔ فعلی را با `valkey-server --version` یا بستهٔ RPM ببینید، بعد dnf مربوط به کانال. بعد از ارتقا، replication و persist را چک کنید؛ RCE روی data-plane یعنی اگر نمونه از قبل در معرض بوده، پچ به‌تنهایی تاریخچه را پاک نمی‌کند.

</div>
