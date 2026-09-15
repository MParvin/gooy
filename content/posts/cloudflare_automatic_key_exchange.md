---
title: "Automatic Key Exchange در Cloudflare: TLS پساکوانتومی به origin بدون مالیات HRR"
date: 2026-09-15T09:40:00+03:30
draft: false
tags: ["cloudflare", "tls", "post-quantum", "x25519mlkem768", "cdn"]
categories: ["Security", "DevOps"]
description: "Cloudflare از ۸ سپتامبر Automatic Key Exchange را برای originهای TLS 1.3 پیش‌فرض کرده؛ HRR از حدود ۵۲٪ به ۳٫۷٪ رسید و ترافیک PQ بدون retry به ۹۹٫۲٪."
image: "/images/cloudflare-automatic-key-exchange.png"
---

<div dir="rtl">

هر بار Cloudflare به origin یک اتصال TLS 1.3 باز می‌کند، باید **قبل از** این‌که origin چیزی بگوید، الگوریتم key-agreement را در ClientHello حدس بزند. حدس درست یعنی یک round-trip. حدس غلط یعنی **HelloRetryRequest** و یک round-trip اضافه.

سال‌ها حدس ثابت بود: **X25519**. امن، رایج، و برای تقریباً ۳۰٪ اتصال‌های origin که بعداً اندازه گرفتند، زیر بهینه. از سپتامبر ۲۰۲۳ پشتیبانی پساکوانتومی را advertise می‌کردند ولی keyshare اول را کلاسیک می‌فرستادند تا ClientHello چندپکتی بعضی middleboxها را نشکند. نتیجه: تقریباً هر handshake پساکوانتومی به origin یک HRR اجباری می‌پرداخت.

۸ سپتامبر ۲۰۲۶ در [پست رسمی](https://blog.cloudflare.com/automatic-key-exchange-for-origins/) اعلام شد این حدس با اندازه‌گیری عوض می‌شود. اسم قابلیت: **Automatic Key Exchange**، گسترش همان Automatic SSL/TLS.

## عددهایی که مالیات retry را نشان می‌دهند

روی cohort اسکن‌شده:

- نرخ HRR از حدود **۵۲٪** به **۳٫۷٪**
- تأخیر handshake در **p90** بیش از **۱۵۰ms** کم شده
- سهم ترافیک پساکوانتومی origin که **بدون HRR** تمام می‌شود: از **۰٪** به **۹۹٫۲٪**
- حدود **۴۵ میلیارد** اتصال روزانه PQ به origin ذکر شده (از حدود ۲۵ میلیارد رشد کرده)

ترجیح الگوریتم، وقتی origin بلد باشد: **X25519MLKEM768**. در cohort اولیه حدود ۳۳٪ دامنه‌ها همین را به‌عنوان preference گرفتند؛ حدود ۶۴٪ روی X25519 کلاسیک ماندند؛ حدود ۳٪ منحنی کلاسیک دیگری مثل P-256 / P-384 / P-521.

## اسکن، نه حدس

برای هر origin که TLS 1.3 حرف می‌زند، چند handshake سبک بیرون از مسیر ترافیک production زده می‌شود؛ هر کدام دقیقاً یک گروه: X25519، P-256، P-384، P-521 یا X25519MLKEM768. بعد قوی‌ترین گزینه با اولویت hybrid پساکوانتومی انتخاب می‌شود. rollout اول روی سهم کوچکی از ترافیک همان origin است؛ اگر HRR از baseline بالا رفت، برمی‌گردند. **هر روز** origin از نو اسکن می‌شود.

برای اکثر مشتری‌ها چیزی تنظیم نمی‌شود: اگر origin TLS 1.3 باشد، پیش‌فرض روشن است. در داشبورد می‌شود Automatic Key Exchange را خاموش کرد تا دوباره ترتیب ثابت برگردد.

دو toggle انطباقی هم آمده: **PQ-only** (فقط hybrid پساکوانتومی) و **FIPS**. هر دو را با هم انتخاب کردن یعنی الگوریتم باید هر دو شرط را هم‌زمان ارضا کند. اگر origin اصلاً X25519MLKEM768 نداشته باشد و PQ-only را اجبار کنید، اتصال TLS 1.3 می‌شکند. پست رسمی می‌گوید مگر policy سخت دارید، هر دو را خالی بگذارید تا سیستم خودش مذاکره کند.

</div>
