---
title: "Cloudflare: نشت بلوک دیسک باقی‌مانده بین tenantها در Containers و Sandboxes"
date: 2026-09-29T09:20:00+03:30
draft: false
slug: "cloudflare-containers-cross-tenant-disk"
tags: ["cloudflare", "containers", "sandboxes", "dm-thin", "multi-tenant", "disclosure"]
categories: ["Security", "Cloud"]
description: "افشای ۲۴ سپتامبر: با skip_block_zeroing در dm-thin، نوشتن ۴ کیلوبایتی می‌توانست ۶۰ کیلوبایت باقی‌مانده از کانتینر قبلی را لو بدهد. فیکس سمت Cloudflare؛ اقدام مشتری لازم نیست."
image: "/images/cloudflare-containers-cross-tenant-disk.png"
---

<div dir="rtl">

۲۴ سپتامبر ۲۰۲۶ کلادفلر در [پست رسمی](https://blog.cloudflare.com/containers-cross-tenant-vulnerability/) توضیح داد چطور یک باگ در لایه‌سازی دیسک Containers — و Sandboxes که روی همان ساخته شده — مرز tenant را می‌شکست. گزارش مسئولانه ۴ سپتامبر از Oren Yomtov و تیم Accomplish آمده بود. کلادفلر می‌گوید شواهدی از compromise دادهٔ مشتری توسط بازیگر مخرب ندیده؛ فعالیتی که با تکنیک گزارش‌شده جور درمی‌آمد مال خود پژوهشگر و اعتبارسنجی داخلی بوده.

هر کانتینر داخل Firecracker VM می‌نشیند و root دیسک writable را به‌صورت `/dev/vdc` می‌بیند. تخصیص از **device mapper thin provisioning (dm-thin)** با بلوک ۶۴ KiB است. وقتی volume یک کانتینر حذف می‌شد، بلوک‌های فیزیکی به استخر مشترک چندحسابی برمی‌گشتند. گزینهٔ `skip_block_zeroing` باعث می‌شد بلوک تازه‌تخصیص‌یافته قبل از تحویل صفر نشود.

خواندن ناحیهٔ unmapped صفر برمی‌گرداند و بلوک فیزیکی نمی‌گیرد. PoC نواحی ۶۴ KiB هم‌تراز فضای آزاد ext4 را پیدا می‌کرد، یک بلوک **۴ KiB** می‌نوشت تا dm-thin یک بلوک ۶۴ KiB از استخر reuse کند، و بعد بقیهٔ **۶۰ KiB** را می‌خواند — جایی که دادهٔ tenant قبلی می‌توانست مانده باشد. پژوهشگرها در چند placement حتی directory block، صفحهٔ دیتابیس و SQLite کامل ساختاری دیدند؛ ولی مواد تحویلی به کلادفلر محتوای خام third-party نداشت و دادهٔ بازیابی‌شده بعداً امن پاک شد. هدف‌گیری یک مشتری خاص ممکن نبود؛ بستگی به placement و اینکه کدام بلوک آزاد دوباره تخصیص می‌شد داشت.

## چه کردند

اول `skip_block_zeroing` را از poolها برداشتند تا تخصیص جدید صفر شود. این برای mappingهایی که از قبل داخل دیسک‌های در حال اجرا و snapshotهای کش‌شدهٔ لایه‌های OCI بودند کافی نبود؛ پس دیسک‌های در حال اجرا را بازنشسته کردند، کش ایمیج میزبان‌ها را خالی کردند، و cleanup را تا ۱۹ سپتامبر روی ناوگان تمام کردند. پژوهشگرها تأیید کردند PoC دیگر کار نمی‌کند.

برای مشتری Cloudflare Containers / Sandboxes اقدام پیکربندی لازم نیست. درس معماری روشن است: thin pool چندمستأجری بدون صفر کردن تخصیص، حتی بالای Firecracker، می‌تواند residual disk را از مرز tenant رد کند.

</div>
