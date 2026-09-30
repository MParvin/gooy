---
title: "Check Point زیر آتش فعال: RCE در VPN و path traversal در Management روی KEV"
date: 2026-09-30T14:40:00+03:30
draft: false
slug: "checkpoint-vpn-mgmt-kev-active"
tags: ["checkpoint", "vpn", "cve-2026-85102", "cve-2026-93616", "kev", "rce", "hotfix"]
categories: ["Security"]
description: "CVE-2026-85102 روی Gateway/Spark و CVE-2026-93616 روی Management هر دو CVSS ۹٫۸ و هر دو در KEV؛ exploitation فعال از حدود ۱۲ سپتامبر روی Spark. Jumbo hotfix فوری."
image: "/images/checkpoint-vpn-mgmt-kev-active.png"
---

<div dir="rtl">

۲۲ سپتامبر ۲۰۲۶ چک‌پوینت در [advisory رسمی](https://blog.checkpoint.com/security/security-advisory-action-required-active-exploitation-of-cve-2026-85102-and-a-management-pre-authentication-vulnerability-cve-2026-93616/) دو مسیر جدا را یک‌جا «Action Required» کرد — و همان روز CISA هر دو را در [آلرت KEV](https://www.cisa.gov/news-events/alerts/2026/09/22/cisa-adds-four-known-exploited-vulnerabilities-catalog) گذاشت. این پست همان فوریت ترکیبی است: Gateway و Management، هر دو pre-auth، هر دو **CVSS ۹٫۸**، هر دو زیر سوءاستفاده.

**CVE-2026-85102** اعتبارسنجی نادرست گواهی VPN روی **Security Gateway / Spark** است؛ RCE پیش از احراز هویت. فیکس از **۹ سپتامبر** در دسترس بوده؛ exploitation از حدود **۱۲ سپتامبر** علیه Spark دیده شده. جزئیات عملیاتی در [sk1000117](https://support.checkpoint.com/results/sk/sk1000117).

**CVE-2026-93616** path traversal پیش‌احراز هویت روی **Security Management** است: امکان بارگذاری اسکریپت یا کلاس Java از مسیر دلخواه. وندور آن را zero-day با exploitation محدود توصیف کرده. مسیر فیکس: [sk1000171](https://support.checkpoint.com/results/sk/sk1000171).

اگر فقط یکی از دو SK را زده‌اید، نصف کار مانده. Jumbo hotfix / Security Hotfix مربوط به هر محصول را جدا اعمال کنید؛ LivePatchهایی که فقط یکی از باگ‌ها را می‌پوشانند را با «همه‌چیز اوکی است» اشتباه نگیرید. دسترسی مدیریت را تا ارتقا به IPهای مورد اعتماد قفل کنید و لاگ‌های exploitation اشاره‌شده در SK را برای همان بازهٔ سپتامبر مرور کنید. KEV اینجا یعنی تأخیر آگاهانه است، نه احتیاط.

</div>
