---
title: "Firefox ESR ۱۵۳.۴ و MFSA2026-100؛ صف طولانی sandbox escape برای سازمانی‌ها"
date: 2026-09-29T13:30:00+03:30
draft: false
slug: "firefox-esr-153-4-mfsa2026-100"
tags: ["firefox", "esr", "mozilla", "cve", "sandbox", "enterprise"]
categories: ["Security", "Browsers"]
description: "موزیلا Firefox ESR 153.4 را با advisory با Impact high منتشر کرد؛ CVE جدا برای هر باگ، از جمله چندین sandbox escape و UAF در DOM و WebAssembly و WebRender."
image: "/images/firefox-esr-153-4-mfsa2026-100.png"
---

<div dir="rtl">

محیط‌های سازمانی که روی کانال **Firefox ESR** قفل شده‌اند، معمولاً از هیاهوی Stable عقب می‌مانند — تا وقتی advisory با برچسب high می‌آید. ۲۹ سپتامبر ۲۰۲۶ موزیلا **Firefox ESR ۱۵۳.۴** را همراه [MFSA2026-100](https://www.mozilla.org/en-US/security/advisories/mfsa2026-100/) منتشر کرد. Impact کل advisory: **high**.

تغییر رویهٔ مهم‌تر از یک شماره نسخه است: موزیلا دیگر مجموعه‌ای از باگ‌های memory-safety را داخل یک CVE جمع نمی‌کند؛ برای **هر باگ، advisory/CVE جدا** می‌دهد. نتیجه برای اپراتور ESR فهرستی بلند از HIGH است، نه یک شناسهٔ مبهم.

کلاس خطر تکرارشونده **sandbox escape** و **use-after-free** است؛ سطح‌ها از content processهای DOM تا XSLT، WebAssembly، Graphics/WebRender و Widget را پوشش می‌دهند. نمونه‌هایی که advisory صریح لیست کرده شامل **CVE-2026-100758، CVE-2026-100760، CVE-2026-100762، CVE-2026-100770، CVE-2026-100775، CVE-2026-100778، CVE-2026-100779** و موارد بسیار دیگر همان صفحه است — لازم نیست همه را در تیتر تکرار کرد؛ الگوی مشترک کافی است: فرار از sandbox یا فساد حافظه نزدیک مرز privilege.

برای تیم دسکتاپ سازمانی، این به‌روزرسانی حیاتی است. ESR را مثل «نسخهٔ آرام» نبینید؛ صف HIGH همین کانال را هدف گرفته. ۱۵۳.۴ را در حلقهٔ patch مدیریت‌شده جلو ببرید و بعد از rollout، نسخه‌های گیرمانده روی ۱۵۳.۳ و قبل را در inventory علامت بزنید.

</div>
