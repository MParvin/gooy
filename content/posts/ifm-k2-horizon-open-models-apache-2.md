---
title: "IFM شش مدل K2 Horizon را با Apache 2.0 باز کرد؛ از ۰٫۹B تا MoE کلاس ۳۷۵B"
date: 2026-09-15T15:56:00+03:30
draft: false
tags: ["ifm", "k2-horizon", "llm", "apache-2", "opensource", "ai"]
categories: ["AI", "Open-source"]
description: "ناوگان K2 Horizon از IFM/MBZUAI: شش مدل Apache 2.0 با حدود ۲۰ تریلیون توکن، پشتیبانی vLLM/SGLang/Ollama روی NVIDIA و AMD و Cerebras."
image: "/images/ifm-k2-horizon-open-models.png"
---

<div dir="rtl">

اوایل سپتامبر ۲۰۲۶، Institute of Foundation Models در [ifm.ai/blog/k2](https://ifm.ai/blog/k2/) ناوگان **K2 Horizon** را معرفی کرد؛ پوشش‌هایی مثل [MarkTechPost در ۶ سپتامبر](https://www.marktechpost.com/2026/09/06/ifm-releases-k2-horizon-six-apache-2-0-models-from-0-9b-to-375b/) همان هفته آن را پخش کردند. IFM لبز frontier وابسته به MBZUAI است. این‌بار یک چک‌پوینت تنها نیست: **شش مدل** با معماری و tooling مشترک.

اندازه‌ها: **375B-A23B** (MoE، حدود ۲۳B فعال در هر توکن)، **36B-A4B** با معماری MoVA، dense **32B**، بعد **7B**، **3.7B** و **0.9B**. وزن و کد زیر **Apache 2.0** است. دیتاست‌ها لایسنس خودشان را دارند (مثلاً ODC-BY)؛ جایی که redistribution ممکن نیست، روش ساخت و mix را افشا می‌کنند. IFM می‌گوید برای هر مدل چرخهٔ آموزش را باز می‌کند: داده یا دستور پخت، کد، کانفیگ، چک‌پوینت میانی، لاگ ریز، ارزیابی، وزن نهایی. روی Hugging Face این کامل‌بودن هنوز برای همهٔ سایزها یکسان نیست؛ مثلاً کارت 375B نوشته وزن نهایی آمده و چک‌پوینت میانی و داده و کد **در راه است**. پس «کاملاً باز» را باید مدل‌به‌مدل چک کرد، نه از روی بیانیه.

هر مدل حدود **۲۰ تریلیون توکن** pretrain شده. زمینهٔ طولانی در کارت‌های رسمی آمده: پنج سایز بزرگ‌تر تا **۵۱۲K** (۵۲۴٬۲۸۸ توکن)، مدل ۰٫۹B تا **۱۲۸K**. پشتیبانی روز صفر: **vLLM، SGLang، Ollama**؛ سخت‌افزار **NVIDIA، AMD، Cerebras**. API میزبانی‌شده از مسیر شریک‌هایی مثل Compass و Cerebras و Nebius.

## یک ناوگان، نه شش مدل بی‌ربط

۰٫۹B برای محیط تنگ مثل ساعت و عینک است؛ ۳٫۷B و ۷B برای روی دستگاه؛ 32B dense و 36B-A4B برای ورک‌استیشن و سروینگ کارآمد؛ 375B برای کار سازمانی سنگین. واژگان ۰٫۹B کوچک‌تر است؛ بقیه stack را یکی نگه داشته‌اند تا prototype روی ۳٫۷B و scale به 375B بدون عوض کردن serving ممکن باشد.

MoVA (Mixture-of-Value Attention) sparsity را به خود attention می‌برد، نه فقط لایهٔ feed-forward؛ 36B-A4B حدود ۴B پارامتر در هر توکن فعال می‌کند. IFM همچنین adapterی به نام Uno برای سرعت decode در سایزهای کوچک‌تر توصیف کرده. روی بنچمارک‌ها، خود IFM یک audit پاداش‌هک برای 375B روی Terminal-Bench منتشر کرده و دقت ۷۰٫۲٪ را بعد از حذف trial مشکوک به ۶۶٫۹٪ اصلاح کرده — همان چیزی که معمولاً در اعلام مدل‌های «باز» جا می‌افتد.

اگر دنبال وزن باز با لایسنس Apache و مسیر واقعی برای edge تا MoE بزرگ هستید، مخزن [huggingface.co/IFM](https://huggingface.co/IFM) نقطهٔ شروع است؛ قبل از تولید، ببینید برای همان سایز چه artifactهایی واقعاً آپلود شده.

</div>
