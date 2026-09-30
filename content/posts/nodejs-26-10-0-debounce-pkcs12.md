---
title: "Node.js 26.10.0: debounce/throttle بومی و crypto.parsePKCS12"
date: 2026-09-30T15:00:00+03:30
draft: false
slug: "nodejs-26-10-0-debounce-pkcs12"
tags: ["nodejs", "javascript", "crypto", "pkcs12", "perf_hooks", "ffi"]
categories: ["Programming"]
description: "Current ۲۲ سپتامبر: util.debounce و util.throttle، پارس DER PKCS#12، fs.openAsBlobSync، SlidingWindowHistogram در perf_hooks، بارگذاری ffi از VFS، و ارسال BoundSocket بین thread/process."
image: "/images/nodejs-26-10-0-debounce-pkcs12.png"
---

<div dir="rtl">

هر تیم Node حداقل یک‌بار `lodash.debounce` یا یک helper دست‌نویس برای throttle رویدادها کشیده است. در **Node.js Current 26.10.0** — اعلام‌شده در [۲۲ سپتامبر ۲۰۲۶](https://nodejs.org/en/blog/release/v26.10.0) — همان کار وارد **`util.debounce`** و **`util.throttle`** شد. برای I/O و تایمینگ سمت سرور، وابستگی کمتر و رفتار یکنواخت‌تر از کپی‌های پراکنده در کدبیس.

کنار آن، **`crypto.parsePKCS12()`** برای خواندن DER مربوط به PKCS#12 / `.p12` / `.pfx` آمده است؛ مسیری که قبلاً اغلب به binding یا ابزار خارجی ختم می‌شد. اگر گواهی و کلید را از PFX سازمانی می‌خوانید، حالا API بومی همان لایهٔ `crypto` است.

بقیهٔ semver-minorهای برجستهٔ همین ریلیز:

- **`fs.openAsBlobSync`** برای مسیر sync به‌سمت Blob
- **`SlidingWindowHistogram`** و **`qrde`** در **`perf_hooks`**
- بارگذاری **ffi** از VFS ماونت‌شده
- امکان فرستادن **`net.BoundSocket`** بین threadها / child processها

Current است، نه لزوماً خط LTS شما. برای آزمایش APIهای جدید و پروفایل عملکرد، 26.10.0 همان نقطه‌ای است که debounce/throttle و PKCS#12 را بدون پکیج اضافه اندازه بگیرید؛ برای production روی LTS، منتظر backport یا برنامهٔ ارتقای شاخه بمانید مگر اینکه عمداً Current را می‌رانید.

</div>
