---
title: "به‌روزرسانی سپتامبر Raspberry Pi OS: Dock جدید و بازطراحی Control Centre"
date: 2026-09-16T12:40:00+03:30
draft: false
slug: "raspberry-pi-desktop-september-2026"
tags: ["raspberry-pi", "labwc", "wayland", "desktop", "linux"]
categories: ["Linux"]
description: "Changelog تصویر arm64 در ۱۵ سپتامبر ۲۰۲۶: dock در wf-panel-pi، پنل‌های تازه Control Centre، Labwc/wlroots 0.20، هسته Linux 6.18.50."
image: "/images/raspberry-pi-desktop-september-2026.png"
---

<div dir="rtl">

[release notes تصویر ۶۴بیتی Raspberry Pi OS](https://downloads.raspberrypi.com/raspios_arm64/release_notes.txt) تاریخ **2026-09-15** را با یک خط شروع می‌کند: پشتیبانی **dock** به `wf-panel-pi` اضافه شد. همان بلوک، Control Centre را بازچین می‌کند، Labwc/wlroots را به **0.20** می‌برد، و هسته را **Linux 6.18.50** می‌گذارد (`cff533aec2fa601846766b32ff57204e0a61bed7`).

[وبلاگ دسکتاپ](https://www.raspberrypi.com/news/an-updated-look-for-the-raspberry-pi-desktop/) همان روز تأکید کرده این‌ها **اختیاری**اند: تصویر تازه پیش‌فرض را taskbar همیشگی می‌گذارد، بدون dock. Phoronix تیتر overhaul زد و نوشت dock پیش‌فرض است؛ changelog و وبلاگ رسمی آن را تأیید نمی‌کنند.

## آنچه changelog برای ۱۵ سپتامبر نوشته

- پشتیبانی dock در **wf-panel-pi**
- پلاگین تازهٔ **icon menu** و **icon tasklist** برای همان پنل
- حالت نمایش آنالوگ برای پلاگین ساعت
- پنل **Dock** در Control Centre برای پیکربندی اسکله
- پنل **Widgets** برای تنظیم dock و taskbar — جای دیالوگ داخل خود `wf-panel-pi`
- پنل **Notifications**، باز هم به‌جای دیالوگ پنل
- پنل **Shortcuts** برای دیدن و ویرایش میانبرهای سیستمی
- در Defaults: چند layout مبتنی بر dock، به‌علاوه پیش‌فرض برای صفحه‌های خیلی بزرگ
- در Taskbar: autohide و جلوگیری از overlay روی پنجرهٔ بیشینه
- آیکون **۹۶×۹۶** برای `wf-panel-pi` و `lxpanel-pi`
- در Desktop: امکان کشیدن پس‌زمینه با **swaybg** به‌جای pcmanfm
- ابزار اسکرین‌شات تازه، با انتخاب رفتار پیش‌فرض (باز کردن، کپی به clipboard و مشابه)
- بیلد یکپارچهٔ فایل‌منیجر **pcmanfm-pi** (ادغام pcmanfm و libfm)
- automount درایو خارجی قابل‌کلید در پلاگین ejecter؛ pcmanfm دیگر پیش‌فرض automount نمی‌کند
- معماری پلاگین `wf-panel-pi` بدون XML metadata برای مقدار پیش‌فرض؛ ساختار سورس برای هم‌رفتاری با `lxpanel-pi` تمیز شده
- پشتیبانی **wayfire** از پنل‌های Screens و Mouse و Keyboard در Control Centre برداشته شده
- **labwc** و **wlroots** نسخهٔ **0.20**
- firmware رزبری‌پای `b76effded7afe5ed92070ff169e0109a8487fb82`

وبلاگ برای حس استفاده جزئی‌تر است: launcher تمام‌صفحه جای منوی اصلی، task list با شمارندهٔ پنجره، سینی دو ردیفه سمت راست dock، و سه سبک Defaults (Taskbar / Taskbar+Dock / Dock). روی برد زیر ۲ گیگ پیشنهاد خاموش کردن Active Desktop است.

نصب موجود: `sudo apt update` و **`sudo apt full-upgrade`**. طبق وبلاگ، خود آپدیت dock را روشن نمی‌کند.

</div>
