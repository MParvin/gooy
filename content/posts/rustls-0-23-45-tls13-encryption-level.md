---
title: "Rustls ۰٫۲۳٫۴۵ وصله RUSTSEC-2026-0285 برای پذیرش نادرست پیام‌های TLS 1.3"
date: 2026-09-16T13:20:00+03:30
draft: false
slug: "rustls-0-23-45-tls13-encryption-level"
tags: ["rustls", "tls", "rust", "rustsec", "security"]
categories: ["Security", "Programming"]
description: "RUSTSEC-2026-0285 در ۱۴ سپتامبر: پیام handshake TLS 1.3 در سطح رمز اشتباه پذیرفته می‌شد. CVSS 5.3؛ جعل handshake نیست. پچ ≥0.23.45."
image: "/images/rustls-0-23-45-tls13-encryption-level.png"
---

<div dir="rtl">

مثال از خود advisory است: پرواز سرور TLS 1.3 که یک **EncryptedExtensions به‌صورت plaintext** را داخل همان record کنار **ServerHello** می‌چیند. rustls آن را قبول می‌کرد. نباید می‌کرد.

۱۴ سپتامبر ۲۰۲۶ [RUSTSEC-2026-0285](https://rustsec.org/advisories/RUSTSEC-2026-0285.html) همین را به‌عنوان آسیب‌پذیری crypto-failure ثبت کرد؛ alias گیت‌هاب [GHSA-2mjx-qc3c-rqvc](https://github.com/rustls/rustls/security/advisories/GHSA-2mjx-qc3c-rqvc) است. امتیاز **CVSS 5.3 MEDIUM** با بردار `CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N`. در GHSA هنوز CVE جدا ثبت نشده.

## RFC چه می‌خواهد؛ rustls چه می‌کرد

[RFC 8446 بخش 5.1](https://www.rfc-editor.org/rfc/rfc8446#section-5.1) می‌گوید پیام handshake نباید از روی تغییر کلید رد شود. پیاده‌سازی باید مطمئن شود همهٔ پیام‌های بلافاصله قبل از key change روی مرز record ترازند؛ وگرنه اتصال را با `unexpected_message` قطع کند. ClientHello، EndOfEarlyData، ServerHello، Finished و KeyUpdate دقیقاً همان پیام‌هایی‌اند که ممکن است بلافاصله قبل از عوض شدن کلید بیایند.

گزارش اصلی (نسخهٔ تست‌شده 0.23.44) می‌گوید `Deframer::aligned` تا وقتی پیام‌های باقی‌مانده در بافر کامل باشند خودش را aligned می‌داند. rustls ServerHello را پردازش می‌کند، کلید handshake را نصب می‌کند، بعد EncryptedExtensions کامل — که هنوز plaintext است — را از بافر برمی‌دارد. گزارش‌دهنده: **@randombit**. کشف داخل یک مجموعه تست TLS/DTLS؛ Botan، OpenSSL، BoringSSL، Go و wolfSSL همین جریان را رد می‌کنند.

## آنچه این باگ نیست

transcript هنوز authenticate می‌شود. مهاجم سر راه **نمی‌تواند handshake را عوض یا کامل کند**. اثر عملی: همتا می‌تواند پیام‌هایی را که باید رمز شوند **به‌صورت plaintext** بفرستد و rustls اتصال را رد نکند. Confidentiality در CVSS «Low» است؛ Integrity و Availability صفر.

RustSec می‌نویسد این از همان کلاس باگ Go است: **GO-2026-4340** (CVE-2025-61730).

نسخه‌ها از GHSA: آسیب‌پذیر **0.23.13 تا 0.23.44** شامل هر دو سر. پچ: **0.23.45** و بعد. RustSec همان را `>=0.23.45` نوشته و خط **`<0.23.13` را unaffected** گذاشته. اگر crate را روی 0.23.44 قفل کرده‌اید، bump به 0.23.45 همان advisory است، نه یک CVE جدا با RCE.

</div>
