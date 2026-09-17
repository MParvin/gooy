---
title: "گیت‌هاب ران‌تایم عامل Copilot را به بیش از ۸۰۰ هزار خط Rust تولیدی منتقل کرد"
date: 2026-09-17T05:20:00+03:30
draft: false
slug: "github-copilot-runtime-rust"
tags: ["github", "copilot", "rust", "sdk", "ffi"]
categories: ["AI", "Programming"]
description: "۱۶ سپتامبر، Stephen Toub: پورت درجا از TypeScript/Node به ۱۰۰٪ Rust تولیدی (~۸۳۲ هزار خط + تست؛ تکمیل ۲۱ اوت). FFI با C ABI؛ در C# SDK چرخهٔ یک‌نوبت از ۵٫۲۵ث به ۲۹۲ms داخل‌پروسه. حدود ۱۲۸ PR."
image: "/images/github-copilot-runtime-rust.png"
---

<div dir="rtl">

Copilot CLI و Copilot app و Copilot SDK همه به یک agent runtime تکیه دارند. قبلاً TypeScript روی Node و V8 بود؛ SDK برای این‌که همان حلقه را در C# یا Python صدا بزند، یک پروسهٔ CLI می‌ساخت و JSON-RPC از روی stdin می‌فرستاد. یعنی هر `CopilotClient` یک Node اضافه، یک V8، و حدود صد مگابایت working set برای زبانی که میزبان اصلاً نمی‌خواست.

۱۶ سپتامبر ۲۰۲۶ [Stephen Toub](https://github.blog/ai-and-ml/generative-ai/migrating-the-github-copilot-runtime-to-rust-using-copilot/) نوشت این لایه حالا **بیش از ۸۰۰ هزار خط Rust تولیدی** است. agentها بیشتر کد را نوشتند؛ **۱۲۸ pull request** تدریجی به `main` آمد، نه یک cutover آخر کار. تا **۲۱ اوت ۲۰۲۶** runtime **۱۰۰٪ Rust تولیدی** شد: **۸۳۲٬۳۷۸** خط production به‌علاوهٔ **۴۶۸٬۶۸۹** خط unit test؛ E2E تایپ‌اسکریپت جدا، و حدود ۱۳۰ هزار خط تست در مخزن SDK برای شش زبان.

هدف را این‌طور خلاصه می‌کند: نخواست Rust را به‌خاطر Rust بردارد؛ خواست از Node و V8 جدا شود تا embed با **C ABI**، استارت و حافظهٔ کمتر، و SDK داخل‌پروسه بدون دومین runtime ممکن باشد.

## عددهایی که از SDK سی‌شارپ گرفته

بنچمارک با C# SDK، سرور chat محلیِ قطعی، بدون latency مدل:

| سناریو | ۱۲ مه (Node) | ۲۱ اوت out-of-process | ۲۱ اوت in-process |
| --- | --- | --- | --- |
| Client + session + یک turn | ۵٫۲۵ ث | ۱٫۳۳ ث (۴×) | **۲۹۲ ms (۱۸×)** |
| Resume نشست ۳۲ نوبتی | ۵٫۶۴ ث | ۱٫۵۲ ث | ۲۶۴ ms |
| ده چرخهٔ همزمان کلاینت | ۱۲٫۳۴ ث | ۴٫۱۸ ث | ۷۴۲ ms |

پورت **درجا** بود: هر PR یک قطعه TypeScript را با shim نازک به Rust عوض می‌کرد و `main` قابل‌شیپ می‌ماند. napi-rs پل موقت Node بود تا آخرین caller هم پورت شود. Toub می‌گوید «اگر کامپایل شد، درست است» اینجا شوخی است؛ رگرسیون‌ها همه compile شده بودند.

اگر SDK را داخل سرویس embed می‌کنید، همان جدول in-process دلیل این پورت است: یک turn دیگر پنج ثانیه بوت Node نیست.

</div>
