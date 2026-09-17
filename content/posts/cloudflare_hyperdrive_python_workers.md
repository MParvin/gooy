---
title: "Python Workers به Hyperdrive وصل می‌شوند؛ PostgreSQL و MySQL هنوز بتا"
date: 2026-09-17T13:00:00+03:30
draft: false
slug: "cloudflare-hyperdrive-python-workers"
tags: ["cloudflare", "hyperdrive", "python-workers", "postgresql", "mysql"]
categories: ["Cloud", "DevOps"]
description: "۱۶ سپتامبر: Python Workers از طریق Hyperdrive به PostgreSQL و MySQL وصل می‌شوند (بتا). compatibility date از 2026-09-08. درایور پیشنهادی: asyncpg و aiomysql."
image: "/images/cloudflare-hyperdrive-python-workers.png"
---

<div dir="rtl">

Worker پایتونی تا اینجا برای SQL به origin باید خودش TCP و pooling را جمع می‌کرد. ۱۶ سپتامبر ۲۰۲۶ کلادفلر در [changelog](https://developers.cloudflare.com/changelog/post/2026-09-16-hyperdrive-python-workers/) نوشت **Python Workers حالا از طریق Hyperdrive به PostgreSQL و MySQL وصل می‌شوند**. همان روز [صفحهٔ مثال](https://developers.cloudflare.com/hyperdrive/examples/python-workers/) را به‌روز کرد. وضعیت: **بتا**. `compatibility_date` باید **2026-09-08 یا بعدتر** باشد؛ بدون آن سوکت به Hyperdrive نمی‌رسد.

Hyperdrive همان لایهٔ connection pooling و query caching کلادفلر برای دیتابیس‌های SQL است. این خبر Automatic Key Exchange هفتهٔ پیش نیست؛ مسیر Python Workers است.

## درایورهایی که خودشان تست کرده‌اند

هر درایور پایتونی که TCP بلد باشد « theoretically» کار می‌کند؛ کلادفلر صریح می‌گوید فقط این‌ها را با Hyperdrive verify کرده‌اند:

PostgreSQL: **`asyncpg`** (پیشنهادی)، `pg8000`، `psycopg`

MySQL: **`aiomysql`** (پیشنهادی)، `pymysql`

binding در Wrangler یک بلوک `hyperdrive` با `binding` و `id` کانفیگ است؛ فلگ `python_workers` هم لازم است. نمونهٔ asyncpg از خود docs: `asyncpg.connect` با `host/port/user/password/database` از `self.env.HYPERDRIVE` و **`ssl=False`** — TLS تا origin را Hyperdrive نگه می‌دارد، نه نشست داخل Worker.

برای MySQL همان شکل با `aiomysql.connect` و `ssl=None`. دیپلوی: `uv run pywrangler deploy`.

## قفل‌هایی که بتا را بتا نگه می‌دارند

سوکت پایتون در Workers روی `connect` API سوار است؛ عملیات استاندارد library معمولاً هست، بعضی syscall سطح پایین ممکن است مطابق انتظار نباشد. خود socket blockingِ event loop نیست: پیاده‌سازی زیرین async است، چند request می‌توانند هم‌زمان منتظر I/O بمانند. اگر درایور سنکرون است، docs یک `asyncio.Lock` دور عملیات دیتابیس می‌گذارد تا serialize شود.

**SQLAlchemy**: فعلاً فقط ORM سنکرون. async SQLAlchemy به‌خاطر نبود **greenlet** در محیط Python Workers پشتیبانی نمی‌شود.

اگر باگ دیدید کانال `#python-workers` در Discord دولوپرهای کلادفلر همان جایی است که صفحهٔ docs لینک کرده. برای production شلوغ، بتا یعنی driver و compatibility date را قفل کنید؛ از درایور تست‌نشده انتظار pool پایدار نداشته باشید.

</div>
