---
title: "Rust Coreutils ۰٫۱۲: فیکس اوبونتو برای rm عمیق، install -D و cp -R"
date: 2026-09-17T14:00:00+03:30
draft: false
slug: "rust-coreutils-0-12"
tags: ["uutils", "coreutils", "rust", "ubuntu", "cli"]
categories: ["Linux", "Open-source"]
description: "۱۷ سپتامبر uutils 0.12.0: سازگاری برای اوبونتو. rm دیگر روی درخت خیلی عمیق segfault نمی‌دهد؛ data loss در install -D موازی؛ du ۳۲بیت؛ cp -R. آخرین وابستگی C در expr حذف شد. غیر از GNU 9.12."
image: "/images/rust-coreutils-0-12.png"
---

<div dir="rtl">

پست GNU Coreutils **9.12** روی گوی همان ریلیز پایدار ۱۴ سپتامبر Pádraig Brady است. این یکی پیاده‌سازی **uutils** به Rust است. ۱۷ سپتامبر ۲۰۲۶ تگ [0.12.0](https://github.com/uutils/coreutils/releases/tag/0.12.0) آمد؛ [Phoronix](https://www.phoronix.com/news/Rust-Coreutils-0.12-Released) همان صبح آن را پوشش داد.

جملهٔ خود ریلیز: متمرکز بر «compatibility fixes for our Ubuntu friends». اوبونتو uutils را coreutils پیش‌فرض می‌فرستد. باگ‌هایی که maintainerها اولویت دادند اینجاست، به‌علاوه دنبالهٔ واگرایی‌های کوچک از GNU. «Few of these are glamorous, but they are exactly what breaks a script that has worked for twenty years.»

Phoronix می‌نویسد با این فیکس‌ها مسیر **اوبونتو 26.10** به **۱۰۰٪ Rust coreutils** جلو می‌رود و مسئله‌هایی که 25.10 و 26.04 LTS را اذیت می‌کردند بسته شده‌اند.

## آنچه اوبونتو اول خواست

از بخش Ubuntu Compatibility تگ GitHub:

- data loss در **`install -D` موازی** (#12355)
- **`du` روی معماری ۳۲بیت** (#11848)
- **`ls` و dereference ACL** (#13234)
- برخورد نام در **`cp -R`** (Launchpad **#2167118**)
- **`chmod -R` از روی symlink** (LP **#2167122**)
- **`rm` دیگر روی دایرکتوری خیلی تودرتو segfault نمی‌دهد**

کنارش: گزینه‌هایی که مقدارشان با `-` شروع می‌شود حالا مثل GNU داده است نه فلگ (`paste -d`، `join -t`، `stat --format`، numfmt). `sort -n` روی key اعمال می‌شود نه کل خط.

## آخرین C در expr، و hardening

`expr` وابستگی **onig** را با **fancy-regex** عوض کرد؛ آخرین وابستگی C همین ابزار رفت. اثر جانبی: matching leftmost-longest مثل GNU. روی Windows هم `nice`، `nohup` و `hostid` بیلد می‌شوند.

hardening از همان notes: `ls` شکست `stat()` را پنهان نمی‌کند؛ فایل موقت `sort` با mode **0600**؛ `install` مقصد fd-based را exclusive و 0600 می‌سازد؛ `--preserve-root` در `rm`/`chmod`/`chown`/`chgrp` با `(st_dev, st_ino)` مقایسه می‌شود نه path.

suite گنو: **653 pass / 21 fail / 0 error** در 0.12.0. نسبت خام pass کمی پایین آمده چون ۷ تست تازه و ۸ skip اضافه شده؛ روی تست‌های واقعاً اجرا شده می‌گویند **653/674 (96.9%)** — بهترین نسبت تا اینجا. مقایسه با Coreutils **9.11** است نه 9.12. شکاف عملکرد معنادار با GNU از این ریلیز **باگ** حساب می‌شود نه wishlist. ۱۹۱ PR، ۱۶ contributor تازه.

</div>
