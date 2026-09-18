---
title: "MemoryQoS در Kubernetes v1.37 بتا و روشن است؛ throttling دیگر پیش‌فرض نیست"
date: 2026-09-14T16:00:00+03:30
draft: false
slug: "kubernetes-v1-37-memory-qos-graduates-beta"
tags: ["kubernetes", "memory-qos", "cgroup-v2", "kubelet", "sig-node"]
categories: ["DevOps"]
description: "۱۴ سپتامبر: گیت MemoryQoS بتا و default-on روی cgroup v2. پیش‌فرض memoryThrottlingFactor حالا null است تا ارتقا بی‌صدا throttle نکند. reservation هنوز سیاست کل نود است."
image: "/images/kubernetes-v1-37-memory-qos-graduates-beta.png"
---

<div dir="rtl">

از Alpha نسخه ۱٫۲۲ تا امروز، روشن کردن **Memory QoS** یعنی kubelet روی cgroup v2 مقدار `memory.high` می‌نوشت. فاکتور پیش‌فرض **۰٫۹** بود. ۱۴ سپتامبر ۲۰۲۶ چی وانگ و سوهان کانکرکار از Red Hat در [بلاگ کوبرنتیز](https://kubernetes.io/blog/2026/09/14/kubernetes-v1-37-memory-qos-graduates-to-beta/) نوشتند همان گیت در **v1.37** بتا و روی هر kubelet ۱٫۳۷ **بدون تغییر کانفیگ روشن** است. اگر فاکتور ۰٫۹ می‌ماند، ارتقا می‌توانست workloadهایی را که تا دیروز throttle نمی‌شدند، صبح بعد از upgrade خفه کند.

برای همین پیش‌فرض **`memoryThrottlingFactor` حالا `null` است**. گیت روشن است؛ رفتار runtime کلاستر موجود عوض نمی‌شود. هیچ `memory.high` و `memory.min` و `memory.low` روی cgroup نمی‌رود مگر خودتان در KubeletConfiguration بنویسید. اگر فایل kubelet از قبل مقدار صریح داشته، همان می‌ماند.

```yaml
apiVersion: kubelet.config.k8s.io/v1beta1
kind: KubeletConfiguration
memoryThrottlingFactor: 0.9          # اختیاری؛ throttling برای Burstable/BestEffort
memoryReservationPolicy: TieredReservation  # اختیاری؛ memory.min / memory.low
```

می‌شود فقط یکی را گرفت، هر دو، یا هیچ‌کدام. `TieredReservation` در v1.36 به Alpha آمده بود؛ Guaranteed می‌گیرد `memory.min`، Burstable می‌گیرد `memory.low`. برای خاموش کردن کل قابلیت:

```yaml
featureGates:
  MemoryQoS: false
```

kubelet کانفیگ را رد می‌کند اگر throttling را روی چیزی غیر از ۰٫۹ قدیمی بگذارید، یا reservation را Tiered بگذارید و بعد گیت را ببندید. اول فیلدها را بردارید. وقتی گیت خاموش است، روی cgroup v2 مقادیر کهنه ریست می‌شوند: `memory.min=0` و `memory.low=0` روی kubepods، و `memory.high` کانتینر روی مسیر restart/resize به `max`.

## جایی که Beta هنوز Beta است

**سیاست reservation برای کل نود است.** opt-in پادبه‌پاد نیست. نودی که مخلوط workload سخت‌رزرو و قابل‌reclaim دارد باید یکی را برای همه انتخاب کند. رزرو سخت هر چیزی را که به cgroup کانتینر شارژ شود می‌پوشاند، از جمله page cache؛ پادی که فایل بزرگ می‌خواند ممکن است حافظه‌ای را نگه دارد که همسایه‌اش لازم دارد.

SIG Node هر دو را در [kubernetes/kubernetes#140246](https://github.com/kubernetes/kubernetes/issues/140246) دنبال می‌کند. KEP-2570 مسیر GA است. تا آن موقع گیت را روشن بگذارید — هزینه پیش‌فرض صفر است — و throttling یا reservation را فقط وقتی در kubelet بنویسید که برای آن نود تصمیم گرفته‌اید. لینوکس با cgroup v2؛ بدون آن این کنترلر حرفی برای گفتن ندارد.

</div>
