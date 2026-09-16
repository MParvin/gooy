---
title: "Firefox ۱۵۷ Beta با بهبود HDR، Nova UI و ویژگی‌های CSS"
date: 2026-09-16T13:00:00+03:30
draft: false
slug: "firefox-157-beta"
tags: ["firefox", "mozilla", "hdr", "css", "nova", "browser"]
categories: ["Browsers"]
description: "پوشش Phoronix در ۱۵ سپتامبر ۲۰۲۶ برای بتای ۱۵۷: HDR هشت‌بیتی، همگامی A/V، Nova و compact mode، at-rule() و overscroll-behavior chain. پایدار حدود ۲۹ سپتامبر."
image: "/images/firefox-157-beta.png"
---

<div dir="rtl">

پایدار Firefox 156 که همین هفته آمد، قطار بعدی را باز کرد. [Phoronix](https://www.phoronix.com/news/Firefox-157-Beta) ۱۵ سپتامبر نوشت **Firefox 157** حالا در بتا است و پایدار حدود **۲۹ سپتامبر** می‌آید. همان مطلب سه محور را تیتر کرده: ویدیوی HDR با فرمت رنگ ۸ بیت، همگامی صدا/تصویر وقتی نرخ پخش عوض می‌شود، و کار تازهٔ **Nova UI** از جمله برگشت **compact mode**.

[یادداشت کانال Beta برای 157.0beta](https://www.mozilla.org/en-US/firefox/157.0beta/releasenotes/) می‌گوید نسخه «اولین بار ۱۴ سپتامبر ۲۰۲۶ به کاربران Beta پیشنهاد شد». یادداشت بتا سه بار در هفته عوض می‌شود؛ آنچه موقع نوشتن این پست روی صفحه بود، نام Nova را نیاورده. compact mode را تیم UX موزیلا در [پست مه ۲۰۲۶ Project Nova](https://blog.mozilla.org/en/firefox/new-firefox-design/) قول داده بود. منبع تیتر Nova در این خبر همان پوشش Phoronix است.

## ویدیو، نوار کناری، CSS

از بخش Fixed یادداشت موزیلا — همان چیزهایی که Larabel خلاصه کرده:

- ویدیو **HDR** که با فرمت رنگ **۸ بیت** کد شده، در بیشتر موارد درست به‌صورت HDR دیده می‌شود؛ چند مورد خاکستری که باید زنده می‌بود درست شده
- همگامی صدا/تصویر وقتی نرخ پخش `HTMLMediaElement` عوض می‌شود بهتر شده
- نوار کناری **Vertical Tabs** در تمام‌صفحه وقتی نشانگر به لبه می‌رود گاهی برنمی‌گشت

روی اندروید، زدن فیلد جستجوی homepage حالا جستجوهای اخیر را نشان می‌دهد.

دو مورد Web Platform که هم Phoronix و هم یادداشت بتا نوشته‌اند:

- تابع **`at-rule()`** برای `@supports` — مثلاً `@supports at-rule(@scope)`
- مقدار **`chain`** برای `overscroll-behavior`

Phoronix بتا را از ftp.mozilla.org نشان داده. پایدار ۱۵۷ هنوز نرسیده؛ مسیر دیدن Nova و compact همین کانال Beta است، نه 156.

</div>
