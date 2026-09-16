---
title: "Sound Open Firmware ۲٫۱۵ با MMU userspace، AMD ACP 7.x و Intel UAOL"
date: 2026-09-16T15:00:00+03:30
draft: false
slug: "sound-open-firmware-2-15"
tags: ["sof", "audio", "amd", "intel", "dsp", "linux"]
categories: ["Linux", "Open-source"]
description: "تگ v2.15 در ۱۵ سپتامبر ۲۰۲۶: اجرای ماژول با MMU در userspace، AMD ACP 7.x، Intel UAOL، i.MX8MP Cortex-M7، و ماژول‌های FFT/STFT/Phase Vocoder."
image: "/images/sound-open-firmware-2-15.png"
---

<div dir="rtl">

تگ [v2.15](https://github.com/thesofproject/sof/releases/tag/v2.15) روی GitHub پروژه SOF در **۱۵ سپتامبر ۲۰۲۶** با commit `c8e5b75` منتشر شده. خود نوت ریلیز بازه را از v2.14 (۲۴ نوامبر ۲۰۲۵) تا v2.15 (**۱۴ سپتامبر ۲۰۲۶**) نوشته: **۱٬۳۴۳ commit**، ۴۶ نفر، ۱٬۲۱۵ فایل. تیتر اول نوت همان است که در عنوان این پست آمده: اجرای ماژول در userspace با حفاظت حافظه.

SOF میان‌افزار و چارچوب درایور DSP صوتی است، مستقل از فروشنده.

## ماژولی که حافظهٔ کرنل را ننویسد

حالت تازه روی MMU برای taskهای زمان‌بندی‌شده (LL و DP) و ماژول LLEXT؛ یک «userspace proxy» و worker جدا IPC را به‌جای کد بدون امتیاز سرو می‌کند. زیرسیستم **vregion** ناحیهٔ حافظهٔ مجازی per-pipeline/per-module می‌سازد. syscallهای fast-get/fast-put بافر را بدون برداشتن MMU به اشتراک می‌گذارند.

فایده‌ای که خود نوت نوشته: ماژول شخص ثالث خراب دیگر نمی‌تواند حافظهٔ کرنل یا ماژول دیگر را فاسد کند — قدم به‌سمت اجرای DSP فروشندهٔ غیرقابل‌اعتماد.

کنارش حدود ۳۵ commit سخت‌کردن parse برای ورودی بدشکل (manifest رimage، TLV/DMA در IPC4، payload KPB)، CodeQL و zizmor در CI، و پلتفرم fuzz روی POSIX+libFuzzer.

## دو سیلیکون تازه، یک مسیر USB، چند ماژول فرکانس

از همان نوت v2.15:

- **AMD ACP 7.x** — نسل تازهٔ Audio Coprocessor: SoundWire DMA/DAI، نوع TDM DAI، تایمر کم‌تأخیر ۵۰۰µs
- **NXP i.MX8MP Cortex-M7** — SOF روی هستهٔ M7 همین SoC بیلد و اجرا می‌شود
- هدف **QEMU Xtensa** برای boot-test بدون سخت‌افزار

**Intel UAOL** (USB Audio Offload Link): درایور DAI تازه، از firmware پایه بیرون آمده، با IPC4 و topology. host CPU می‌تواند idle باشد، DSP مستقیم USB audio را بگیرد.

ماژول‌های پردازش: **Phase Vocoder** (time-stretch / pitch-shift برای IPC4)، **STFT Process**، **tone generator** بومی IPC4، **FFT** برای بعضی اندازهٔ غیر توان دو، **Selector** با چند پروفایل up/down-mix.

درایور DMA/DAI نیتیو Zephyr برای بیلد IPC4 اجباری شده. اگر روی ACP 7.x یا مسیر UAOL اینتل صبر می‌کردید، همین تگ همان ریلیز است؛ باینری امضاشده را مثل قبل از sof-bin جدا بگیرید.

</div>
