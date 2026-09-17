---
title: "Dragonfly ۲٫۰: سه سال برای major، بارگذاری RDB والکی ۹ و overhead کمتر"
date: 2026-09-17T14:20:00+03:30
draft: false
slug: "dragonfly-2-0-released"
tags: ["dragonfly", "valkey", "redis", "in-memory", "bsl"]
categories: ["Open-source", "DevOps"]
description: "تگ v2.0.0 چهارشنبه ۱۶ سپتامبر؛ پوشش Phoronix ۱۷ سپتامبر. RDB والکی ۹، GEOSEARCHSTORE، کاهش هزینهٔ اتصال و RDB. سازگار با APIهای Redis/Memcached. مجوز BSL 1.1. غیر از وصله‌های RCE والکی."
image: "/images/dragonfly-2-0.png"
---

<div dir="rtl">

چهارشنبه ۱۶ سپتامبر ۲۰۲۶ تگ [v2.0.0](https://github.com/dragonflydb/dragonfly/releases/tag/v2.0.0) روی GitHub نشست. [Phoronix](https://www.phoronix.com/news/Dragonfly-2.0-Released) صبح ۱۷ سپتامبر آن را پوشش داد. خود ریلیز باز می‌کند: «We have been waiting three years to bump the major version.» این نسخه «feature عمدهٔ تازه» به‌تنهایی اضافه نمی‌کند؛ bump برای «maturity, performance, and production readiness» است.

Dragonfly فروشگاه in-memory سازگار با APIهای **Redis** و **Memcached** است. مجوز از دید Phoronix همچنان **Business Source License 1.1**. این پست همان موج RCE والکی/ردیس روی Alma و Rocky نیست؛ موتور جدا با ادعای کارایی روی یک ماشین.

## سازگاری که 2.0 واقعاً اضافه کرد

از highlights تگ:

- بارگذاری **Valkey 9 RDB** — از جمله hashهایی با فیلد persistent و expiring (#8251)
- **GEOSEARCHSTORE** با query شعاع/جعبه، sort، limit، distance score، ACL و journaling (#7984)
- کنترل backlog replication بر اساس سن و بودجهٔ حافظه؛ گزینهٔ طول ثابت deprecate شد (#8039)
- دستور `MEMORY DEFRAGMENT-SEGMENTS [threshold]` برای پس‌گرفتن صفحهٔ خلوت DashTable (#7995)

RESTORE سخت‌گیرتر شده: فیلد تکراری در HASH/HASH_LISTPACK رد می‌شود؛ payload با طول اعلام‌شده بزرگ‌تر از باقی ورودی reject می‌شود تا OOM از راه دور نسازد.

## جایی که major را حس می‌کنید: هزینهٔ اتصال

کار عملکرد: refresh حافظهٔ parser مم‌کشد یک‌بار در هر batch؛ telemetry حافظهٔ اتصال یک‌بار در هر parse cycle نه بعد از هر فرمان pipeline؛ آزاد کردن بافر serializer RDB بعد از flush (سقف نگهداشت پیش‌فرض **۴ MiB**؛ قبلاً یک object ۵۱۲ مگ می‌توانست ۵۱۲ مگ allocated بگذارد). بافر ورودی کلاینت بعد از کم‌مصرفی جمع می‌شود؛ سقف پیش‌فرض از **۶۴ KiB به ۳۲ KiB**. burst و cooldown برای defrag پس‌زمینه قابل تنظیم است؛ مثال notes حدود **۱٪ یک هسته**.

درستی جدا: tiered storage، مهاجرت کلاستر، stream، compressed list، شکل RESP3 برای null و XREAD بلاک‌شده. یک عدد از notes: tracking حافظهٔ compressed-list روی workload شبیه Celery حدود **۱۳×** زیاد گزارش می‌شد و درست شده.

اگر API سازگار Redis می‌خواهید روی این موتور جدا، 2.0 همان milestone تولید است — با این قید که BSL 1.1 مجوز OSI-approved نیست و باید متن لایسنس را قبل از جاسازی در محصول بخوانید.

</div>
