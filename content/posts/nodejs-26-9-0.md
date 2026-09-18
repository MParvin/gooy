---
title: "Node.js ۲۶٫۹٫۰: ffi پیش‌فرض روشن، Web Workers آزمایشی و node:bench"
date: 2026-09-16T22:40:00+03:30
draft: false
slug: "nodejs-26-9-0"
tags: ["nodejs", "ffi", "web-workers", "dtls", "crypto"]
categories: ["Programming"]
description: "۱۶ سپتامبر: Node.js 26.9.0 (Current). ماژول ffi پیش‌فرض روشن؛ Web Workers آزمایشی؛ node:bench؛ DTLS آزمایشی؛ MAC عام؛ کشف cipher/hash از OpenSSL provider؛ یکپارچگی VFS با loaderها."
image: "/images/nodejs-26-9-0.png"
---

<div dir="rtl">

نسخه **Current** است، LTS اکتبر. ۱۶ سپتامبر ۲۰۲۶ آنتوان دو هامل [Node.js ۲۶٫۹٫۰](https://nodejs.org/en/blog/release/v26.9.0) را منتشر کرد. فهرست notable کوتاه است و تقریباً همه SEMVER-MINOR.

**`node:ffi` پیش‌فرض روشن شد** (ماتئو کولینا، #65475). صدا زدن کتابخانه native بدون addon C++ دیگر پشت فلگ مخفی نیست؛ تست‌های خود درخت هم انتظار دارند ffi به‌صورت پیش‌فرض enable باشد. برای هر چیزی که تا دیروز N-API می‌نوشت تا یک `.so` را صدا بزند، سطح حمله و سطح راحتی هم‌زمان عوض شده. Current یعنی روی production شلوغ عجله نکنید؛ روی محیط تست همین پیش‌فرض را جدی بگیرید.

**Web Workers** داخل worker thread آمد (آویو کلر، #64894): مدل `postMessage`/`onmessage` مرورگر، به‌علاوه `ref`/`unref`. این جایگزین `worker_threads` نیست؛ همان API وب است روی isolate جدا. استارت worker thread از snapshot داخلی هم در همین نسخه آمده.

**`node:bench`** (جیمز اسنل، #65606) رانر بنچمارک توکار است: `bench()`، `createRunner()`، `runFile()`، Histogram با **`meanCI`**، و import/export هیستوگرام با **CBOR**. همان changelog یک commit بعدی دارد: ماژول پشت **`--experimental-bench`** گذاشته شد. docs نسخه ۲۶٫۹٫۰ هم صریح می‌گوید بدون این فلگ import نمی‌شود. notable هنوز «implement node:bench» است؛ برای استفاده عملی فلگ را حساب کنید.

بقیه notableها بیشتر crypto و embedder هستند:

- API عام **MAC** (فیلیپ اسکوکان)
- کشف cipher و hash از **OpenSSL provider** به‌جای فهرست ثابت
- **DTLS** آزمایشی (TLS روی UDP) کنار کار QUIC
- embedder می‌تواند **builtin code cache** بدون snapshot بدهد
- **VFS** با loaderهای CJS و ESM یکپارچه شد؛ ZipProvider و load کردن native addon از فایل‌سیستم mountشده هم در commits اطراف دیده می‌شود

Node 26 هنوز Current است. اگر ffi پیش‌فرض برایتان سطح حمله است، قبل از ارتقا permission model و allowlist کتابخانه‌های native را مرور کنید. جزئیات و SHA از [صفحه انتشار](https://nodejs.org/en/blog/release/v26.9.0).

</div>
