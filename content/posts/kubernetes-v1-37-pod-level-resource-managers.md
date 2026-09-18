---
title: "مدیرهای منبع پاد-سطح در v1.37 بتا شدند؛ sidecar دیگر هسته انحصاری نمی‌خواهد"
date: 2026-09-15T17:00:00+03:30
draft: false
slug: "kubernetes-v1-37-pod-level-resource-managers"
tags: ["kubernetes", "kubelet", "numa", "cpu-manager", "sig-node"]
categories: ["DevOps"]
description: "۱۵ سپتامبر: گیت PodLevelResourceManagers بتا و opt-in (پیش‌فرض خاموش). Topology/CPU/Memory Manager از spec.resources پاد استفاده می‌کنند. API پادسطح cpu_ids و memory گزارش می‌دهد."
image: "/images/kubernetes-v1-37-pod-level-resource-managers.png"
---

<div dir="rtl">

برای کار حساس به تأخیر، هسته انحصاری و حافظه هم‌تراز NUMA معمولاً یعنی همه کانتینرهای پاد request صحیح بگیرند — یا هیچ‌کدام. sidecar لاگ یا telemetry هم یک هسته فیزیکی می‌خواست. ۱۵ سپتامبر ۲۰۲۶ کوین تورس مارتینز از گوگل در [بلاگ کوبرنتیز](https://kubernetes.io/blog/2026/09/15/kubernetes-v1-37-pod-level-resource-managers-beta/) نوشت این بده‌بستان در **v1.37** دیگر اجباری نیست.

**Pod-Level Resource Managers** در v1.36 آلفا بود. بتا روی گیت **`PodLevelResourceManagers`** است: **opt-in، پیش‌فرض خاموش**. با روشن کردنش، Topology Manager و CPU Manager و Memory Manager مستقیماً از **`.spec.resources`** سطح پاد برای تصمیم placement سخت‌افزار استفاده می‌کنند — نه فقط از جمع requestهای کانتینر.

مدل جدید هیبرید است. کانتینر اصلی می‌تواند CPU/حافظه انحصاری و NUMA-aligned بگیرد؛ sidecarهای غیر-Guaranteed می‌روند داخل **استخر اشتراکی ایزوله‌شده همان پاد**. sidecar از تداخل بقیه نود در امان می‌ماند و NUMA محلی می‌بیند، بدون این‌که هسته اختصاصی مصرف کند. کانتینر اصلی unthrottled می‌ماند.

این را با Memory QoS همان هفته عوض نگیرید: آن گیت default-on است و درباره `memory.high` روی cgroup حرف می‌زند. این یکی درباره **هم‌ترازی سخت‌افزار** است و تا شما گیت را روشن نکنید هیچ نودی رفتارش عوض نمی‌شود.

## چیزی که Beta به API اضافه کرد

سرویس gRPC **`PodResourcesLister`** (نسخه v1) حالا فیلدهای سطح‌بالای **`cpu_ids`** و **`memory`** را روی پاسخ `PodResources` می‌گذارد. ابزار مانیتورینگ و device plugin می‌توانند تخصیص انحصاری پاد را بخوانند بدون این‌که تخصیص کانتینرها را دو بار بشمارند.

مستندات رسمی مسیر عملی را جدا کرده‌اند: [مرجع مدیران منبع پاد-سطح](https://kubernetes.io/docs/concepts/policy/resource-managers/)، آموزش پیکربندی workload، و صفحه assign کردن CPU/حافظه در سطح پاد. بازخورد Beta از کانال `#sig-node` و ایشوهای kubernetes/kubernetes جمع می‌شود؛ GA هنوز اعلام نشده.

اگر امروز برای Guaranteed کردن یک پاد با sidecar مجبورید به exporter هم request صحیح بدهید، این گیت همان جایی است که باید در staging روشن شود — نه روی همه نودهای latency-critical بدون آزمایش NUMA.

</div>
