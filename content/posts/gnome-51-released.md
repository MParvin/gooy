---
title: "GNOME ۵۱ «A Coruña»: زمان‌بندی فریم Mutter، نقشهٔ آفلاین، پیش‌نمایش فایل نو"
date: 2026-09-17T14:40:00+03:30
draft: false
slug: "gnome-51-released"
tags: ["gnome", "mutter", "wayland", "ubuntu", "fedora"]
categories: ["Linux", "Open-source"]
description: "۱۶ سپتامبر GNOME 51 با اسم A Coruña. Mutter: frame scheduling، ext-background-effect-v1، حذف رابط قدیمی NVIDIA/EGLStreams، شتاب اشاره‌گر سفارشی. Maps آفلاین؛ Software و Calendar سریع‌تر. برای اوبونتو 26.10 و فدورا ۴۵."
image: "/images/gnome-51.png"
---

<div dir="rtl">

۱۶ سپتامبر ۲۰۲۶ پروژه در [release.gnome.org/51](https://release.gnome.org/51/) نسخهٔ **GNOME 51** را با اسم رمز **«A Coruña»** اعلام کرد — به احترام GUADEC ۲۰۲۶ در همان شهر گالیسیا. شش ماه توسعه. این پست بتای فدورا ۴۵ نیست که GNOME 51 را فقط به‌عنوان دسکتاپ Workstation شمرده؛ خود بالادست است. [Phoronix](https://www.phoronix.com/news/GNOME-51-Released) همان روز نوشت به‌موقع برای **اوبونتو 26.10** و **فدورا Workstation 45** می‌رسد. پست GTK 4.24 گوی هم همین چرخه را از سمت toolkit دیده بود.

## Mutter: فریم سر وقت، نه درایور قدیمی

یادداشت رسمی: زمان‌بندی فریم از نو؛ انیمیشن زیر بار نرم‌تر می‌ماند. ضبط صفحه کپی بافر اضافی کمتری می‌کند. روشنایی مانیتور بعد از reboot و تغییر HDR یادش می‌ماند.

جملهٔ GNOME: پشتیبانی از «legacy NVIDIA driver interfaces» حذف شده تا فقط رابط مدرن بماند. [Phoronix](https://www.phoronix.com/news/GNOME-51-Released) همان را **EGLStreams** نام می‌برد و از پروتکل‌های تازهٔ Wayland مثل **ext-background-effect-v1** می‌گوید. فایل [NEWS مادر 51.0](https://download.gnome.org/sources/mutter/51/mutter-51.0.news) صریح **custom acceleration profiles** را دارد (`!4296`). کرسرها از SVG مقیاس‌پذیر رندر می‌شوند نه بیت‌مپ ثابت.

## اپ‌هایی که این ریلیز را حس می‌کنند

**Maps**: دانلود ناحیه برای استفادهٔ آفلاین؛ مدیریت از یک فهرست. ترانزیت: حرکت لحظه‌ای ایستگاه، تأخیر realtime، شمارهٔ سکو، زمان پیاده تا ایستگاه.

**Software**: هشدار نصب اپ end-of-life، مجوز Flatpak کامل‌تر، استارت سریع‌تر با reuse کش و آیکون بهینه‌تر.

**Calendar**: بازنویسی زیرهود؛ ماه شلوغ نرم‌تر اسکرول می‌شود. لینک مکان به Maps؛ ویرایشگر رویداد با لینک Microsoft Teams.

**File Previewer** (Sushi): بازنویسی کامل UI روی GTK 4 و libadwaita؛ dark mode، تصویر در اندازهٔ واقعی، همان کتابخانه‌های لود تصویر و سند بقیهٔ دسکتاپ. Space روی فایل همان میانبر است.

کنارش: Files با نشان تعداد هنگام drag؛ Web با `Ctrl+Shift+C` برای کپی URL و تولید پسورد با `pwquality`؛ Papers امضای دیداری (نه گواهی دیجیتال) از کارآموزی Outreachy مالیکا عثمان؛ کلیدها روی مؤلفهٔ **oo7**.

اگر از GNOME 50 می‌آیید، ۵۱ همان دسکتاپی است که 26.10 و فدورا ۴۵ GA قرار است تحویل بدهند. Nightly GNOME OS و Flatpak روی Flathub برای کسی است که نمی‌خواهد تا ISO توزیع صبر کند.

</div>
