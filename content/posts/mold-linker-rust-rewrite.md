---
title: "لینکر Mold به Rust بازنویسی می‌شود؛ هدف لینکر پیش‌فرض لینوکس"
date: 2026-09-16T09:00:00+03:30
draft: false
slug: "mold-linker-rust-rewrite"
tags: ["mold", "rust", "linker", "llvm", "linux"]
categories: ["Programming", "Open-source"]
description: "اعلام ۱۱ سپتامبر ۲۰۲۶ در یادداشت mold 2.42.1: بازنویسی از C++ به Rust به‌عنوان ۳٫۰، و هدف اصلی ۳٫x شدن /usr/bin/ld توزیع‌ها با تکمیل linker script برای کرنل و firmware."
image: "/images/mold-linker-rust-rewrite.png"
---

<div dir="rtl">

۱۱ سپتامبر ۲۰۲۶ Rui Ueyama در [یادداشت mold 2.42.1](https://github.com/rui314/mold/releases/tag/v2.42.1) بیشتر از فهرست باگ، نقشهٔ ۳٫۰ را نوشت. [Phoronix](https://www.phoronix.com/news/Mold-Linker-In-Rust-Coming) همان صبح تیتر را گذاشت: لینکر سریع در Rust بازنویسی می‌شود و می‌خواهد لینکر پیش‌فرض لینوکس شود.

۲٫۴۲٫۱ هنوز C++ است و چند فیکس واقعی دارد (LTO، unwind تهی، `--emit-relocs`، overflow relocation در برنامهٔ خیلی بزرگ). جملهٔ مهم‌تر: «likely to be the last C++ version of the linker unless we need to make another patch release.» نسخهٔ Rust به‌عنوان **mold 3.0** می‌آید.

## چرا Rust، و چرا حالا

Ueyama می‌نویسد لینکر ممکن است دهه‌ها بماند؛ mold هنوز در ابتدای آن عمر است، پس بازنویسی الان منطقی است. ۲۰۲۰ که کار را شروع کرد Rust هنوز تازه بود؛ ۲۰۲۶ برای نرم‌افزار سیستمی انتخاب عملی است: سرعت هم‌تراز C++، تضمین ایمنی حافظه. ریسک بازنویسی برنامهٔ جاافتاده را انکار نمی‌کند. AI-assisted coding بازنویسی بزرگ را عملی‌تر کرده، ریسک را حذف نکرده. هدف از دید کاربر: ۳٫۰ «همان‌طور که قبل کار می‌کرد» کار کند، فقط پیاده‌سازی عوض شود. Wild از قبل لینکر سریع Rust است؛ mold دارد به همان زبان می‌رود، نه این‌که تازه وارد بازی سرعت شود.

## مسئولیت نویسندهٔ lld و mold

نقل قولی که Phoronix هم برجسته کرده، از خود یادداشت ۲٫۴۲٫۱ است:

در بیست سال گذشته gold و lld و mold آمده‌اند، ولی `/usr/bin/ld` اکثر توزیع‌ها هنوز **GNU ld** است. لینکی که mold در چند صد میلی‌ثانیه تمام می‌کند، با لینکر پیش‌فرض ممکن است چند ثانیه، ده‌ها ثانیه یا دقیقه طول بکشد.

«As the original author of both lld and mold, I think I bear some responsibility for this situation. I have spent a great deal of effort making linkers faster, but not enough effort on the compatibility work needed to make a fast linker suitable as a drop-in replacement for the system linker.»

هدف اصلی سری ۳٫x: مناسب شدن برای این‌که توزیع mold را به‌عنوان `/usr/bin/ld` بردارد. قدم اول: ویژگی‌های جاافتادهٔ **linker script** تا علاوه بر userspace، **کرنل و firmware** هم لینک شوند. بعد تست سازگاری گسترده و کار نزدیک با maintainer توزیع. «one of our highest priorities for mold 3.x.»

بدون linker script کامل، توزیع نمی‌تواند GNU ld را از سیستم بردارد — همان شکافی که سال‌ها mold را در نقش «سریع برای برنامهٔ معمولی» نگه داشت نه «لینکر سیستم».

## Incremental linking؛ نه اولویت اول، نه ممنوع

Ueyama می‌گوید حرف قبلی‌اش ممکن است این‌طور فهمیده شده باشد که مخالف incremental linking است. مخالف نیست. اول می‌خواست full link را آن‌قدر سریع کند که به کپی فایل نزدیک شود. می‌گوید امروز mold باینری چندگیگابایتی را در یکی‌دو ثانیه لینک می‌کند و در بسیاری موارد full link تقریباً به اندازهٔ کپی همان حجم سریع است؛ گلوگاه edit-build-test ممکن است دیگر لینکر نباشد. اگر راه ساده‌ای برای incremental پیدا کنند، اضافه می‌کنند؛ طراحی‌هایی در حال بررسی است که سادگی mold را خراب نکند.

۳٫۰ اعلام است، نه ریلیز. بنچمارک‌های ۴٫۹× در برابر lld مربوط به mold ۲٫x سی‌پلاس‌پلاس‌اند؛ نسخهٔ Rust هنوز با آن‌ها سنجیده نشده. اگر ۲٫۴۲٫۱ را برای بیلد روزانه می‌خواهید، از [GitHub Releases](https://github.com/rui314/mold/releases/tag/v2.42.1) همان C++ را بگیرید. اگر منتظر «لینکر پیش‌فرض توزیع» هستید، آن کار ۳٫x است و هنوز انجام نشده.

</div>
