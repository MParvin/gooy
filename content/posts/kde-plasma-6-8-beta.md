---
title: "KDE Plasma ۶٫۸ Beta با Kup و پیش‌نمایش Union theming"
date: 2026-09-16T14:40:00+03:30
draft: false
slug: "kde-plasma-6-8-beta"
tags: ["kde", "plasma", "kup", "union", "qt", "linux"]
categories: ["Linux"]
description: "اعلام ۱۰ سپتامبر ۲۰۲۶ برای Plasma 6.8 beta (6.7.90): ماژول زمان‌بند پشتیبان kup و پیش‌نمایش Union برای QtWidgets. بتای دوم حدود ۲۴ سپتامبر؛ پایدار حدود ۱۴ اکتبر."
image: "/images/kde-plasma-6-8-beta.png"
---

<div dir="rtl">

پنج‌شنبه ۱۰ سپتامبر ۲۰۲۶ KDE در [اعلام Plasma 6.8 Beta](https://kde.org/announcements/plasma/6/6.7.90/) نسخهٔ **6.7.90** را گذاشت. [Phoronix](https://www.phoronix.com/news/KDE-Plasma-6.8-Beta) همان روز نوشت پایدار **۱۴ اکتبر** است — و آن تاریخ با سی‌امین سالگرد پروژهٔ KDE یکی می‌شود. [جدول زمان Plasma 6](https://community.kde.org/Schedules/Plasma_6) بتای دوم را **6.7.91، پنج‌شنبه ۲۴ سپتامبر** و tarball پایدار را ۸ اکتبر / انتشار ۱۴ اکتبر گذاشته.

اعلامیهٔ خود KDE کوتاه است. دو چیزی که همان صفحه برجسته کرده، همان دو تیتر این پست‌اند.

## Kup دیگر ماژول دسکتاپ است

بین «ماژول‌های تازه در بتای 6.8» فقط یک خط آمده: **kup** — Backup scheduler برای دسکتاپ Plasma. Phoronix همان را این‌طور تکرار کرده که 6.8 با Kup به‌عنوان زمان‌بند پشتیبان دسکتاپ می‌آید. اگر تا حالا Kup را جدا نصب می‌کردید، بتا یعنی این زمان‌بند دیگر قطعهٔ اعلام‌شدهٔ خود Plasma است، نه فقط یک برنامه در extras.

بقیهٔ فهرست هیجان Phoronix — بهینه‌سازی vRAM، dwell clicker روی Wayland، پروتکل commit-timing در KWin، ریموت دسکتاپ، چند GPU، `kscreenctl`، سایهٔ drop سمت سرور — در صفحهٔ 6.7.90 نیامده؛ Larabel آن‌ها را به «ویژگی‌ها و تغییرات مهم» ویکی جامعه حواله داده. اگر برای بنچمارک ریموت دسکتاپ آمده‌اید، منبع همان پوشش Phoronix است نه پاراگراف اول kde.org.

## Union روی Dolphin و Kate؛ هنوز tech preview

نیمهٔ دوم پیش‌نمایش عمومی **Union**. تازه در 6.8: Union حالا اپلیکیشن **QtWidgets** را هم تم می‌کند — مثال خود KDE: **Dolphin** و **Kate**. پشتیبانی مقدماتی است و باگ دارد؛ گزارش را به باگ‌ترکر Union بفرستید.

مسیر تست از System Settings:

1. بستهٔ `union` نصب باشد (نام بسته ممکن است در توزیع فرق کند)
2. Colors & Themes → Application Style
3. **Breeze (Union)** را Apply کنید

این استایل را هم روی QtQuick می‌گذارد هم روی QtWidgets. قصد این است که شکل تا حد ممکن شبیه Breeze معمولی باشد؛ اختلاف جزئی ظاهری را عمدی بدانید. اگر چیزی خراب شد، همان اپ را با استایل Breeze بدون Union مقایسه کنید تا معلوم شود مشکل Union است یا خود برنامه.

تصویر live و Docker برای تست هست. بستهٔ توزیع ممکن است روز اعلام نرسیده باشد. بازخورد را KDE به Matrix‏ #Plasma، فهرست plasma-devel و Bugzilla سپرده. بتای دوم دو هفته بعد است؛ اگر Union روی Kate هنوز رنگ می‌پرد، همان پنجرهٔ ۲۴ سپتامبر برای فشار دوم است نه ۱۴ اکتبر.

</div>
