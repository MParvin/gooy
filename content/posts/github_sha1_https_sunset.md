---
title: "گیت‌هاب پشتیبانی SHA-1 در HTTPS را برای github.com و CDNهای همکار قطع کرد"
date: 2026-09-17T04:40:00+03:30
draft: false
slug: "github-sha1-https-sunset"
tags: ["github", "tls", "sha-1", "https", "ghec"]
categories: ["Security"]
description: "۱۵ سپتامبر ۲۰۲۶ طبق برنامه: SHA-1 در HTTPS برای github.com و CDNهای همکار از جمله GHEC و GHEC Data Residency غیرفعال شد. GHES دست نخورده. کلاینت/middlebox فقط-SHA-1 می‌شکند."
image: "/images/github-sha1-https-sunset.png"
---

<div dir="rtl">

۱۵ سپتامبر ۲۰۲۶ گیت‌هاب در [Changelog](https://github.blog/changelog/2026-09-15-sha-1-in-https-on-github-sunset/) یک جمله نوشت که باید همان‌طور خواند: قبلاً گفته بودند SHA-1 در HTTPS را همین روز قطع می‌کنند؛ طبق همان تقویم، قطع کردند.

محدوده صریح است:

- **github.com**
- **CDNهای همکار**، شامل **GitHub Enterprise Cloud** و **GitHub Enterprise Cloud with Data Residency**

**GitHub Enterprise Server دست نخورده است.** اگر GHES خودمیزبان دارید، این sunset به TLS ترمیناتور شما سرایت نمی‌کند.

آنچه می‌شکند فقط کلاینت یا middleboxی است که در مذاکرهٔ HTTPS **فقط** cipher suite مبتنی بر SHA-1 پیشنهاد می‌دهد. مرورگر و git و SDKهای چند سال اخیر روی AEAD و SHA-256 هستند؛ گیر معمولاً اسکنر قدیمی، proxy شرکتی، یا کتابخانهٔ TLS قفل‌شده روی suiteهای منسوخ است.

خود پست Changelog جزئیات cipher را تکرار نمی‌کند و به اعلام قبلی ارجاع می‌دهد. پیام عملی همان است: اگر بعد از ۱۵ سپتامبر clone/API به github.com یا GHEC با handshake error می‌آید، اول نگاه کنید peer هنوز SHA-1 را به‌عنوان تنها گزینه می‌فرستد، نه این‌که توکن یا DNS خراب شده باشد. برای GHES هیچ تغییری از این announcement لازم نیست.

</div>
