---
title: "جاوا ۲۷ عمومی شد؛ G1 پیش‌فرض همه‌جا و TLS پساکوانتومی هیبرید"
date: 2026-09-16T06:20:00+03:30
draft: false
slug: "java-27-ga"
tags: ["java", "openjdk", "jdk-27", "g1", "tls", "post-quantum"]
categories: ["Programming"]
description: "GA جاوا ۲۷ در ۱۵ سپتامبر ۲۰۲۶: JEP 523 جی۱ را پیش‌فرض همه محیط‌ها می‌کند، JEP 527 تبادل کلید هیبرید پساکوانتومی برای TLS 1.3، JEP 534 هدر فشرده شیء."
image: "/images/java-27-ga.png"
---

<div dir="rtl">

۱۵ سپتامبر ۲۰۲۶، طبق [Inside.java](https://inside.java/2026/09/15/jdk-27-available/) و صفحهٔ پروژهٔ [OpenJDK 27](https://openjdk.org/projects/jdk/27/)، JDK 27 به General Availability رسید — هجدهمین feature release روی ریتم شش‌ماهه. نه پیش‌نمایش، نه RC؛ باینری production-ready تحت GPL از Oracle آمده و بقیهٔ vendorها به‌زودی دنبال می‌کنند. Oracle تا **مارس ۲۰۲۷** برای ۲۷ آپدیت می‌دهد؛ بعد **JDK 28** جایش را می‌گیرد.

چیزی که این ریلیز را از یک bump شماره‌ای جدا می‌کند، دو پیش‌فرض HotSpot است که دیگر opt-in نیستند.

## G1 دیگر «جمع‌کنندهٔ سرور» نیست

از JDK 9، اگر GC روی خط فرمان مشخص نمی‌شد، JVM در محیط سرور **G1** برمی‌داشت و در محیط محدودتر اغلب **Serial**. [JEP 523](https://openjdk.org/jeps/523) این دوگانگی را تمام می‌کند: HotSpot همیشه G1 را انتخاب می‌کند. ادعا این است که throughput، latency، ردپای حافظه و استارت‌آپ نسبت به Serial «به‌طور معنادار» افت نکند. [Phoronix](https://www.phoronix.com/news/OpenJDK-27-Java-27) همان را خلاصه کرده: بعد از کار روی همگام‌سازی (JEP 522) حداکثر throughput به Serial نزدیک شده، latency حداکثر همیشه بهتر بوده چون G1 نسل قدیم را incremental جمع می‌کند نه با full collection، و مصرف حافظهٔ native هم به سطح Serial رسیده.

کنارش [JEP 534](https://openjdk.org/jeps/534) هدر فشردهٔ شیء را پیش‌فرض می‌کند: روی معماری ۶۴ بیتی از **۹۶ بیت به ۶۴ بیت**. از JDK 24 این layout آزمایش شده؛ نتیجهٔ مورد انتظار چگالی استقرار بیشتر، locality بهتر، heap کوچک‌تر.

## TLS 1.3 هیبرید، بدون دست زدن به کد اپ

[JEP 527](https://openjdk.org/jeps/527) تبادل کلید هیبرید پساکوانتومی را برای TLS 1.3 می‌آورد: الگوریتم مقاوم به کامپیوتر کوانتومی کنار الگوریتم کلاسیک. اپ‌هایی که `javax.net.ssl` را به‌کار می‌برند، بدون تغییر کد، به‌صورت پیش‌فرض از الگوریتم بهتر استفاده می‌کنند. همان پست Inside.java از به‌روزرسانی encoding کلید خصوصی ML-KEM/ML-DSA و شتاب ML-KEM، ML-DSA، X25519 و Ed25519 هم گفته؛ این‌ها JEP جدا نیستند ولی پایهٔ PQC را سفت می‌کنند.

بقیهٔ فهرست JEP عمدتاً هنوز موقت است و نباید با GA قاطی شود: PEM encodings سومین preview (JEP 538)، primitiveها در pattern/`instanceof`/`switch` پنجمین preview (JEP 532)، lazy constants سومین preview (JEP 531)، structured concurrency هفتمین preview (JEP 533)، Vector API دوازدهمین incubator (JEP 537). یکی که پایدار است و کمتر براق: [JEP 536](https://openjdk.org/jeps/536) — JFR آرگومان خط فرمان و مقدار اولیهٔ متغیر محیط و system property را **قبل از خروج از پروسه** redact می‌کند تا دادهٔ حساس از مسیر تشخیص نشت نکند.

اگر ۲۶ را به‌خاطر Serial روی heap کوچک یا هدر قدیمی نگه داشته‌اید، ۲۷ همان ریلیزی است که این دو را دیگر پرچم آزمایشی حساب نمی‌کند.

</div>
