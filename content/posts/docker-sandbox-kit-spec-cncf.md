---
title: "Docker Sandbox Kit Spec را به CNCF می‌برد؛ مجوز ایجنت مثل ایمیج OCI قابل حمل می‌شود"
date: 2026-09-29T09:40:00+03:30
draft: false
slug: "docker-sandbox-kit-spec-cncf"
tags: ["docker", "cncf", "sandbox-kit", "oci", "agents", "standards"]
categories: ["DevOps", "AI", "News"]
description: "اعلام ۲۴ سپتامبر: Kit به‌عنوان ایمیج OCI معمولی با فهرست تایپ‌شدهٔ دسترسی‌ها (host، credential، volume)؛ Apache 2.0 و حاکمیت خنثی CNCF. داستان استاندارد است، نه CVEهای Sandboxes 0.42."
image: "/images/docker-sandbox-kit-spec-cncf.png"
---

<div dir="rtl">

ده سال پیش صنعت بین فرمت ایمیج چندتکه و یک artifact مشترک یکی را انتخاب کرد؛ OCI برنده شد. ۲۴ سپتامبر ۲۰۲۶ در WeAreDevelopers، داکر همان منطق را برای **ایجنت** تکرار کرد: [Sandbox Kit Spec](https://www.docker.com/blog/docker-sandbox-kit-spec-cncf/) را متن‌باز Apache 2.0 اعلام کرد و گفت مشخصات را زیر حاکمیت خنثی **CNCF** می‌برد.

Kit از قبل داخل Docker Sandboxes راه بسته‌بندی ایجنت، ابزارها و محدودهٔ دسترسی بود. چیز تازه خود artifact است. یک Kit الان یک **ایمیج OCI معمولی** است — نه تایپ جدید و نه fork مشخصات OCI. از extension point موجود OCI استفاده می‌کند؛ build، push، pull، sign و scan مثل هر ایمیج دیگر است. داخلش سه چیز می‌آید: خود ایجنت، ابزارهایش، و فهرست تایپ‌شدهٔ چیزهایی که می‌خواهد لمس کند — hostها، credentialها، volumeها. پین کردن digest ایمیج، هم ایجنت و هم درخواست‌های دسترسی‌اش را با هم قفل می‌کند.

برای سرویس ثابت وب، ایمیج می‌گفت «چگونه ساخته شده» و دربارهٔ «چه کاری بعد از اجرا مجاز است» حرف نمی‌زد. ایجنت‌ها mutableاند: پکیج نصب می‌کنند، API می‌زنند، credential خرج می‌کنند. بدون فرمت مشترک، هر تیم قوانین را در shell history و داشبورد پنهان می‌کند. Kit همان سؤال را قابل‌حمل می‌کند: این ایجنت اجازهٔ چه کاری دارد؟ همکار pull می‌کند، reviewer diff می‌بیند، runtime منطبق enforce می‌کند. درخواست دسترسی جدید در نسخهٔ بعدی به‌صورت خط اضافه‌شده دیده می‌شود و می‌شود ردش کرد.

داکر با AWS، Box، Datadog، Dynatrace، JFrog، Snyk و دیگران Kit برای ابزارهایشان ساخته. Docker Sandboxes اولین runtimeی است که spec را enforce می‌کند؛ هدف صریح این است که تنها نباشد. مشخصات و تور عملی در [docker/sandbox-kit-spec](https://www.docker.com/blog/docker-sandbox-kit-spec/). این خبر استاندارد و اکوسیستم است — نه advisory امنیتی Sandboxes 0.42.

</div>
