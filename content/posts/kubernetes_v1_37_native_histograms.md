---
title: "کوبرنتیز ۱٫۳۷ هیستوگرام‌های بومی پرومتئوس را به‌صورت پیش‌فرض در بتا فعال کرد"
date: 2026-09-17T04:00:00+03:30
draft: false
slug: "kubernetes-v1-37-native-histograms"
tags: ["kubernetes", "prometheus", "histograms", "kep-5808", "observability"]
categories: ["DevOps"]
description: "۱۱ سپتامبر: KEP-5808 در v1.37 بتا و default-on. dual-exposition کلاسیک+نمایی؛ BucketFactor 1.1 و MaxBucketNumber 160. پرومتئوس ۳: scrape_native_histograms و always_scrape_classic_histograms در مهاجرت."
image: "/images/kubernetes-v1-37-native-histograms.png"
---

<div dir="rtl">

Latency API server و زمان‌بندی scheduler سال‌ها با هیستوگرام کلاسیک پرومتئوس — سطل‌های ثابت `le` — export می‌شد. اگر توزیع عوض شود سطل‌ها کور می‌شوند؛ هر سطل یک time series جدا است؛ `histogram_quantile` بین مرزهای درشت interpolate می‌کند.

۱۱ سپتامبر ۲۰۲۶ Richa Banker در [بلاگ کوبرنتیز](https://kubernetes.io/blog/2026/09/11/kubernetes-v1-37-native-histograms-beta/) نوشت پشتیبانی **native histogram** — همان [KEP-5808](https://kubernetes.io/docs/reference/instrumentation/native-histograms/) که در v1.36 آلفا بود — در **v1.37 به Beta رسیده و پیش‌فرض روشن است**. native histogram سطل نمایی پویا را داخل **یک** time series می‌گذارد (schema، span مثبت/منفی، zero threshold). ادعا: وضوح بالاتر، تا حدود ۹۰٪ سری کمتر، و کران خطا روی چندک (حدود ۵٪ relative در تنظیم پیش‌فرض).

این خبر Memory QoS یا Workload-Aware Scheduling در ۱٫۳۷ نیست؛ مسیر SIG Instrumentation است، داخل `k8s.io/component-base/metrics`. پس kube-apiserver، scheduler، kubelet، controller-manager و kube-proxy همان dual-exposition را به ارث می‌برند.

## dual-exposition یعنی داشبورد امروز نباید بشکند

با گیت `NativeHistograms`، سطل کلاسیک هنوز emit می‌شود و span بومی در payload Protobuf کنارش می‌آید. متن scrape فقط سطل کلاسیک را می‌برد؛ native با مذاکرهٔ Protobuf می‌آید.

پیش‌فرض نمایی در component-base:

- `BucketFactor: 1.1` — هر سطل حداکثر ۱۰٪ از قبلی پهن‌تر؛ کران خطای چندک حدود ۵٪ از میلی‌ثانیه تا ثانیه
- `MaxBucketNumber: 160` — سقف حافظه مطابق توصیهٔ aggregation نمایی OpenTelemetry

برای Prometheus **3.x** در `scrape_configs` همان job:

```yaml
scrape_native_histograms: true
always_scrape_classic_histograms: true  # در دورهٔ مهاجرت
```

بدون فلگ دوم، پرومتئوس ۳ فقط native را می‌گیرد و سری `_bucket` / `_count` / `_sum` قطع می‌شود؛ داشبورد `histogram_quantile(..._bucket...)` خالی می‌ماند. پرومتئوس ۲٫۴۰ تا ۲٫x هنوز `--enable-feature=native-histograms` سراسری است.

rollback سریع سمت collector: `scrape_native_histograms: false` بدون restart کوبرنتیز. rollback سمت کامپوننت: `--feature-gates=NativeHistograms=false` (نیاز به restart). PromQL بومی روی خود نام متریک کار می‌کند، نه پسوند `_bucket`، و `sum by (le)` لازم نیست.

تا queryها مهاجرت نکرده‌اند dual-scrape را نگه دارید؛ ذخیره را وقتی `_bucket` را خاموش کنید که SLO همان اعداد را از native نشان بدهد.

</div>
