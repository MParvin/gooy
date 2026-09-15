---
title: "قوانین جدید GitHub: مسدود کردن Pull Request با secret اسکن‌نشده"
date: 2026-09-14T11:00:00+03:30
draft: false
tags: ["github", "secret-scanning", "rulesets", "actions", "security"]
categories: ["Security", "DevOps"]
description: "GitHub در پیش‌نمایش عمومی قانونی برای ruleset گذاشته که merge شدن Pull Request با هشدار باز secret scanning را مسدود می‌کند؛ همان هفته cache-mode هم GA شد."
image: "/images/github-block-prs-secrets.png"
---

<div dir="rtl">

یک هفته در Changelog گیت‌هاب دو گیت جدا برای ورود به `main` گذاشت: یکی سر secret در کد، یکی سر مسموم کردن cache در CI.

## merge نمی‌شود تا alert بسته شود

۹ سپتامبر ۲۰۲۶ گیت‌هاب اعلام کرد می‌توان با **repository ruleset** مانع merge شدن Pull Requestهایی شد که secret جدید وارد مخزن می‌کنند و هنوز هشدارشان باز است. [پست رسمی](https://github.blog/changelog/2026-09-09-block-pull-requests-with-exposed-secrets-from-merging/) این قابلیت را **public preview** معرفی کرده؛ برای مشتریانی که **GitHub Secret Protection** یا **GitHub Advanced Security** دارند.

قانون جدید: **Require secret scanning alerts are resolved on pull requests**.

قبل از merge دو چیز چک می‌شود:

1. اسکن secret برای head commit تمام شده باشد
2. هیچ هشدار بازی برای secretهایی که commitهای همین PR آورده‌اند باقی نمانده باشد

پیش‌فرض، روی PRهای باز و روی الگوی provider اجرا می‌شود. می‌شود دسته‌های دیگر (custom یا generic) را هم به بلاک اضافه کرد. کسی که bypass permission ندارد باید تک‌تک alert را ببندد تا بلاک برداشته شود.

تنظیم از UI (Repository / Organization / Enterprise → Rulesets) یا از REST با نوع `require_secret_scanning_alert_resolution` و پارامتر `secret_types`، یا GraphQL با `REQUIRE_SECRET_SCANNING_ALERT_RESOLUTION`.

Push protection سر push می‌ایستد؛ secret اصلاً نباید به مخزن برسد. این قانون لایه دوم است، سر **Pull Request**. مواردی که push protection نمی‌گیرد یا عمداً برایشان خاموش است — مثلاً الگوی generic — این‌جا می‌توانند جلوی merge را بگیرند. یعنی می‌شود push protection را برای generic شل گذاشت و ruleset را سخت، بدون این‌که developer هر push را به دیوار بزند. جایگزین push protection نیست؛ مکمل است.

Secret در PR یعنی گاهی کلید بعد از push و قبل از merge دیده می‌شود؛ یا الگوی generic آن‌قدر noisy است که push protection را روشن نمی‌کنید. بستن merge همان جایی است که آدم‌ها معمولاً «بعداً درست می‌کنم» می‌گویند و بعداً نمی‌رسد.

## cache-mode دیگر پیش‌نمایش نیست

۱۰ سپتامبر گیت‌هاب [cache-mode](https://github.blog/changelog/2026-09-10-control-github-actions-cache-access-with-cache-mode/) را برای کنترل دسترسی به GitHub Actions cache **GA** کرد؛ روی همه پلن‌ها.

حالت‌ها:

- `read`: restore مجاز، save ممنوع (پیش‌فرض رویدادهای کم‌اعتماد مثل `pull_request_target`)
- `write`: restore و save (پیش‌فرض رویدادهای مورد اعتماد مثل `push`)
- `write-only`: فقط save
- `none`: هیچ دسترسی

تنظیم job روی workflow می‌نشیند. سرویس cache آن را enforce می‌کند و به reusable workflow هم سرایت می‌کند: workflow صدا‌زده نمی‌تواند دسترسی بیشتری از caller بگیرد. اگر برای رویداد کم‌اعتماد صریحاً `write` بگذارید، گیت‌هاب warning می‌دهد چون ریسک cache poisoning بالا می‌رود.

روی شاخه‌های محافظت‌شده، ruleset را بسازید و «Require secret scanning alerts are resolved» را روشن کنید. تصمیم بگیرید generic/custom هم بلاک شوند یا فقط provider. Bypass را محدود نگه دارید. در Actions، `cache-mode` را صریح کنید؛ برای `pull_request_target` پیش‌فرض read را بی‌دلیل write نکنید.

</div>
