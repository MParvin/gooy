---
title: "Karmada از CNCF فارغ‌التحصیل شد: ارکستراسیون چندکلاستری به بلوغ رسید"
date: 2026-09-14T11:30:00+03:30
draft: false
tags: ["karmada", "cncf", "kubernetes", "multi-cluster", "kubecon"]
categories: ["DevOps"]
description: "CNCF در KubeCon چین پروژه Karmada را به سطح Graduation رساند؛ ارکستراسیون اپلیکیشن روی چند کلاستر Kubernetes بدون تغییر خود اپ."
image: "/images/cncf-karmada-graduation.png"
---

<div dir="rtl">

در شانگهای، روی صحنه مشترک **KubeCon + CloudNativeCon + OpenInfra Summit + PyTorch Conference China 2026**، سه foundation برای اولین بار در چین کنار هم ایستادند. [CNCF همان‌جا فارغ‌التحصیلی Karmada را اعلام کرد](https://www.cncf.io/announcements/2026/09/07/cloud-native-computing-foundation-announces-karmada-graduation/). صفحه اعلام روی ۷ سپتامبر تاریخ خورده؛ متن خبر ۸ سپتامبر ۲۰۲۶ را به‌عنوان روز اعلام در کنفرانس می‌آورد. هر دو داخل همین پنجره است.

خود CNCF این اجتماع را به نیاز رو به رشد ارکستراسیون بین دیتاسنتر خصوصی، cloud عمومی و سخت‌افزار AI ربط داده است.

## Kubernetes Armada

Karmada مخفف Kubernetes Armada است: اپ را روی چند کلاستر Kubernetes، چند cloud و چند region اجرا می‌کنید **بدون این‌که خود اپ را عوض کنید**. API استاندارد Kubernetes را با placement متمرکز، propagation، failover و autoscaling چندکلاستری گسترش می‌دهد. سایت پروژه: [karmada.io](https://karmada.io/).

اگر امروز چند کلاستر را با اسکریپت و GitOps دستی کنار هم نگه داشته‌اید، همین لایه کنترل متمرکز است که API را عوض نمی‌کند. فارغ‌التحصیلی CNCF محصول تازه‌ای نیست؛ سیگنال اکوسیستم است: multi-cluster دیگر ویژگی لوکس نیست، مخصوصاً وقتی training و inference از یک کلاستر جا نمی‌شوند.

## شش سال تا Graduation

- اولین commit: نوامبر ۲۰۲۰
- ورود به CNCF به‌عنوان Sandbox: سپتامبر ۲۰۲۱
- Incubating: دسامبر ۲۰۲۳
- Graduation: سپتامبر ۲۰۲۶

برای Graduation، پروژه audit امنیتی ثالث، steering committee رسمی، Code of Conduct CNCF و نشان CII Best Practices را تکمیل کرده است.

اعداد اعلام‌شده CNCF: بیش از **۱۲۱۴** contributor از **۲۹۲** سازمان، بیش از **۵۶۰۰** ستاره GitHub. Maintainerها در شش سازمان پخش‌اند.

نسخه **v1.19** همزمان مطرح شده: زمان‌بندی چندجزئی برای jobهای آموزش توزیع‌شده AI، و ارتقای priority-based scheduling به Beta (به‌صورت پیش‌فرض روشن). Roadmap ۲۰۲۶ شامل preemption مبتنی بر اولویت، صف چندکلاستری برای training/batch، و پشتیبانی چندکلاستری از Dynamic Resource Allocation برای GPU و شتاب‌دهنده‌هاست.

Karmada با observability موجود CNCF هم حرف می‌زند: متریک Prometheus روی control plane، etcd برای state، و Helm chart برای نصب.

## چه کسانی در production نشسته‌اند

CNCF از Bloomberg و Wellhub در سطح جهانی نام برده، و در آسیا از Alibaba Cloud، Huawei، Trip.com، Bilibili، iFLYTEK، JDCloud، Kuaishou، SenseTime، Vivo، WPS، ZTO و دیگران. موارد استفاده اعلام‌شده: ظرفیت hybrid، تاب‌آوری چندمنطقه‌ای، توزیع ترافیک، آموزش AI، زمان‌بندی GPU/CPU، تحویل اپ چندکلاستری.

نقل‌قول‌های پشتیبانی در اعلام رسمی از Bloomberg (failover و ساده‌سازی تجربه تیم‌های اپ)، Trip.com (چند کلاستر به‌عنوان یک resource pool بدون تغییر تعریف ریسورس Kubernetes) و DaoCloud (استراتژی چندابری و مسیر inference چندکلاستری) آمده است.

Chris Aniszczyk، CTOی CNCF، گفته وقتی Kubernetes روی چند کلاستر و محیط GPU تنگ مقیاس می‌شود، یک راه production-ready برای هماهنگ کردن ناوگان حیاتی است.

</div>
