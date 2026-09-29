---
title: "systemd 262: باینری استاتیک PID 1، Intel TDX در vmspawn، و قناری AI"
date: 2026-09-29T10:20:00+03:30
draft: false
slug: "systemd-262-release"
tags: ["systemd", "linux", "tdx", "vmspawn", "tpm", "luo"]
categories: ["Linux", "News"]
description: "ریلیز ۲۲ سپتامبر: PID 1 استاتیک برای کانتینر کوچک، --coco= با TDX، LUOSession=، سخت‌شدن TPM، و canary برای کد بازبینی‌نشدهٔ LLM. پوشش بر اساس Phoronix و نوت GitHub v262."
image: "/images/systemd-262-release.png"
---

<div dir="rtl">

۲۲ سپتامبر ۲۰۲۶ [systemd 262](https://github.com/systemd/systemd/releases/tag/v262) رسید — همان ریلیزی که [Phoronix](https://www.phoronix.com/news/systemd-262) با فهرست بلند ویژگی‌ها پوشش داد. چند محور برای اپراتور و کسی که ایمیج کانتینر یا confidential VM می‌سازد مهم‌تر از بقیه است.

**PID 1 جمع‌وجور.** systemd را می‌توان به‌صورت یک باینری استاتیک لینک‌شده برای PID 1/executor ساخت (`--default-library=static` و `-Dbuild-static=true`)؛ مناسب کانتینرهای خیلی کوچک. مدیر همچنین مجموعهٔ پایه‌ای از unitها را embed می‌کند و اگر از دیسک خوانده نشوند — یا در کانتینر بدون unit نصب‌شده — به همان‌ها برای reboot/shutdown و multi-user تکیه می‌کند.

**محاسبات محرمانه.** `systemd-vmspawn --coco=` قبلاً AMD SEV-SNP داشت؛ الان **Intel TDX** هم اضافه شده. برای SEV-SNP، مسیر تحویل credential به مهمان هم دقیق‌تر شده.

**به‌روزرسانی زنده و TPM.** یونیت‌های سرویس گزینهٔ `LUOSession=` گرفته‌اند تا session مربوط به Live Update Orchestrator بسازند. در زیرسیستم TPM، credentialهای seal‌شده به SRK پین می‌شوند، Endorsement Key پایدار ساخته می‌شود، و enrollment پین می‌تواند با Argon2id سخت شود. `systemd-cryptenroll` ویزارد first-boot گرفته؛ `systemd-firstboot` هم با `systemd.firstboot=headless` نصب بی‌attendant را ساده‌تر می‌کند.

**قناری AI.** 262 یک **AI/LLM canary** برای تشخیص مشارکت کد بازبینی‌نشدهٔ تولیدشده با مدل حمل می‌کند — سیگنال سیاست پروژه، نه ویژگی runtime روزمره.

بقیهٔ فهرست شلوغ است: NUMAPolicy با `preferred-map` / `weighted-interleave`، پشتیبانی coredump از پروتکل socket کرنل 6.17، پیش‌فرض FSCRYPT v2 برای homeهای جدید، و یکپارچگی boot با dm-clone. اگر ایمیج پایه یا hypervisor را دور می‌زنید، نوت کامل GitHub را قبل از bump نسخه بخوانید؛ تغییر سازگاری Meson برای بیلد استاتیک/multicall ممکن است اسکریپت CI را بشکند.

</div>
