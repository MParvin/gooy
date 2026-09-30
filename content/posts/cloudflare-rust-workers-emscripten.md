---
title: "Rust و Tokio روی Workers: پیش‌نمایش هدف Emscripten و wasm-bindgen"
date: 2026-09-28T14:00:00+03:30
draft: false
slug: "cloudflare-rust-workers-emscripten"
tags: ["cloudflare", "workers", "rust", "tokio", "wasm", "emscripten"]
categories: ["Cloud", "Programming"]
description: "پیش‌نمایش عمومی experimental برای wasm32-unknown-emscripten روی Rust Workers: مجازی‌سازی timer و FS و socket، همکاری با Google روی wasm-bindgen، دمو Minecraft در Durable Object."
image: "/images/cloudflare-rust-workers-emscripten.png"
---

<div dir="rtl">

«Rust را به Wasm کامپایل کن و روی edge بفرست» سال‌هاست شعار است. ۲۸ سپتامبر ۲۰۲۶ کلادفلر در [پست Rust Workers](https://blog.cloudflare.com/rust-workers-emscripten-target/) چیز دیگری را preview کرد: پشتیبانی first-class و experimental از هدف **`wasm32-unknown-emscripten`** برای **wasm-bindgen** و **Cloudflare Rust Workers**، طوری که اپ‌های **native Rust / Tokio** بتوانند روی Workers زنده بمانند — نه فقط یک subset بی‌runtime.

چطور؟ با مجازی‌سازی timer، فایل‌سیستم و socket از مسیر سازگاری Node.js و Emscripten. کار مشترک با مهندسان Google روی هم‌زیستی wasm-bindgen و Emscripten (`-sWASM_BINDGEN`) همین شکاف را هدف گرفته است. برای async، patchهای Tokio حول **JSPI** و پیشنهاد **LocalEventLoop** آمده‌اند. سمت شبکه، فلگ Emscripten **`-sNODERAWSOCKETS`** مسیر epoll و TCP/UDP/Unix socket را از طریق `node:net` باز می‌کند.

دموی ملموس‌شان: سرور **Pumpkin Minecraft** داخل یک **Durable Object** با TCP ingress. هنوز experimental است و patchها pre-release؛ کسی نباید فردا production حساس را روی این هدف ببندد. ولی از نگاه اکوسیستم، جهش سازگاری کتابخانه‌های native Rust روی edge است — دقیقاً جایی که قبلاً Tokio و socket واقعی دیوار می‌شدند.

</div>
