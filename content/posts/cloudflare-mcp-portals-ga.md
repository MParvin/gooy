---
title: "Cloudflare MCP server portals عمومی شد؛ یک endpoint برای agentهای تأییدشده"
date: 2026-09-24T12:30:00+03:30
draft: false
slug: "cloudflare-mcp-portals-ga"
tags: ["cloudflare", "mcp", "ai-agents", "security", "dlp", "platform"]
categories: ["Cloud", "Security"]
description: "پورتال‌های MCP سرور کلادفلر برای همهٔ مشتری‌ها GA شد: Gateway و DLP، Code Mode، OAuth استاتیک، session، service token و Logpush."
image: "/images/cloudflare-mcp-portals-ga.png"
---

<div dir="rtl">

وقتی agentهای AI به tool و prompt و resource وصل می‌شوند، سؤال پلتفرم ساده است: چه کسی، به کدام MCP server، با چه لاگی؟ ۲۴ سپتامبر ۲۰۲۶ کلادفلر در [changelog](https://developers.cloudflare.com/changelog/post/2026-09-24-mcp-portals-ga/) نوشت **MCP server portals** برای همهٔ مشتری‌ها **GA** شده است.

ایده همان یک endpoint برای سرورهای **Model Context Protocol** تأییدشده است. **Cloudflare Access** فعالیت tool و prompt و resource را لاگ می‌کند؛ یعنی مسیر دسترسی agent دیگر «جعبهٔ سیاه IDE» نیست.

از open beta تا GA چند قابلیت عملیاتی اضافه شده که برای تیم امنیت و پلتفرم سنگین‌ترند:

- **Gateway routing** برای HTTP logging و اسکن **DLP**
- سیاست‌های **Code Mode** تا تعریف tool و مصرف token کم شود
- **static OAuth client credentials** برای providerهایی که Dynamic Client Registration ندارند
- مدیریت **session**
- احراز هویت با **service token** برای agentهای autonomous و M2M
- **Logpush** به SIEM یا ذخیرهٔ خارجی

زاویهٔ فارسی ماجرا کنترل امن دسترسی agent به MCP است، نه فقط «پورتال قشنگ». اگر حریم خصوصی داده، DLP و audit برای شما خط قرمز است، GA شدن یعنی می‌شود این کنترل را از آزمایش خارج کرد و روی مسیر production گذاشت — با این فرض که فهرست سرورهای تأییدشده و سیاست Code Mode را جدی نگه دارید.

</div>
