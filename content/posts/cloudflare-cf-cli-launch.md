---
title: "کلادفلر `cf` را اوپن‌بتا کرد؛ CLI برای ۳۰۰۰+ عملیات و ایجنت‌های کدنویس"
date: 2026-09-29T16:35:00+03:30
draft: false
slug: "cloudflare-cf-cli-launch"
tags: ["cloudflare", "cf-cli", "wrangler", "devtools", "agents", "typescript"]
categories: ["Cloud", "DevOps", "AI", "News"]
description: "۲۸ سپتامبر ۲۰۲۶: CLI جدید cf با پوشش ۳۰۰۰+ عملیات API در برابر حدود ۲۸۰ مورد Wrangler، خروجی JSON پیش‌فرض، cf cli search، cloudflare.config.ts و Vite برای dev محلی. مسیر مهاجرت: cf migrate."
image: "/images/cloudflare-cf-cli-launch.png"
---

<div dir="rtl">

۲۸ سپتامبر ۲۰۲۶ کلادفلر در [پست رسمی](https://blog.cloudflare.com/cloudflare-cf-cli-launch/) ابزار خط فرمان جدیدش را با نام **`cf`** به open beta گذاشت. مخاطب صریحش انسان‌هایی است که هر روز API می‌زنند — و ایجنت‌های کدنویسی که باید همان کار را بدون داشبورد کلیک‌کردنی انجام دهند.

اعدادی که خودشان برجسته کرده‌اند روشن است: Wrangler حدود **۲۸۰** عملیات را پوشش می‌دهد؛ `cf` می‌گوید به **۳۰۰۰+** عملیات API می‌رسد. خروجی پیش‌فرض **JSON** است تا پارس برای اسکریپت و مدل آسان باشد. جست‌وجوی زبان طبیعی با `cf cli search` کمک می‌کند فرمان درست را پیدا کنید بدون اینکه کل سطح API را حفظ باشید. پیکربندی TypeScript در **`cloudflare.config.ts`** می‌آید و مسیر local/dev پیش‌فرض روی **Vite** نشسته است.

مهاجرت از Wrangler با **`cf migrate`** طراحی شده؛ Wrangler بعد از بتای `cf` یک پنجرهٔ deprecation طولانی می‌گیرد، نه قطع ناگهانی. این خبر را با پست صبحگاهی نشت دیسک Containers یا اعلام Docker Sandbox Kit به CNCF یکی نکنید — موضوع این‌جا ابزار CLI و سطح پوشش API است، نه CVE و نه استاندارد sandbox.

اگر امروز هنوز Wrangler را برای Workers روزمره دارید، لازم نیست فردا همه چیز را عوض کنید؛ ولی برای اتوماسیون و ایجنت، بتای `cf` همان سطحی است که باید در pipeline آزمایشی یک‌بار امتحان شود.

</div>
