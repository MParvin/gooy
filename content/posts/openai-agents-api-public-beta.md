---
title: "OpenAI Agents API در بتای عمومی؛ harness کودکس برای ابر"
date: 2026-09-16T13:40:00+03:30
draft: false
slug: "openai-agents-api-public-beta"
tags: ["openai", "agents", "codex", "mcp", "api"]
categories: ["AI"]
description: "۱۰ سپتامبر ۲۰۲۶: بتای عمومی Agents API با harness مدیریت‌شدهٔ Codex، sandbox میزبان OpenAI یا شرکا، compaction، tool search، MCP و subagent. بدون هزینهٔ جدا غیر از token/tool."
image: "/images/openai-agents-api-public-beta.png"
---

<div dir="rtl">

۱۰ سپتامبر ۲۰۲۶ OpenAI در [معرفی Agents API](https://openai.com/index/introducing-the-agents-api/) نوشت همان harness و زیرساختی که Codex را سر پا نگه می‌دارد، حالا از یک API ساده در **بتای عمومی** در دسترس است. [سند overview](https://developers.openai.com/api/docs/guides/agents-api/overview) همان را این‌طور خلاصه می‌کند: OpenAI نشست، orchestration، فشرده‌سازی context و بازیابی را نگه می‌دارد؛ برنامهٔ شما ابزار و محیط اجرا را می‌دهد.

فراخوان نمونه در همان اعلامیه یک session می‌سازد — `client.beta.agents.sessions.create` — با مدل، ابزار MCP، `multi_agent` و یک environment. در docs هدر بتا `OpenAI-Beta: agents=v1` است.

## sandbox را شما انتخاب می‌کنید؛ harness را آن‌ها نگه می‌دارند

محیط اجرا سه شکل دارد: sandbox میزبان OpenAI (همان زیرساخت sandbox کودکس و ChatGPT)، زیرساخت خودتان، یا شریک. شرکایی که اعلامیه اسم برده: **Blaxel، Cloudflare، Daytona، DigitalOcean، E2B، Modal، Oracle، Runloop، Vercel**. بعضی fully managed، بعضی داخل VPC؛ CPU/GPU و cold-start را همان‌جا جدا می‌کنند.

هارنس از codebase متن‌باز Codex آمده؛ OpenAI آن را روی API راه می‌اندازد و شما منطق هماهنگی را می‌توانید در مخزن عمومی ببینید. نسخه با هر مدل عوض می‌شود تا هر بار harness را از نو ننویسید.

سه قابلیتی که خود اعلامیه به‌عنوان بهبود اخیر harness آورده:

- **context compaction** وقتی نشست به سقف context نزدیک می‌شود؛ لازم نیست منطق فشرده‌سازی خودتان را بسازید
- **tool search** تعریف ابزار مرتبط را به‌تدریج بار می‌کند؛ **programmatic tool calling** صداها را موازی و زنجیره می‌کند و نتیجه را در کد فیلتر می‌کند. MCP، function سفارشی، و ابزار داخلی مثل web search
- **subagent**: کار را تکه می‌کند، هر کدام context جدا دارد، عامل اصلی جمع می‌کند

docs همان چهار مفهوم را تکرار می‌کند: Agent، Environment، Session، Events/items. نشست state را نگه می‌دارد تا نوبت بعدی از صفر ساخته نشود.

## هزینهٔ جدا برای خود API نیست

اعلامیه: در بتای عمومی برای همهٔ developerها؛ **هزینهٔ اضافه برای خود Agents API نیست** — token و ابزاری که عامل مصرف می‌کند، طبق صفحهٔ قیمت. docs می‌گوید مدل با نرخ API همان مدل، ابزارهای OpenAI با نرخ خودشان، sandbox میزبان OpenAI با نرخ container.

محدودیت را docs همان‌جا نوشته: data residency فعلاً فقط ایالات متحده؛ **Zero Data Retention پشتیبانی نمی‌شود**، حتی اگر sandbox را self-hosted بگذارید ZDR نمی‌شود. بتا است؛ مسیر GA را به بازخورد گره زده‌اند.

</div>
