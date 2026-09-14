---
title: "Karmada از CNCF فارغ‌التحصیل شد: ارکستراسیون چندکلاستری به بلوغ رسید"
date: 2026-09-14T11:30:00+03:30
draft: false
tags: ["karmada", "cncf", "kubernetes", "multi-cluster", "kubecon"]
categories: ["DevOps"]
description: "CNCF در KubeCon چین پروژه Karmada را به سطح Graduation رساند؛ ارکستراسیون اپلیکیشن روی چند کلاستر Kubernetes بدون تغییر خود اپ."
---

<div dir="rtl">

## چه اتفاقی افتاد؟

در KubeCon + CloudNativeCon + OpenInfra Summit + PyTorch Conference China 2026 در شانگهای، [CNCF فارغ‌التحصیلی Karmada را اعلام کرد](https://www.cncf.io/announcements/2026/09/07/cloud-native-computing-foundation-announces-karmada-graduation/). صفحه اعلام روی ۷ سپتامبر تاریخ خورده؛ متن خبر ۸ سپتامبر ۲۰۲۶ را به‌عنوان روز اعلام در کنفرانس می‌آورد. هر دو داخل همین پنجره است.

Karmada مخفف Kubernetes Armada است: اپ را روی چند کلاستر Kubernetes، چند cloud و چند region اجرا می‌کنید **بدون این‌که خود اپ را عوض کنید**. API استاندارد Kubernetes را با placement متمرکز، propagation، failover و autoscaling چندکلاستری گسترش می‌دهد.

این اولین باری است که سه foundation روی یک صحنه در چین جمع شده‌اند؛ خود CNCF این را به نیاز رو به رشد ارکستراسیون بین دیتاسنتر خصوصی، cloud عمومی و سخت‌افزار AI ربط داده است.

---

## مسیر بلوغ پروژه

- اولین commit: نوامبر ۲۰۲۰
- ورود به CNCF به‌عنوان Sandbox: سپتامبر ۲۰۲۱
- Incubating: دسامبر ۲۰۲۳
- Graduation: سپتامبر ۲۰۲۶

برای Graduation، پروژه audit امنیتی ثالث، steering committee رسمی، Code of Conduct CNCF و نشان CII Best Practices را تکمیل کرده است.

اعداد اعلام‌شده CNCF: بیش از **۱۲۱۴** contributor از **۲۹۲** سازمان، بیش از **۵۶۰۰** ستاره GitHub. Maintainerها در شش سازمان پخش‌اند.

نسخه **v1.19** همزمان مطرح شده: زمان‌بندی چندجزئی برای jobهای آموزش توزیع‌شده AI، و ارتقای priority-based scheduling به Beta (به‌صورت پیش‌فرض روشن). Roadmap ۲۰۲۶ شامل preemption مبتنی بر اولویت، صف چندکلاستری برای training/batch، و پشتیبانی چندکلاستری از Dynamic Resource Allocation برای GPU و شتاب‌دهنده‌هاست.

Karmada با observability موجود CNCF هم حرف می‌زند: متریک Prometheus روی control plane، etcd برای state، و Helm chart برای نصب. سایت پروژه: [karmada.io](https://karmada.io/).

---

## چه کسانی در production استفاده می‌کنند؟

CNCF از Bloomberg و Wellhub در سطح جهانی نام برده، و در آسیا از Alibaba Cloud، Huawei، Trip.com، Bilibili، iFLYTEK، JDCloud، Kuaishou، SenseTime، Vivo، WPS، ZTO و دیگران. موارد استفاده اعلام‌شده: ظرفیت hybrid، تاب‌آوری چندمنطقه‌ای، توزیع ترافیک، آموزش AI، زمان‌بندی GPU/CPU، تحویل اپ چندکلاستری.

نقل قول‌های پشتیبانی در اعلام رسمی از Bloomberg (failover و ساده‌سازی تجربه تیم‌های اپ)، Trip.com (چند کلاستر به‌عنوان یک resource pool بدون تغییر تعریف ریسورس Kubernetes) و DaoCloud (استراتژی چندابری و مسیر inference چندکلاستری) آمده است.

Chris Aniszczyk، CTOی CNCF، گفته وقتی Kubernetes روی چند کلاستر و محیط GPU تنگ مقیاس می‌شود، یک راه production-ready برای هماهنگ کردن ناوگان حیاتی است.

---

## چرا این خبر برای DevOps مهم است؟

فارغ‌التحصیلی CNCF یعنی پروژه از نظر حاکمیت، امنیت و بلوغ API از «ابزار جالب» به «زیرساختی که می‌شود رویش شرط بست» نزدیک‌تر شده. اگر امروز چند کلاستر را با اسکریپت و GitOps دستی کنار هم نگه داشته‌اید، Karmada دقیقاً همان لایه کنترل متمرکز است که API را عوض نمی‌کند.

این خبر محصول نیست؛ سیگنال اکوسیستم است: multi-cluster دیگر ویژگی لوکس نیست، مخصوصاً وقتی training و inference از یک کلاستر جا نمی‌شوند.

---

## منابع

- [CNCF: Announces Karmada Graduation](https://www.cncf.io/announcements/2026/09/07/cloud-native-computing-foundation-announces-karmada-graduation/)
- [Karmada](https://karmada.io/)

</div>
