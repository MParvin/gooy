---
title: "Ruby ۴٫۰٫۷ ریلیز شد؛ باگ‌فیکس روتین، ۴٫۰٫۸ برای نوامبر"
date: 2026-09-17T13:40:00+03:30
draft: false
slug: "ruby-4-0-7-released"
tags: ["ruby", "mri", "bugfix", "yjit", "language"]
categories: ["Programming"]
description: "۱۵ سپتامبر k0kubun: Ruby 4.0.7 به‌روزرسانی روتین باگ‌فیکس. برنامه: پایدار فعلی هر دو ماه؛ 4.0.8 در نوامبر مگر تغییر فوری برای کاربر."
image: "/images/ruby-4-0-7.png"
---

<div dir="rtl">

۱۵ سپتامبر ۲۰۲۶ Takashi Kokubun (**k0kubun**) در [ruby-lang.org](https://www.ruby-lang.org/en/news/2026/09/15/ruby-4-0-7-released/) نوشت **Ruby 4.0.7** منتشر شده. جملهٔ اول را همان‌طور بخوانید که نوشته: «This is a routine update that includes bugfixes.» جزئیات را به [GitHub releases](https://github.com/ruby/ruby/releases/tag/v4.0.7) حواله کرده، نه به یک مقالهٔ ویژگی.

برنامهٔ انتشار خط پایدار فعلی (حالا 4.0): حدود **هر دو ماه** یک نقطه. **4.0.8 برای نوامبر** است. اگر تغییری برسد که «significantly affects users»، ممکن است زودتر بیاید.

tarballها روی `cache.ruby-lang.org/pub/ruby/4.0/` با سه شکل `.tar.gz` / `.tar.xz` / `.zip`. برای gz: اندازه **23937964**، SHA256 `911ace20f90d068ca0e4dda6d0e4f0f81e52e52f2dd4f4004c721e253412e82d`. xz و zip هم در همان صفحه hash دارند — از mirror بدون checksum نصب نکنید.

## باگ‌هایی که در تگ v4.0.7 آمده‌اند

لیست GitHub را `tool/gen-github-release.rb` می‌سازد و ممکن است بعضی commit جا بیفتد؛ همان‌جا این قید را نوشته. نمونه‌هایی که در تگ هستند، نه اختراع:

- **Bug #22217** — segfault وقتی اجرا با `Coverage.start` و ruby/debug resume می‌شود
- **Bug #22200** — `ObjectSpace._id2ref` ممکن است شیء دیگری برگرداند (ورودی کهنه در `id2ref_tbl` برای object با generic fields)
- **Bug #22237** — `GC.auto_compact` رشته را خراب می‌کند یا از `String#tr` با dup/gsub segfault می‌دهد
- **Bug #22198** — heap overflow در `Kernel#system` روی win32
- **Bug #22242** — SEGV در method dispatch روی 4.0.6 که در CI ریلز دیده شد
- **Bug #22292** — YJIT/ZJIT: کرش accessor روی Struct وقتی instance variable به Structی اضافه شود که دقیقاً بزرگ‌ترین slot GC را پر کرده
- **Bug #22224** — YJIT: `rb_yjit_invalidate_ep_is_bp` قفل VM را روی هر Proc می‌گیرد و throughput چند-Ractor تا حدود ۱۵۰× می‌افتد
- **Bug #22220** — پسرفت وقتی `aws-sdk-ec2` در 4.0.6 require می‌شد
- ERB به **6.0.7** bump شده

اگر 4.0.6 را به‌خاطر segfault ریلز، `_id2ref` یا YJIT چند-Ractor نگه داشته‌اید، 4.0.7 همان نقطه‌ریلیز است. ویژگی زبان تازه در این تگ وعده نشده؛ نوامبر را برای 4.0.8 روی تقویم بگذارید مگر advisory جدا بیاید.

</div>
