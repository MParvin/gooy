---
title: ".NET 11 RC1 با مجوز go-live برای production منتشر شد"
date: 2026-09-15T15:28:00+03:30
draft: false
tags: ["dotnet", "csharp", "aspnet", "rc", "microsoft"]
categories: ["Programming", "Cloud"]
description: "اعلام ۸ سپتامبر ۲۰۲۶ برای .NET 11 RC1: نخستین Release Candidate با پشتیبانی go-live؛ C# 15 unions پایدار، SignalR auth refresh، و بهبود TLS/DNS/JSON."
image: "/images/dotnet-11-rc1-go-live.png"
---

<div dir="rtl">

۸ سپتامبر ۲۰۲۶ تیم .NET در [بلاگ دات‌نت](https://devblogs.microsoft.com/dotnet/dotnet-11-rc-1/) نوشت **.NET 11 Release Candidate 1** آماده است. این اولین RC است و با **go-live support license** می‌آید؛ یعنی مایکروسافت استفاده در production را برای این بیلد پشتیبانی می‌کند، نه فقط برای آزمایشگاه. ابزار: Visual Studio 2026 Insiders و VS Code با C# Dev Kit.

RC یعنی شاخه دیگر preview بی‌ثبات نیست، ولی هنوز GA نشده. اگر سرویس cloud دارید که می‌خواهید قبل از ریلیز نهایی روی runtime جدید بنشیند، همین مجوز همان چیزی است که معمولاً منتظرش می‌مانند.

## کتابخانه، runtime، زبان — نه یک bullet براق

در **Libraries** چند کار عملی آمده: نشست TLS به‌صورت caller-driven (هنوز experimental)، **resolution رکورد DNS روی لینوکس**، JSON برای numeric typeهای جدید و schema باینری، polymorphism از نوع closed و پشتیبانی union در JSON، اعتبارسنجی async آپشن‌ها، AES Key Wrap، و TLS channel binding روی Unix. روی اپل، authenticated encryption سریع‌تر شده.

**Runtime** crash reporting درون‌پروسه روی Unix گرفته و عملیات `Half` از دستور FP16 سخت‌افزار استفاده می‌کند. **SDK** سمت `dotnet test` کنترل run-level و layout نتیجه اضافه کرده، انتشار کانتینر image قابل‌بازتولید می‌سازد و آپلود تکراری را رد می‌کند، و برنامه‌های file-based امکان reuse مربوط به Native AOT را دارند.

زبان: **C# 15 unions را پایدار کرده** — همان تغییری که در previewها بیشترین بحث را داشت. ASP.NET Core هم APIهای **SignalR authentication refresh** را نهایی کرده؛ کلاینت TypeScript همان مسیر را دارد و مدار Blazor Server بعد از refresh احراز هویت به‌روز می‌شود. Negotiate authentication از TLS channel binding استفاده می‌کند. OpenAPI هم APIهای obsolete را منعکس می‌کند.

F# در همین RC چیزهایی مثل record spread و constructor و ساخت مستقیم delegate گرفته. MAUI و Windows Forms هم فهرست جدا دارند؛ اگر کiosk-style یا visual style مدرن می‌خواهید، همان بخش RC1 را بخوانید.

نصب از SDK ۱۱ شروع می‌شود؛ یادداشت کامل و breaking changeها در discussions مخزن `dotnet/core` است. برای تیمی که می‌خواهد قبل از GA روی ۱۱ برود، RC1 همان بیلدی است که دیگر «غیررسمی» حساب نمی‌شود.

</div>
