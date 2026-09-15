---
title: "Julia 1.13: precompile حدود ۳۰٪ سریع‌تر و GC کامل دیگر تصویر را راه نمی‌رود"
date: 2026-09-15T15:35:00+03:30
draft: false
tags: ["julia", "release", "gc", "pkg", "opensource"]
categories: ["Programming", "Open-source"]
description: "ریلیز ۱۰ سپتامبر ۲۰۲۶ جولیا ۱.۱۳: کاهش latency، RapidhashNano، GC بدون پیمایش objectهای image، هایلایت REPL، zstd در Pkg، JuliaC/trim و GUI جولیاآپ."
image: "/images/julia-1-13-ttfx-gc.png"
---

<div dir="rtl">

۱۰ سپتامبر ۲۰۲۶ نسخه **۱.۱۳** جولیا آمد. پست [Julia 1.13 Highlights](https://julialang.org/blog/2026/09/julia-1.13-highlights/index.html) به‌جای فهرست ویژگی‌های تزئینی، روی همان چیزی رفته که کاربر روزمره حس می‌کند: زمان تا اولین نتیجه.

نسبت به ۱.۱۲، precompile پکیج حدود **۳۰٪** کمتر طول می‌کشد. استارت‌آپ هم حدود **۲۰٪** سریع‌تر است؛ در بنچمارک `hyperfine` خودشان، `julia -e ''` از حدود ۶۹ms به حدود ۵۷ms رسیده. TTFX از سه هزینه ساخته می‌شود: precompile، load، اجرا. با workflowهای واقعی Julia-TTFX-Snippets این‌ها را سیستماتیک اندازه می‌گیرند و از ۷ سپتامبر حتی CI مربوط به TTFX روی master روشن شده.

## GC دیگر مالیات sysimage را نمی‌پردازد

هر نشست جولیا پر است از objectهایی که از sysimage و package image آمده‌اند: جدول متد، نوع، کد کامپایل‌شده. این‌ها آزاد نمی‌شوند، ولی تا ۱.۱۲ یک full GC همه را mark می‌کرد. در ۱.۱۳ objectهای image از ابتدا marked بارگذاری می‌شوند و فاز mark واردشان نمی‌شود. mutation نادر (مثلاً اضافه شدن متد) جدا track می‌شود. نتیجه: هزینه collection با heap برنامه شما مقیاس می‌شود، نه با حجم کدی که load کرده‌اید. در نشست خالی، `GC.gc()` از حدود ۳۵ms به حدود ۰٫۵ms رسیده؛ با `GLMakie` از ۱۸۷ms به ۶۸ms.

hash پیش‌فرض عوض شده: الگوریتم بایت **RapidhashNano** است، streaming است و دیگر `length` را جلوتر نمی‌خواهد. غیررمزنگاری باقی مانده؛ seed پیش‌فرض هم عوض شده. اگر `hash` سفارشی می‌نویسید، seed را از caller بگیرید.

REPL دیگر برای رنگ به OhMyREPL اجباری نیست: syntax highlighting داخلی آمده، و جستجوی تاریخچه (Ctrl-R) شبیه **fzf** شده — fuzzy، چندانتخابی، با نمایش mode. روی ویندوز بالاخره bracketed paste هم هست.

Pkg به‌صورت پیش‌فرض به‌جای gzip از **zstd** می‌خواهد؛ روی مجموعهٔ Plots/Makie/ModelingToolkit هم حجم دانلود کمتر شده هم decompress سریع‌تر. `Pkg.test` دیگر پیش‌فرض `--check-bounds=yes` نمی‌گذارد تا cache توسعه دوباره کامپایل نشود. اسکریپت juliac تبدیل به بستهٔ **JuliaC** شده و trim قوی‌تر است. و **Juliaup** از نسخه ۱.۲۲ به بعد GUI دارد: `juliaup gui`.

اگر ۱.۱۲ را به‌خاطر latency نگه داشته‌اید، ۱.۱۳ همان ریلیزی است که این شکایت را عددی جواب می‌دهد.

</div>
