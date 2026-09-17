---
title: "هشدار GKE درباره دورزدن زمینه امنیتی در بازیابی checkpoint کانتینرد"
date: 2026-09-17T06:40:00+03:30
draft: false
slug: "gke-gcp-2026-061-containerd-checkpoint"
tags: ["gke", "containerd", "criu", "checkpoint-restore", "cve"]
categories: ["Security", "DevOps", "Cloud"]
description: "۹ سپتامبر GCP-2026-061 برای GHSA-p7v4-vr35-mj6f (CVE هنوز نیامده). restore از checkpoint نامعتبر از CreateContainer زمینه امنیتی مقصد را رد می‌کند. GKE پیش‌فرض criu ندارد. با CVE-2026-53495 قاطی نشود."
image: "/images/gke-gcp-2026-061-containerd-checkpoint.png"
---

<div dir="rtl">

۹ سپتامبر ۲۰۲۶ گوگل در [بولتن‌های امنیتی GKE](https://docs.cloud.google.com/kubernetes-engine/security-bulletins) مورد **GCP-2026-061** را گذاشت. ارجاع: [GHSA-p7v4-vr35-mj6f](https://github.com/containerd/containerd/security/advisories/GHSA-p7v4-vr35-mj6f). **شماره CVE هنوز assign نشده.** شدت از دید GKE: **Medium**.

این همان [CVE-2026-53495](https://github.com/containerd/containerd/security/advisories/GHSA-7jxh-36q5-gcqv) نیست — آن نشت goroutine در ExecSync و DoS نود بود. اینجا مسیر **checkpoint/restore** است.

وقتی کانتینر از یک checkpoint نامعتبر یا تصویر OCI حاشیه‌دار از API **`CreateContainer`** برگردد، CRIU credential، capability، `no_new_privs` و seccomp را از **دادهٔ checkpoint** برمی‌گرداند، نه از `ContainerConfig` مقصد که ارکستراتور خواسته. مهاجمی که بتواند کانتینر را با checkpoint ساختگی اجرا کند، پروسه را root با cap کامل و بدون seccomp بالا می‌آورد، در حالی که سیاست کلاستر چیز دیگری خواسته. بدتر: وضعیت CRI همان کانفیگ **درخواستی** را گزارش می‌کند؛ اختلاف privilege از چشم kubelet پنهان می‌ماند.

## پیش‌فرض GKE در معرض نیست

جملهٔ بولتن را جدی بگیرید: **کلاسترهای GKE به‌صورت پیش‌فرض آسیب‌پذیر نیستند.** تصویر نود `criu` ندارد؛ بدون criu بازیابی ضمنی کار نمی‌کند. ساخت کانتینر معمولی در Standard و Autopilot اثر نمی‌بیند. Autopilot کانفیگ runtime سفارشی نمی‌دهد. Pod snapshot گول این مسیر restore ضمنی را نمی‌خورد.

خطر وقتی است که تصویر سفارشی **criu** نصب کند، یا روی containerd **≥۲٫۳٫۴ / ≥۲٫۲٫۷** گزینهٔ `enable_experimental_restore_via_create` را روشن کنید. در همین نسخه‌ها restore ضمنی پیش‌فرض **خاموش** است؛ روشن کردنش آسیب‌پذیری را برمی‌گرداند چون containerd حین restore پروسهٔ criu نمی‌تواند سیاست مقصد را enforce کند. containerd **۲٫۴** این مسیر را حذف می‌کند به نفع API سطح Pod در **KEP-5823**.

اگر criu روی نود دارید: کانتینرهای restoreشده از checkpoint نامعتبر را stop/delete/recreate کنید؛ فلگ تجربی را `false` بگذارید؛ لاگ را برای `"Found checkpoint of container"` و event deprecate با نام `io.containerd.deprecation/cri-create-container-checkpoint-restore` بگردید؛ `create pods` و رجیستری تصویر را محدود کنید. برای بقیهٔ GKE، این بولتن یعنی criu را خودتان روی نود نگذارید.

</div>
