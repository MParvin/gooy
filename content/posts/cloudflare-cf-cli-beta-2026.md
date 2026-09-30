---
title: "`cf` کلادفلر به بتا آمد؛ یک CLI برای API عمومی و مسیر Workers"
date: 2026-09-30T14:55:00+03:30
draft: false
slug: "cloudflare-cf-cli-beta-2026"
tags: ["cloudflare", "cf", "cli", "wrangler", "workers", "devtools"]
categories: ["Cloud", "DevOps"]
description: "۲۸ سپتامبر: بتای cf با حدود ۲۹۰۰+ فرمان API و JSON، به‌علاوه cf init/dev/build/deploy برای Workers و cloudflare.config.ts. نصب global و cf auth login؛ cf migrate از Wrangler."
image: "/images/cloudflare-cf-cli-beta-2026.png"
---

<div dir="rtl">

تا امروز خیلی‌ها برای Workers سراغ Wrangler می‌رفتند و برای بقیهٔ سطح Cloudflare به داشبورد یا SDKهای پراکنده. [changelog رسمی ۲۸ سپتامبر ۲۰۲۶](https://developers.cloudflare.com/changelog/post/2026-09-28-cloudflare-cli-beta/) ابزار خط فرمان **`cf`** را در بتا گذاشت تا این دو دنیا را یکی کند.

روی کاغذ، `cf` برای **API عمومی Cloudflare** حدود **۲۹۰۰+** فرمان با خروجی **JSON** می‌آورد — مناسب اسکریپت و ایجنت، نه فقط انسان پشت ترمینال. جست‌وجوی فرمان با **`cf cli search`** کمک می‌کند در آن سطح بزرگ گم نشوید. مسیر Workers جداگانه حس می‌شود ولی زیر همان باینری است: **`cf init`** پروژه را با **`cloudflare.config.ts`** راه می‌اندازد، بعد **`cf dev` / `cf build` / `cf deploy`**. برای آمدن از Wrangler، **`cf migrate`** پیش‌بینی شده است.

نصب از npm / yarn / pnpm / bun به‌صورت global روی بستهٔ **`cf`**، سپس **`cf auth login`**. بتا است؛ سطح فرمان و رفتار ممکن است عوض شود — یعنی در CI production قبل از تثبیت API، pin نسخه و تست مهاجرت را جدی بگیرید.

اگر فقط هر از گاهی یک Worker Deploy می‌کنید، عجله برای دور انداختن Wrangler لازم نیست. اگر هر روز بین DNS، Workers، و ده‌ها endpoint دیگر API می‌زنید، بتای `cf` همان جایی است که یک toolchain واحد را امتحان می‌کند: یک باینری، JSON پیش‌فرض، و مسیر مهاجرت صریح.

</div>
