---
title: "Memory QoS در Kubernetes v1.37 به Beta رسید؛ پیش‌فرض روشن، بدون تغییر رفتار"
date: 2026-09-15T11:00:00+03:30
draft: false
tags: ["kubernetes", "memory-qos", "cgroup-v2", "kubelet", "sig-node"]
categories: ["DevOps"]
description: "گیت MemoryQoS در v1.37 بتا و پیش‌فرض روشن است؛ memoryThrottlingFactor دیگر null است تا ارتقا بی‌صدا memory.high ننویسد. reservation سیاستی در سطح کل نود است."
image: "/images/kubernetes-v1-37-memory-qos-beta.png"
---

<div dir="rtl">

معمولاً «feature gate بتا و default-on» یعنی رفتار کلاستر فردا صبح فرق می‌کند. برای **Memory QoS** در Kubernetes **v1.37** عمداً این‌طور نیست.

۱۴ سپتامبر Qi Wang و Sohan Kunkerkar از Red Hat در [بلاگ کوبرنتیز](https://kubernetes.io/blog/2026/09/14/kubernetes-v1-37-memory-qos-graduates-to-beta/) نوشتند گیت **`MemoryQoS`** بتا شده و روی هر kubelet نسخه ۱٫۳۷ بدون تغییر کانفیگ روشن است. روی نود لینوکس با **cgroup v2**، کنترلر حافظه راهنمایی دقیق‌تری به کرنل می‌دهد. قابلیت از Alpha در v1.22 آمده و در v1.36 reservation طبقه‌بندی‌شده گرفته. روشن بودن پیش‌فرض **امن** است چون کانفیگ پیش‌فرض kubelet نه throttling می‌نویسد نه reservation: هیچ `memory.high` و `memory.min` و `memory.low` روی cgroup نمی‌رود مگر خودتان بخواهید.

## چرا default فاکتور دیگر ۰٫۹ نیست

در Alpha، **`memoryThrottlingFactor`** پیش‌فرض **۰٫۹** بود. یعنی روشن کردن گیت، برای Burstable و BestEffort مقدار `memory.high` می‌گذاشت. حالا که گیت برای همه روشن است، همان ۰٫۹ می‌توانست workloadهایی را که تا دیروز throttle نمی‌شدند، بی‌خبر خفه کند.

در v1.37 پیش‌فرض **`null`** است. ارتقا به ۱٫۳۷ رفتار runtime کلاستر موجود را عوض نمی‌کند. اگر در فایل kubelet از قبل مقدار صریح گذاشته‌اید، همان می‌ماند. اگر فیلد را نداشته‌اید، `memory.high` دیگر ست نمی‌شود؛ برای ادامه throttling باید مثلاً `0.9` را صریح بنویسید.

## opt-in، نه جادوی مخفی

دو پیچ جدا:

1. `memoryThrottlingFactor` بین ۰ و ۱ → محاسبه `memory.high` برای Burstable و BestEffort
2. `memoryReservationPolicy: TieredReservation` → حفاظت طبقه‌ای با `memory.min` و `memory.low`

می‌شود فقط یکی را گرفت، یا هر دو، یا هیچ‌کدام. برای خاموش کردن کل قابلیت، گیت را `false` کنید. kubelet کانفیگ را رد می‌کند اگر throttling را روی چیزی غیر از ۰٫۹ قدیمی بگذارید یا reservation را Tiered بگذارید و بعد گیت را ببندید؛ اول فیلدها را بردارید. وقتی گیت خاموش است، روی cgroup v2 مقادیر کهنه را ریست می‌کند: `memory.min=0` و `memory.low=0` روی kubepods، و `memory.high` کانتینر روی مسیر restart/resize به `max`.

## محدودیتی که هنوز Beta را Beta نگه می‌دارد

**سیاست reservation برای کل نود است.** با `TieredReservation` هر Guaranteed می‌گیرد `memory.min` و هر Burstable می‌گیرد `memory.low`؛ opt-in پادبه‌پاد نیست. نودی که مخلوط workload سخت‌رزرو و قابل‌reclaim دارد باید یکی را برای همه انتخاب کند. رزرو سخت هر چیزی را که به cgroup کانتینر شارژ شود می‌پوشاند، از جمله page cache؛ پادی که فایل بزرگ می‌خواند ممکن است حافظه‌ای را نگه دارد که همسایه‌اش به آن نیاز دارد.

SIG Node هر دو را در [kubernetes/kubernetes#140246](https://github.com/kubernetes/kubernetes/issues/140246) دنبال می‌کند. قدم بعدی GA است؛ تا آن موقع این گیت را روشن بگذارید، و throttling/reservation را فقط وقتی در kubelet بنویسید که برای آن نود تصمیم گرفته‌اید.

</div>
