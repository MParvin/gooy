---
title: "دسکتاپ Raspberry Pi OS بازطراحی شد؛ اسکلهٔ آیکون و Control Centre تازه"
date: 2026-09-16T12:40:00+03:30
draft: false
slug: "raspberry-pi-desktop-september-2026"
tags: ["raspberry-pi", "labwc", "wayland", "desktop", "linux"]
categories: ["Linux"]
description: "۱۵ سپتامبر ۲۰۲۶: اسکلهٔ آیکون اختیاری، launcher تمام‌صفحه، Control Centre بازچین‌شده، اسکرین‌شات و file manager تازه. نوار وظیفه اگر بخواهید می‌ماند."
image: "/images/raspberry-pi-desktop-september-2026.png"
---

<div dir="rtl">

سیمون لانگ در [وبلاگ Raspberry Pi](https://www.raspberrypi.com/news/an-updated-look-for-the-raspberry-pi-desktop/) ۱۵ سپتامبر ۲۰۲۶ را با یک هشدار شروع کرد: این‌ها **کاملاً اختیاری**اند. تصویر تازه را نصب کنید، ظاهر پیش‌فرض همان taskbar همیشگی است، بدون dock. اگر نخواهید، دسکتاپ «دقیقاً همان حسی را می‌دهد که همیشه داشته». [Phoronix](https://www.phoronix.com/news/Raspberry-Pi-Desktop-2026) تیتر را «overhaul» گذاشت و نوشت dock به‌صورت پیش‌فرض آمده؛ خود اعلامیه خلاف این را می‌گوید — پیش‌فرض taskbar است.

پس زمینه از خود لانگ: بیش از یک دهه LXDE که کم‌کم زیرساختش Wayland و **labwc** شد، ولی حس کلی هنوز نوار، آیکون وضعیت و منوی اصلی است. هدف این به‌روزرسانی افزودن چیزهایی است که دسکتاپ‌های دیگر رایج کرده‌اند، بدون این‌که کسی را مجبور کنند.

## اسکله، launcher تمام‌صفحه، فهرست کار

بزرگ‌ترین اضافه **icon dock** است: می‌تواند جای taskbar را بگیرد یا **کنارش** بماند. دو ویجت تازه برای dock آمده‌اند — launcher گرافیکی تمام‌صفحه (جایگزین منوی اصلی؛ آیکون تمشک صفحه را باز می‌کند) و یک launcher سریع + task list مبتنی بر آیکون.

آیکون‌های launcher پیش‌فرض الفبایی‌اند، می‌شود drag-and-drop کرد، جستجو و کیبورد کار می‌کند. اگر برنامه‌ها زیاد باشند، دسته‌بندی منو صفحه را سلسله‌مراتبی می‌کند. همین دو ویجت را می‌شود در taskbar قدیمی هم گذاشت؛ منو و window list قدیمی را هم می‌شود داخل dock برد.

در Control Centre صفحهٔ **Dock** رنگ و موقعیت و اندازهٔ آیکون را می‌دهد. **Autohide** برای taskbar و dock هر دو آمده؛ **Exclusive** جلوی هم‌پوشانی پنجرهٔ بیشینه با نوار را می‌گیرد. صفحهٔ **Widgets** پلاگین را بین نوار و اسکله جابه‌جا می‌کند. سمت راست dock سینی دو ردیفه است با آیکون‌های نصف‌اندازه.

برای امتحان سریع، صفحهٔ Defaults سه سبک دارد: **Taskbar** (همان همیشگی)، **Taskbar / Dock** (launcher و task list روی اسکله، وضعیت روی نوار)، **Dock** (نوار خالی می‌شود، همه روی اسکله).

## بقیهٔ Control Centre، اسکرین‌شات، فایل‌منیجر

صفحهٔ **Shortcuts** میانبرهای سیستمی را نشان می‌دهد و ویرایش می‌کند. پس‌زمینه را اگر آیکون دسکتاپ نمی‌خواهید می‌شود با **swaybg** کشید به‌جای pcmanfm — روی برد زیر ۲ گیگ پیشنهاد خود پروژه خاموش کردن Active Desktop است. automount درایو خارجی از فایل‌منیجر به پلاگین ejecter رفته.

PrtScrn دیگر بی‌حرف در Pictures ذخیره نمی‌کند: دیالوگ می‌پرسد فایل در ویرایشگر باز شود یا به clipboard برود. Alt+PrtScrn ناحیه انتخاب می‌کند.

[Linuxiac](https://linuxiac.com/raspberry-pi-os-september-update-adds-new-dock/) جزئیات بسته‌ای را هم نوشته که در پست وبلاگ نیست: dock داخل `wf-panel-pi` 1.31، پلاگین‌های `wfplug-imenu` 0.9 و `wfplug-wlist` 0.8، بیلد یکپارچهٔ **pcmanfm-pi** 1.6، Labwc/wlroots سری 0.20، و هستهٔ **Linux 6.18.50 LTS**. پشتیبانی Wayfire از چند پنل Control Centre برداشته شده.

تصویر تازه امروز منتشر شده. نصب موجود: `sudo apt update` و بعد **`sudo apt full-upgrade`**. Dock خودش روشن نمی‌شود؛ Defaults را باید خودتان عوض کنید.

</div>
