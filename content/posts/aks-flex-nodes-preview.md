---
title: "Flex nodes در AKS: ورکر چندمنطقه‌ای و آن‌پرم زیر یک API server"
date: 2026-09-30T14:50:00+03:30
draft: false
slug: "aks-flex-nodes-preview"
tags: ["aks", "azure", "kubernetes", "flex-nodes", "edge", "gpu", "preview"]
categories: ["Cloud", "DevOps"]
description: "پیش‌نمایش عمومی ۲۲ سپتامبر: افزودن node pool استاندارد AKS در Region دیگر، on-prem یا edge روی overlay رمزشده، با یک کنترل‌پلن. احراز با managed identity، Arc یا service principal."
image: "/images/aks-flex-nodes-preview.png"
---

<div dir="rtl">

کمبود GPU در یک Region، یا الزام data-residency روی سایت کارخانه، معمولاً به «یک کلاستر دوم» ختم می‌شود: کنترل‌پلن اضافه، شبکه اضافه، دردسر GitOps اضافه. ۲۲ سپتامبر ۲۰۲۶ تیم AKS در [پست flex nodes](https://blog.aks.azure.com/2026/09/22/flex-nodes-for-aks) پیش‌نمایش عمومی مدلی را گذاشت که همان کلاستر موجود را امتداد می‌دهد.

**Flex nodes** اجازه می‌دهند به یک کلاستر AKS، ورکرهایی در **Region دیگر Azure**، روی **on-premises**، یا در **edge** اضافه کنید. ارتباط روی یک **encrypted overlay** است و از دید API، این‌ها **node poolهای استاندارد** زیر **همان API server** هستند — نه federation جدا و نه کلاستر پیوسته با tooling متفاوت.

سناریوهایی که خود پست برجسته می‌کند familiarاند: کشیدن ظرفیت CPU/GPU از منطقه‌ای که موجودی دارد؛ جمع کردن چند سایت؛ و pin کردن داده با **taint** و **selector** تا پاد حساس از Region/سایت درست بیرون نرود. احراز هویت ورکرها از مسیر **managed identity**، **Azure Arc**، یا **service principal** پشتیبانی می‌شود.

Preview است؛ سطح SLA و محدودیت‌های شبکه را قبل از production فرض نکنید. ولی برای تیم پلتفرمی که از ساختن کلاستر دوم فقط به‌خاطر ظرفیت یا residency خسته شده، ایده روشن است: یک کنترل‌پلن، ظرفیت پخش‌شده، سیاست زمان‌بندی معمول کوبرنتیز. اگر امروز برای GPU یا edge به کلاستر موازی رسیده‌اید، flex nodes همان آزمایشی است که روی non-prod باید یک‌بار اندازه بگیرید.

</div>
