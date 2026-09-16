---
title: "پلاگین Google Cloud Developer برای عامل‌های کدنویسی؛ استاندارد Agent Plugins"
date: 2026-09-16T14:00:00+03:30
draft: false
slug: "google-cloud-developer-agent-plugin"
tags: ["google-cloud", "mcp", "agents", "claude-code", "codex"]
categories: ["AI", "Cloud"]
description: "۱۰ سپتامبر ۲۰۲۶: پلاگین google-cloud-developer در مخزن Google Agent Skills؛ مهارت‌ها به‌علاوه Developer Knowledge MCP. بر پایهٔ مشخصات باز و vendor-neutral Agent Plugins."
image: "/images/google-cloud-developer-agent-plugin.png"
---

<div dir="rtl">

مهارت تکی برای عامل کدنویسی نصبش آسان است؛ مدیریت ده‌تا مهارت که باید با یک MCP و یک سری guardrail با هم کار کنند دیگر آسان نیست. ۱۰ سپتامبر ۲۰۲۶ جاناتان لی در [وبلاگ Google Cloud](https://cloud.google.com/blog/topics/developers-practitioners/introducing-the-google-cloud-developer-plugin-for-ai-coding-agents) پلاگین را به‌عنوان **بستهٔ نصب‌شدنی** معرفی کرد: مهارت‌ها و ابزارهایی که با هم یک کار را می‌کنند، نه فهرست جدا در هر assistant.

نام بسته: **`google-cloud-developer`**. داخل مخزن **Google Agent Skills** است. تمرکز این نسخهٔ اول، پایه‌ای است که تقریباً هر کاربر Google Cloud لازم دارد: احراز هویت، مجوز، پروژه، و نرده برای عملیات **gcloud**. کنارش پیکربندی سرور MCP به نام **Developer Knowledge** آمده تا عامل روی مستندات رسمی developer گوگل ground شود، نه روی حافظهٔ مدل.

## یک manifest، نه یک wrapper برای هر IDE

گوگل می‌گوید پلاگین را مطابق **Agent Plugins** ساخته — مشخصات باز و vendor-neutral برای بسته‌بندی Agent Skills و سرور MCP در یک واحد قابل حمل. به‌جای این‌که برای هر assistant یک پیکربندی جدا نگه دارید، ساختار دایرکتوری و manifest یکی است. همان استاندارد برای بقیهٔ پلاگین‌هایی که بعداً در همان مخزن بیایند هم باید رعایت شود.

اعلامیه صریحاً چند محیط را اسم می‌برد که با این layout نصب می‌شوند: **Antigravity**، **Claude Code**، **Codex CLI**. برای Antigravity نصب از مسیر پلاگین داخل مخزن Google Agent Skills است؛ برای Claude Code و Codex CLI اول marketplace پلاگین‌های گوگل اضافه می‌شود، بعد خود پلاگین.

مثال خود پست: بوت‌استرپ پروژهٔ تازه، حساب، billing، و بعد هویت سرویس به‌جای هویت آدم. عامل قرار است پیش‌نیاز CLI و پروژهٔ موجود را در پس‌زمینه چک کند، ریسک کلید و commit را از روی تمرین IAM ببیند، و قبل از دست زدن به resource یک نقشه بدهد. این یک demo است نه SLA؛ خود گوگل آن را به‌عنوان «plugin in action» آورده.

اگر روی Google Cloud کار می‌کنید، مسیر نصب در همان پست است؛ codelab جدا برای Antigravity هم معرفی شده. اگر کنجکاو مشخصات هستید، مخزن Agent Skills همان‌جایی است که گوگل برای نگاه به مهارت‌ها و پلاگین‌های امروز لینک داده — نه یک marketplace بستهٔ فقط-گوگل.

</div>
