---
title: "GNU Coreutils ۹٫۱۲: رفع باگ -R همزمان، cut تا ۴× و uniq تا ۲٫۵× سریع‌تر"
date: 2026-09-16T07:40:00+03:30
draft: false
slug: "gnu-coreutils-9-12"
tags: ["coreutils", "gnu", "linux", "cli", "performance"]
categories: ["Linux", "Open-source"]
description: "ریلیز پایدار ۱۴ سپتامبر ۲۰۲۶: chcon/chmod/ls با -R دیگر با حذف موازی فایل نمی‌شکنند؛ cut -w تا ۴×، uniq -c تا ۲٫۵×، uname -A و FailFS/NULLFS."
image: "/images/gnu-coreutils-9-12.png"
---

<div dir="rtl">

Pádraig Brady ۱۴ سپتامبر ۲۰۲۶ **coreutils 9.12** را به‌عنوان ریلیز پایدار اعلام کرد: ۲۸۸ commit از ۱۶ نفر در ۲۱ هفته بعد از ۹٫۱۱. tarball روی [ftp.gnu.org/gnu/coreutils](https://ftp.gnu.org/gnu/coreutils/) است (`coreutils-9.12.tar.xz`). [Phoronix](https://www.phoronix.com/news/GNU-Coreutils-9.12) همان روز خلاصه کرد؛ NEWS کامل در اعلام Savannah آمده.

قدیمی‌ترین باگ این ریلیز همانی است که NEWS با جملهٔ آشنای «present in "the beginning"» برچسب زده.

## `-R` و فایلی که همان لحظه پاک می‌شود

`chcon`، `chgrp`، `chmod`، `chown`، `du`، `ls` وقتی سلسله‌مراتب را با `-R` می‌پیمایند، دیگر فقط به‌خاطر این‌که فایلی موازی حذف می‌شود شکست نمی‌خورند. این دقیقاً الگوی `find | xargs rm` کنار `chmod -R` یا `du -s` روی درختی است که build یا cache همان‌موقع جمع می‌شود. سال‌ها این ابزارها در آن مسابقه errno می‌دادند. ۹٫۱۲ می‌گوید دیگر «صرفاً به‌خاطر حذف موازی» نباید fail شوند.

بقیهٔ bugfixها کمتر براق‌اند ولی واقعی‌اند: `cp`/`install`/`mv` اگر `--reflink=auto` با EDQUOT/ENOMEM/ENOSPC بمیرد — مثلاً روی XFS که metadata یک allocation group تمام شود — به کپی معمولی برمی‌گردند (باگ از 9.2). `mv` وقتی کپی xattr با ENOTSUP شکست بخورد هشدار می‌دهد (از 7.3). `factor` یک buffer over-read (CWE-126) را برای بعضی مقدارها بسته. `tee` حلقهٔ بی‌نهایت و برخورد غلط با short write را که ۹٫۱۱ آورده بود درست کرده. `unexpand -t` overflow هیپ، `uniq -w` overrun بافر در locale چندبایتی.

## throughput جایی که روزانه صدا می‌شود

- **`cut -w`**: تا حدود **۴×** throughput بیشتر روی ورودی معمولی، وقتی ابتدای خط را در locale چندبایتی برمی‌دارید
- **`uniq -c`**: تا حدود **۲٫۵×** روی سیستم‌هایی که stdio قفل‌نشده دارند
- **`sort`**: حافظه و موازی‌سازی را روی ورودی با اندازهٔ نامعلوم مثل pipe بهتر مصرف می‌کند

سه عددی که Phoronix هم تیتر کرده، همان سه بهبود NEWSاند — نه بنچمارک جدا.

## فایل‌سیستم تازه و `uname` با برچسب

`stat` و `tail` نوع **FailFS** و **NULLFS** را می‌شناسند: `stat -f -c%T` نوع را گزارش می‌کند و `tail -f` برایشان inotify می‌گذارد. `uname` گزینهٔ **`-A` / `--all-labeled`** گرفته: همهٔ خروجی برچسب می‌خورد، هر مورد یک خط.

`env --env0-from=FILE` محیط را از ورودی NUL می‌خواند؛ با `-i` round-trip دقیق، حتی ورودی تکراری یا غیرمعیار. `env` و `printenv` متغیر چاپ‌شده را با `QUOTING_STYLE` (پیش‌فرض shell-escape) نقل می‌کنند تا خروجی به ترمینال دادهٔ خام نپاشد. `stat` هم نقل قول شل را وقتی لازم است اعمال می‌کند؛ `%Qn` برای وقتی نقل می‌خواهید، `%n` برای وقتی نمی‌خواهید.

اگر ۹٫۱۱ را به‌خاطر `tee` یا `cut` چندبایتی نگه داشته‌اید، ۹٫۱۲ همان پچ پایدار است. امضا را با کلید Pádraig Brady (`DF6FD971306037D9`) از همان ftp چک کنید.

</div>
