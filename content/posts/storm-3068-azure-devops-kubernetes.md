---
title: "Storm-3068: از reset رمز تا دستکاری pipeline و سرقت kubeconfig"
date: 2026-09-29T17:00:00+03:30
draft: false
slug: "storm-3068-azure-devops-kubernetes"
tags: ["storm-3068", "azure-devops", "kubernetes", "identity", "cicd", "microsoft"]
categories: ["Security", "Cloud"]
description: "مطالعهٔ موردی Microsoft DART: Storm-3068 با SSPR پایدار شد، pipelineهای Azure DevOps را برای برداشت kubeconfig تغییر داد و با Atera و Chisel به API کوبرنتیز نزدیک شد."
image: "/images/storm-3068-azure-devops-k8s.png"
---

<div dir="rtl">

هویت و CI/CD گاهی کوتاه‌ترین راه به «کلیدهای پادشاهی» ابری‌اند. ۲۹ سپتامبر ۲۰۲۶ مایکروسافت در [سری Cyberattack DART](https://www.microsoft.com/en-us/security/blog/2026/09/29/beyond-source-code-a-path-to-the-keys-to-the-kingdom/) مطالعهٔ موردی **Storm-3068** را منتشر کرد: مهاجم از **self-service password reset** یک کاربر را گرفت، روش‌های احراز هویت خودش را برای persistence ثبت کرد، بعد با ابزارها و اسکریپت‌های admin مشروع سراغ **Azure DevOps** رفت — شمارش repo و project و pipeline و environment، بدون اینکه اول malware کلاسیک بکارد.

## pipeline مورد اعتماد، نه باینری غریبه

مسیر اصلی سوءاستفاده تغییر pipelineهای مورد اعتماد بود تا **Kubernetes credential** در مقیاس جمع شود: استقرار یک kube agent، جمع‌آوری فایل‌های kubeconfig (طبق گزارش، **۷** kubeconfig دزدیده‌شده به یک repo اضافه شد)، نصب **Atera RMM** و **Chisel** برای تانل به‌سمت Kubernetes API. همان pipeline به **بیش از ۵۰** resource دسترسی مجاز داشت — یعنی blast radius از روز اول داخل طراحی اعتماد نشسته بود.

برای تیم پلتفرم، زاویه روشن است: هویت + CI/CD مسیر رسیدن به kubeconfig و زیرساخت ابری است. توصیه‌های DART عملی‌اند: مانیتور کردن password reset؛ MFA مقاوم به فیشینگ برای حساب‌های privileged؛ branch protection و approval؛ محدود کردن کسانی که pipeline می‌سازند/عوض می‌کنند/اجرا می‌کنند؛ و least privilege در لایهٔ identity، DevOps و cloud. اگر فقط روی malware-first detection تکیه کنید، این داستان را دیر می‌بینید.

</div>
