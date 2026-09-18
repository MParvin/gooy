---
title: "چهار نقش دانه‌ریز برای هر Worker: دسترسی جدا برای همکار، agent و CI"
date: 2026-09-15T16:20:00+03:30
draft: false
slug: "cloudflare-workers-granular-authorization"
tags: ["cloudflare", "workers", "iam", "rbac", "agents"]
categories: ["Cloud", "DevOps"]
description: "۱۵ سپتامبر: چهار نقش جدید (Metadata/Content Read-Only، Editor، Admin) قابل‌اعمال روی یک Worker. Durable Objects از دسترسی همان Worker ارث می‌برند. داشبورد، API و Terraform."
image: "/images/cloudflare-workers-granular-authorization.png"
---

<div dir="rtl">

بدترین حالت برای تیمی که agent را هم وارد pipeline کرده این نیست که agent باگ داشته باشد؛ این است که توکنش به **همه** Workerهای حساب برسد. ۱۵ سپتامبر ۲۰۲۶ دینا کوزلوف، آنتونی اورگلیا و ویسال این در [بلاگ کلادفلر](https://blog.cloudflare.com/workers-granular-authorization/) نوشتند دسترسی را می‌شود به **یک Worker مشخص** قفل کرد — برای انسان، برای agent، برای CI.

چهار نقش جدید آمده، برای همه مشتری‌ها:

| نقش | چه می‌کند | برای چه |
| --- | --- | --- |
| **Metadata Read-Only** | لیست، تنظیمات، متریک، لاگ، trace؛ بدون محتوای محصول | دیباگ بدون دیدن سورس |
| **Content Read-Only** | خواندن کد Worker (یا بعداً داده D1 و مشابه) بدون تغییر | مرور کد، بدون دیپلوی |
| **Editor** | خواندن و نوشتن محتوا و به‌روز کردن تنظیمات؛ ساخت و حذف منبع ممنوع | CI که باید دیپلوی کند و حق delete ندارد |
| **Admin** | کنترل کامل همان منبع، از جمله حذف و دادن دسترسی به دیگران | مالک همان اپ، نه کل حساب |

هر نقش روی یکی از سه scope سوار می‌شود: کل Developer Platform، کل یک محصول (مثلاً همه Workerها)، یا **یک منبع**. ترکیب نقش و scope همان least-privilege است که قبلاً با نقش‌های پهن Workers Scripts Edit مجبور بودید ول کنید.

## چیزی که نقش Worker به‌تنهایی نمی‌خرد

Route و Custom Domain جدا هستند. عوض کردن `example.com/*` می‌تواند ترافیک production را بدزدد. برای add/change/remove مسیر، هم Editor روی Worker لازم است هم مجوز **Workers Routes** روی zone. بعد از این‌که مسیر نشست، CI می‌تواند نسخه جدید را بدون دسترسی به دامنه یا D1/R2 دیپلوی کند — تا وقتی اتصال را عوض نکند.

**Durable Objects** نقش جدا ندارند. دسترسی‌شان از Worker پیاده‌ساز ارث می‌رسد. Metadata Read-Only متریک و لاگ DO را می‌دهد، نه داده ذخیره‌شده. Data Studio که مستقیم به state دست می‌زند **Editor** می‌خواهد.

خطای API دیگر فقط 403 خالی نیست؛ لینک به سندی می‌دهد که همان permission لازم را نشان می‌دهد — برای agent که باید بفهمد چه کم دارد، نه این‌که Admin بخواهد.

پیکربندی از داشبورد (Manage Account → Members)، API token با scope per-Worker، Terraform، و User Group برای تیم‌هایی که همه یک policy می‌خواهند. نقش‌های قدیمی (Workers Scripts Read/Edit، Observability Read و بقیه) deprecate نشده‌اند و تاریخ حذف ندارند؛ فقط granular نیستند. توصیه خود پست: به نقش‌های جدید مهاجرت کنید.

قدم بعد همان چهار نقش روی KV، D1 و R2 است. امروز فقط Workers این مدل را دارد؛ اگر agentتان باید یک اپ را لمس کند و بقیه حساب را نه، از همین‌جا شروع کنید.

</div>
