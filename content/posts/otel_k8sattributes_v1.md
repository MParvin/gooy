---
title: "پردازنده ویژگی‌های کوبرنتیز در OpenTelemetry به نسخه پایدار ۱٫۰٫۰ رسید"
date: 2026-09-17T03:20:00+03:30
draft: false
slug: "otel-k8sattributes-v1"
tags: ["opentelemetry", "k8sattributes", "collector", "semconv", "observability"]
categories: ["DevOps", "Cloud"]
description: "۱۶ سپتامبر ۲۰۲۶: k8sattributes به v1.0.0 رسید بعد از پایدار شدن semantic conventions کوبرنتیز در v1.42.0 (ژوئن). تغییر نام attributeها breaking است؛ راهنمای مهاجرت منتشر شده."
image: "/images/otel-k8sattributes-v1.png"
---

<div dir="rtl">

۱۶ سپتامبر ۲۰۲۶، Christos Markou و Pablo Baeyens در [بلاگ OpenTelemetry](https://opentelemetry.io/blog/2026/k8s-attributes-processor-v1/) نوشتند پردازندهٔ **k8sattributes** رسماً **v1.0.0** شده است. در distroهای **opentelemetry-collector-contrib** و **opentelemetry-collector-k8s** هست؛ می‌شود به‌عنوان کتابخانهٔ Go هم redistribute کرد بدون این‌که API هر ریلیز زیرپا شود.

v1.0.0 یعنی معیارهای stable Collector — تست، بنچمارک، مستند، پایداری telemetry — برای این کامپوننت تیک خورده. SIG از اواخر ۲۰۲۵ روی «Stable by Default» کار می‌کرد؛ خود پردازنده نمی‌توانست پایدار شود تا semantic conventions مربوط به Kubernetes پایدار شود.

## وابستگی‌ای که تقویم را جلو برد

SIG مربوط به K8s Semantic Conventions از نوامبر ۲۰۲۵ متمرکز شد. مارس ۲۰۲۶ به Release Candidate رسید و **ژوئن ۲۰۲۶** در **Semantic Conventions v1.42.0** پایدار شد. از آن به بعد k8sattributes می‌تواند تله‌متری را با attributeهای پایدار K8s غنی کند.

فارغ‌التحصیلی چند هفته endorsement از کاربر production و vendor redistributor گرفت. PR نهایی که نام‌های جدید semconv و بقیهٔ تغییر promotion را اعمال کرد [collector-contrib#49152](https://github.com/open-telemetry/opentelemetry-collector-contrib/pull/49152) است؛ ۳ سپتامبر merge شد تا با ریلیز بعد از v0.160.0 بیاید. سیگنال‌های logs/traces/metrics به stable رفتند؛ feature gateهای schema در **beta** ماندند تا کل دورهٔ v1، و بعداً یا در v2 به stable می‌روند.

همین PR یعنی **شکستن نام attribute** برای کسی که از قبل پردازنده را در pipeline دارد. پست رسمی می‌گوید راهنمای مهاجرت نوشته شده؛ قبل از bump، query پرومتئوس، ایندکس Elasticsearch/ClickHouse و داشبوردی که کلید قدیمی `k8s.*` را می‌خواند با جدول rename چک کنید. dual-emission از طریق gateها در تست e2e همان PR پوشش داده شده، نه به‌عنوان پیش‌فرض ابدی.

این نقطهٔ پایان Collector نیست؛ فقط یکی از پراستفاده‌ترین پردازنده‌های K8s از حالت «تقریباً همه دارند» به قرارداد پایدار رسید.

</div>
