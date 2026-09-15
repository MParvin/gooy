---
title: "سری ۲۳ پچ kbuild: بیلد کرنل تا ۳۶٪ سریع‌تر — هنوز در mainline نیست"
date: 2026-09-14T11:10:00+03:30
draft: false
tags: ["linux", "kernel", "kbuild", "llm", "performance"]
categories: ["DevOps"]
description: "Lorenzo Stoakes از ARM سری ۲۳ پچ برای موازی‌سازی گلوگاه‌های kbuild فرستاده؛ allmodconfig تا ۳۶٪ سریع‌تر. LLM کمک کرده، کد بازبینی شده، Torvalds موافق است، هنوز merge نشده."
image: "/images/kbuild-patch-series-23-kernel-speedup.jpg"
---

<div dir="rtl">

## چه اتفاقی افتاد؟

۸ سپتامبر ۲۰۲۶، Lorenzo Stoakes (مهندس ARM و توسعه‌دهنده قدیمی لینوکس) سری **۲۳ پچ** با عنوان «kbuild: significantly speed up kernel builds» را به لیست کرنل فرستاد. منبع اصلی: [Patchew](https://patchew.org/linux/20260908-build-speedup-v1-0-5dc1ac01672d@kernel.org/). جمع‌بندی خوب: [Phoronix](https://www.phoronix.com/news/AI-To-Faster-Linux-Kernel-Comp).

ادعا، با عدد روی چند ماشین واقعی:

- **allmodconfig کامل**: تا حدود **۳۶٪** سریع‌تر (بهترین رقم روی EPYC دو سوکته با gcc: ۱۸۸.۶ ثانیه → ۱۲۱.۱ ثانیه)
- **incremental**: تا حدود **۷۰٪** سریع‌تر
- **noop** (هیچ فایلی عوض نشده): تا حدود **۹۰٪** سریع‌تر

روی Threadripper 9980X، EPYC 9754 و مک‌بوک M2 هم بهبود دیده؛ روی defconfig هم اثر دارد، هرچند کوچک‌تر. سری روی چند معماری بیلد و زیر QEMU بوت شده است.

---

## LLM در کار بوده؛ کد «همان خروجی مدل» نیست

Stoakes در cover letter صریح نوشته:

- از LLM برای پیدا کردن گلوگاه و ایده بهبود استفاده شده
- مدل «مقدار زیادی کد تولید کرد، بخش زیادی زشت»
- او کد را گسترده audit و بازنویسی کرده، پیام commit و cover letter را هم دستی ویراسته
- LLM بیلد، تست، دیباگ و تحلیل را هم ارکستره کرده
- صحت بیلد و کرنل در حال اجرا را دستی چک کرده؛ عدد عملکرد را هم دستی تأیید کرده
- هر commit تگ `Assisted-by` دارد

۹ سپتامبر Linus Torvalds جواب داد. اول از برچسب LLM ترسیده بود که پچ‌ها «آشغال جنجالی» باشند. بعد از خواندن نوشت هیچ‌کدام به نظرش وحشتناک نیست، بخش‌های زشت حذف شده، و واکنش‌هایش بیشتر از جنس «می‌شود جلوتر رفت» بوده تا انزجار. جمله کلیدی: **«I'd love for this all to go in. Build times are a pet peeve of mine.»**

همزمان گفت باید از کانال درست بیاید (عمدتاً درخت kbuild؛ تغییر objtool بزرگ است و به تأیید همان تیم نیاز دارد). موازی‌سازی Rust از نظر بازخورد آن سمت هنوز آماده نیست.

یعنی: سیگنال مثبت از Torvalds هست. **Merge در mainline هنوز نشده.** سری v1 روی لیست است، نه در لینوکس پایدار این هفته.

---

## از نظر فنی چه چیزی عوض می‌شود؟

گلوگاه اصلی: بخش بزرگی از بیلد کرنل هنوز تک‌رشته‌ای است. سری سعی می‌کند همان کارها را موازی و کم‌هزینه‌تر کند، نه این‌که compiler را عوض کند.

نواحی درگیر: **kbuild، kallsyms، modpost، objtool، mksysmap، سیستم بیلد Rust**.

نمونه‌ها از cover letter: نخواندن غیرضروری خروجی `nm`، خواندن مستقیم جدول نماد ELF، cache برای objectها و timestamp وابستگی، یک‌بار probe کردن فلگ compiler/linker، هش کردن سورس ماژول فایل‌به‌فایل به‌جای بایت‌به‌بایت، تبدیل `mksysmap` از شل به C. ۴۷ فایل، حدود ۲۸۸۴ خط اضافه و ۶۸۲ خط حذف.

Stoakes نوشته چیز خیلی بحث‌برانگیزی داخل سری نیست؛ کارهای تهاجمی‌تر (مثل باز کردن گسترده هدرهای C) را عمداً نگذاشته.

---

## چرا این خبر ارزش دارد؟

عدد ۳۶٪ برای allmodconfig روی ماشین بزرگ، برای کسی که کرنل می‌سازد واقعی است. از طرفی این دقیقاً همان بحثی است که جامعه کرنل با AI دارد: مدل گلوگاه را پیدا می‌کند، انسان باید زشتی را ببرد. Torvalds این‌بار بعد از audit انسانی چراغ سبز مفهومی داده، نه merge کارت‌بلانش.

اگر فردا در اخبار دیدید «لینوکس ۷.۴ با AI سی و شش درصد سریع‌تر شد»، هنوز زود است. اول باید از درخت kbuild و objtool رد شود.

---

## منابع

- [Patchew: [PATCH 00/23] kbuild: significantly speed up kernel builds](https://patchew.org/linux/20260908-build-speedup-v1-0-5dc1ac01672d@kernel.org/)
- [Phoronix: AI Made A Lot Of "Hideous" Code But Found Major Bottlenecks](https://www.phoronix.com/news/AI-To-Faster-Linux-Kernel-Comp)

</div>
