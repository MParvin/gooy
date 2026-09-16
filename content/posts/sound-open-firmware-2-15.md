---
title: "Sound Open Firmware ۲٫۱۵: پشتیبانی AMD ACP ۷٫x و Intel UAOL"
date: 2026-09-16T15:00:00+03:30
draft: false
slug: "sound-open-firmware-2-15"
tags: ["sof", "audio", "amd", "intel", "dsp", "linux"]
categories: ["Linux", "Open-source"]
description: "SOF 2.15 حدود ۱۵ سپتامبر ۲۰۲۶: AMD ACP 7.x، Intel USB Audio Offload Link، i.MX8MP Cortex-M7، اجرای ماژول با حفاظت MMU، و ماژول‌های FFT/STFT/Phase Vocoder."
image: "/images/sound-open-firmware-2-15.png"
---

<div dir="rtl">

تگ **v2.15** روی [GitHub thesofproject/sof](https://github.com/thesofproject/sof/releases) ۱۵ سپتامبر ۲۰۲۶ با commit `c8e5b75` آمده. خود نوت ریلیز بازه را از v2.14 (۲۴ نوامبر ۲۰۲۵) تا v2.15 (**۱۴ سپتامبر ۲۰۲۶**) نوشته: **۱٬۳۴۳ commit**، ۴۶ نفر، ۱٬۲۱۵ فایل. [Phoronix](https://www.phoronix.com/news/Sound-Open-Firmware-2.15) همان ۱۵ سپتامبر خبر را با تیتر AMD ACP 7.x و Intel UAOL کار کرد.

SOF میان‌افزار و چارچوب درایور DSP صوتی است، مستقل از فروشنده. 2.15 بیشتر از یک جدول SoC تازه است.

## ماژولی که حافظهٔ کرنل را ننویسد

تیتر خود نوت: اجرای ماژول در userspace با حفاظت حافظه. حالت تازه روی MMU برای taskهای زمان‌بندی‌شده (LL و DP) و ماژول LLEXT؛ یک «userspace proxy» و worker جدا IPC را به‌جای کد بدون امتیاز سرو می‌کند. زیرسیستم **vregion** ناحیهٔ حافظهٔ مجازی per-pipeline/per-module می‌سازد. syscallهای fast-get/fast-put بافر را بدون برداشتن MMU به اشتراک می‌گذارند.

فایده‌ای که خودشان نوشته‌اند: ماژول شخص ثالث خراب دیگر نمی‌تواند حافظهٔ کرنل یا ماژول دیگر را فاسد کند — قدم به‌سمت اجرای DSP فروشندهٔ غیرقابل‌اعتماد. Phoronix همان را «user-space, memory-protected module execution» گذاشته.

کنارش حدود ۳۵ commit سخت‌کردن parse برای ورودی بدشکل (manifest رimage، TLV/DMA در IPC4، payload KPB)، CodeQL و zizmor در CI، و پلتفرم fuzz روی POSIX+libFuzzer.

## دو سیلیکون تازه، یک مسیر USB، چند ماژول فرکانس

سخت‌افزار:

- **AMD ACP 7.x** — نسل تازهٔ Audio Coprocessor: SoundWire DMA/DAI، نوع TDM DAI، تایمر کم‌تأخیر ۵۰۰µs. Phoronix حدس زده با طراحی‌های دسکتاپ/لپ‌تاپ Zen 6 بعدی می‌آید؛ نوت SOF آن حدس را نزده، فقط IP را توصیف کرده
- **NXP i.MX8MP Cortex-M7** — SOF روی هستهٔ M7 همین SoC بیلد و اجرا می‌شود
- هدف **QEMU Xtensa** برای boot-test بدون سخت‌افزار

**Intel UAOL** (USB Audio Offload Link): درایور DAI تازه، از firmware پایه بیرون آمده، با IPC4 و topology. فایدهٔ نوشته‌شده: host CPU می‌تواند idle باشد، DSP مستقیم USB audio را بگیرد.

ماژول‌های پردازش:

- **Phase Vocoder** — time-stretch / pitch-shift برای IPC4
- **STFT Process** — چارچوب Short-Time Fourier Transform
- **tone generator** بومی IPC4 (قبلاً فقط IPC3)
- **FFT** دیگر فقط توان دو نیست
- **Selector** با چند پروفایل up/down-mix

درایور DMA/DAI نیتیو Zephyr برای بیلد IPC4 اجباری شده. اگر روی لپ‌تاپ AMD با ACP 7.x یا مسیر UAOL اینتل صبر می‌کردید، 2.15 همان ریلیزی است که نوت پروژه برای هر دو ردیف گذاشته؛ باینری امضاشده را مثل ریلیزهای قبلی از sof-bin جدا بگیرید.

</div>
