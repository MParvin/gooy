---
title: "تیم Go تخصیص حافظه تخصصی‌شده بر اساس اندازه در Go ۱٫۲۷ را تشریح کرد"
date: 2026-09-17T06:00:00+03:30
draft: false
slug: "go-1-27-size-specialized-malloc"
tags: ["golang", "runtime", "malloc", "performance", "go-1-27"]
categories: ["Programming", "Open-source"]
description: "۱۶ سپتامبر در بلاگ Go: mallocgc تخصصی برای تخصیص زیر ۸۰ بایت؛ تا ۲۰–۳۰٪ سریع‌تر روی alloc کوچک، حدود ۱٪ روی برنامهٔ alloc-سنگین. Escape: GOEXPERIMENT=nosizespecializedmalloc. از ۱٫۲۶ به‌خاطر I-cache عقب افتاد."
image: "/images/go-1-27-size-specialized-malloc.png"
---

<div dir="rtl">

بیشتر object کوچکی که از heap می‌آید — interface، string، slice header — یکی از size classهای زیر ۸۰ بایت است. runtime برای همهٔ آن‌ها تقریباً همان `mallocgc` را صدا می‌زد؛ بعد span class را حساب می‌کرد (`sizeClass<<1 | noPointers`) و از لیست آزاد همان اندازه برمی‌داشت.

۱۶ سپتامبر ۲۰۲۶ Michael Matloob در [Size-Specialized Memory Allocation](https://go.dev/blog/size-specialized-allocations) نوشت Go **۱٫۲۷** برای تخصیص **کمتر از ۸۰ بایت** تابع تخصصی می‌سازد. تخصیص‌های کوچک تا **۲۰–۳۰٪** سریع‌تر؛ برنامهٔ alloc-سنگین حدود **۱٪** کلی. همان روز در [یادداشت Go 1.27](https://go.dev/blog/go1.27) هم آمده.

ایده ساده است: اگر کامپایلر اندازه و بودن/نبودن pointer را بداند، مستقیم `mallocgcSmallNoScanSC3` را صدا می‌زند نه `newobject`. آن تابع فرض‌های ثابت دارد — مثلاً size class 3 یعنی ۱۷–۲۴ بایت بدون pointer — پس span class را حساب نمی‌کند، `memclr` ثابت را به دستورالعمل inline تبدیل می‌کند، و حالت نادر (GC فعال، فلگ دیباگ) را به مسیر آهسته می‌فرستد. تولید این نسخه‌ها با inliner روی AST است تا دست‌نویس‌ها از هم نپاشند.

## چرا همین ۸۰ بایت، و چرا نه در ۱٫۲۶

هر تابع تخصصی باینری را بزرگ می‌کند و **instruction cache** را شلوغ. `mallocgc` واحد معمولاً گرم در icache است؛ ده‌ها variant اگر miss شوند، سود صفر می‌شود و کد کاربر را هم از کش بیرون می‌کنند. بنچمارک روی قطع size class نشان داد شیرینی روی **۸۰ بایت** است (class 1 تا 7). بالای آن، صفر کردن حافظه بر بقیهٔ کار غالب است.

قرار بود در **۱٫۲۶** بیاید؛ یک ریلیز عقب افتاد تا کد اضافه کوچک شود و اثر icache کمتر شود. اگر کامپایلر اندازه را نداند — slice با طول دینامیک — هنوز `mallocgc` عمومی است و بعد به specialized می‌پرد؛ پس specialized باید آن‌قدر سریع باشد که هزینهٔ فراخوانی پویا را بپوشاند.

برای گرفتن آن، برنامه را با **Go 1.27** بسازید. برای خاموش کردن: `GOEXPERIMENT=nosizespecializedmalloc`. اگر مجبور شدید این فلگ را برای رگرسیون بگذارید، از شما می‌خواهند issue بسازید. راهنمای جدا برای GC هنوز همان [Garbage Collector Optimization Guide](https://go.dev/doc/gc-guide) است؛ این تغییر را در کد اپ نمی‌بینید، فقط در زمان allocهای ۱۶ و ۲۴ بایتی که از همه پرتکرارترند.

</div>
