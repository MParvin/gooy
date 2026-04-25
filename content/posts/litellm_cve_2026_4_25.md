---
title: "هشدار امنیتی: حمله Supply Chain در litellm (نسخه‌های 1.82.7 و 1.82.8)"
date: 2026-04-25
draft: false
tags:
  - security
  - python
  - supply-chain
  - devops
categories:
  - Security
  - Python
description: "بررسی کامل آسیب‌پذیری خطرناک در پکیج litellm و نحوه تشخیص و مقابله با آن"
image: "/images/litellm_supplychaing_attack_2026.png"
---

litellm_init.pth

<div dir="rtl">
## 🚨 هشدار امنیتی بسیار مهم

نسخه `1.82.8` (و همچنین `1.82.7`) از پکیج `litellm` که روی PyPI منتشر شده، آلوده به کد مخرب است و اطلاعات حساس سیستم را بدون اطلاع کاربر جمع‌آوری کرده و به سرور مهاجم ارسال می‌کند.

این یک نمونه واقعی و بسیار خطرناک از **Supply Chain Attack** است که باید کاملاً جدی گرفته شود. :contentReference[oaicite:0]{index=0}
</div>

---

<div dir="rtl">
## 🔥 چرا این حمله خطرناک است؟

نکته ترسناک اینجاست:

این کد **نیازی به import ندارد**

پکیج شامل یک فایل مخرب به نام:
</div>

```



```

<div dir="rtl">
در مسیر `site-packages` است.

فایل‌های `.pth` هنگام اجرای Python (از طریق site module) به صورت خودکار اجرا می‌شوند.  
یعنی حتی اگر شما هیچ‌وقت `litellm` را import نکنید، کد مخرب اجرا می‌شود. :contentReference[oaicite:1]{index=1}
</div>

---

<div dir="rtl">
## 🧠 این malware چه کار می‌کند؟

این بدافزار به‌صورت aggressive اطلاعات حساس را از سیستم جمع‌آوری می‌کند، از جمله:

- کلیدهای SSH  
- API Key ها و متغیرهای محیطی  
- اعتبارنامه‌های AWS / Azure / GCP  
- تنظیمات Kubernetes و tokenها  
- Docker و configهای مختلف  
- history های bash, zsh, MySQL, Redis  
- اطلاعات سیستم و شبکه  
- فایل‌های CI/CD و secrets  
- کلیدهای خصوصی SSL/TLS  

و حتی مواردی مثل crypto walletها و فایل‌های config مختلف.

این داده‌ها سپس رمزنگاری شده و به یک سرور خارجی ارسال می‌شوند. :contentReference[oaicite:2]{index=2}
</div>

---

<div dir="rtl">
## 📡 مقصد ارسال داده‌ها
</div>

```

[https://models.litellm.cloud/](https://models.litellm.cloud/)

````

<div dir="rtl">
⚠️ توجه: این دامنه **دامنه رسمی litellm نیست**
</div>

---

<div dir="rtl">
## 👥 چه کسانی در معرض خطر هستند؟

هر کسی که این نسخه‌ها را نصب کرده باشد:

- سیستم‌های توسعه (Developer machines)
- سرورهای Production
- سیستم‌های CI/CD
- کانتینرهای Docker

حتی اگر این پکیج به صورت dependency غیرمستقیم نصب شده باشد. :contentReference[oaicite:3]{index=3}
</div>

---

<div dir="rtl">
## ⚠️ چه کاری باید انجام دهید؟
</div>

<div dir="rtl">
### 1. بررسی فوری

بررسی کنید این فایل وجود دارد یا نه:
</div>

```bash
site-packages/litellm_init.pth
````

<div dir="rtl">
همچنین این مسیرها را چک کنید:

* virtualenv ها
* `~/.local/...`
* مسیرهای system-wide
</div>

---

<div dir="rtl">
### 2. اگر آلوده هستید

**فرض کنید همه چیز compromise شده است.**

اقدامات فوری:

* تغییر تمام API Key ها
* ساخت SSH Key جدید
* rotate کردن credentialهای cloud
* revoke کردن tokenها و sessionها
* بررسی لاگ‌ها و ترافیک خروجی مشکوک
</div>

---

<div dir="rtl">
### 3. پاک‌سازی

* حذف نسخه آلوده
* نصب نسخه امن
* بررسی persistence (مثل فایل‌های باقی‌مانده)
</div>

---

<div dir="rtl">
## 🧪 چطور دنبال این فایل بگردیم؟
</div>

<div dir="rtl">
### با find:
</div>

```bash
find . -type f -name 'litellm_init.pth'
```

<div dir="rtl">
اگر مسیر پروژه متفاوت است، به جای `.` مسیر کامل را وارد کنید.
</div>

---

<div dir="rtl">
### با locate:
</div>

```bash
updatedb
locate 'litellm_init.pth'
```

---

<div dir="rtl">
### بررسی استفاده در پروژه:
</div>

```bash
grep litellm -nr ./
grep litellm -n requirements.txt
```

---

<div dir="rtl">
## ⚠️ نکته بسیار مهم

این حمله فقط محدود به یک نسخه نیست.

نسخه‌های زیر تأیید شده‌اند:

* `1.82.7`
* `1.82.8`

و احتمال دارد نسخه‌های دیگر نیز تحت تأثیر باشند. ([Revaizor][1])
</div>

---

<div dir="rtl">
## 🧩 جمع‌بندی

این اتفاق نشان می‌دهد که:

> هیچ dependency‌ای را نباید امن فرض کرد، حتی اگر بسیار محبوب باشد.

حملات Supply Chain در حال تبدیل شدن به یکی از خطرناک‌ترین تهدیدات دنیای نرم‌افزار هستند.
</div>

---

<div dir="rtl">
## 📅 اطلاعات حادثه

* تاریخ کشف: ۲۴ مارس ۲۰۲۶
* منبع: [https://github.com/BerriAI/litellm/issues/24512](https://github.com/BerriAI/litellm/issues/24512)
</div>

---

<div dir="rtl">
## 🔖 برچسب‌ها

#security #python #supply-chain #devops
</div>

```
::contentReference[oaicite:5]{index=5}
```

[1]: https://revaizor.com/blog/litellm-vulnerability-pypi-supply-chain-attack/?utm_source=chatgpt.com "LiteLLM Vulnerability Explained: The PyPI Supply Chain Attack, Affected Versions, and What to Do"
