---
title: "Graphalgo به Terraform Registry و ماژول‌های Go رسید؛ typosquat در زنجیرهٔ IaC"
date: 2026-09-23T09:00:00+03:30
draft: false
slug: "graphalgo-terraform-go-modules"
tags: ["supply-chain", "terraform", "golang", "malware", "graphalgo", "security"]
categories: ["Security", "DevOps"]
description: "کمپین Graphalgo برای اولین‌بار Registry متمرکز HashiCorp را برای توزیع بدافزار به‌کار برد؛ providerها و ماژول‌های مخرب Go با C2 مشترک بلاکچین و Slack."
image: "/images/graphalgo-terraform-go-modules.png"
---

<div dir="rtl">

زنجیرهٔ تأمین دیگر فقط npm نیست. حدود ۲۲–۲۳ سپتامبر ۲۰۲۶ گزارش‌های [The Hacker News](https://thehackernews.com/2026/09/attackers-use-malicious-terraform.html) و [Aikido](https://www.aikido.dev/blog/graphalgo-terraform-go-modules) نشان دادند نسب **Graphalgo** — که قبلاً روی npm و PyPI دیده شده و با فعالیت‌های هم‌پوشان DPRK/Graphalgo شناخته می‌شود — برای **اولین‌بار در این lineage** از **HashiCorp Terraform Registry** متمرکز به‌عنوان کانال توزیع بدافزار استفاده کرده است.

## provider و ماژول جعلی

دو Terraform provider مخرب پرچم خورده‌اند:

- `gocommunity-io/dockerd`
- `kreuzwenker/docker` — typosquat واضح روی `kreuzwerker/docker`

و دو ماژول Go:

- `gocommunity.io/orderedbtree`
- `gogets.dev/btreex`

پورت Go همان الگوی dead drop روی smart contractهای **Ethereum/Arbitrum Sepolia** و **Slack C2** را با variantهای npm Graphalgo شریک است. تحویل اغلب از مسیر مهندسی اجتماعی شغل/مصاحبهٔ جعلی است: قربانی «پروژهٔ تست» را اجرا می‌کند، host info جمع می‌شود، C2 دوگانه بالا می‌آید و فرمان‌های Go/JS اجرا می‌شوند. همان هفته بسته‌های npm مرتبط هم علامت خوردند.

## دفاع عملی برای تیم IaC

قفل‌ها را جدی بگیرید: lockfile، کش provider، و `go.mod`/`go.sum`. hostهایی که این نام‌ها را نصب کرده‌اند ایزوله کنید و credentialها را بچرخانید. typosquat در Registry یعنی `terraform init` دیگر فرض بی‌گناهی ندارد — نام نزدیک به provider محبوب، دقیقاً همان بردار است.

</div>
