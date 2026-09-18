---
title: "رجیستری ماژول workerd از نو نوشته شد؛ سازگاری Node.js پشت new_module_registry"
date: 2026-09-11T10:00:00+03:30
draft: false
slug: "cloudflare-workers-module-registry"
tags: ["cloudflare", "workers", "workerd", "nodejs", "esm"]
categories: ["Cloud", "Programming"]
description: "۹ سپتامبر: رجیستری جدید ماژول در workerd با فلگ new_module_registry. specifier به‌صورت URL؛ import.meta؛ require(esm) مطابق Node؛ کامپایل تنبل؛ Wasm source phase؛ باندل تا ۶۴ MiB."
image: "/images/cloudflare-workers-module-registry.png"
---

<div dir="rtl">

سازگاری API با Node برای اجرای اپ روی Workers کافی نبود. اپ‌ها به **نحوه resolve و load و cache ماژول** هم وابسته‌اند. ۹ سپتامبر ۲۰۲۶ لوگان گتلین و جیمز اسنل در [بلاگ کلادفلر](https://blog.cloudflare.com/workers-module-registry-nodejs/) نوشتند رجیستری ماژول داخل **`workerd`** از نو نوشته شده تا به همان مدل Node و استاندارد وب نزدیک شود.

فعال‌سازی فقط با فلگ سازگاری است؛ **تاریخ پیش‌فرض روشن شدن ندارد** — Worker قدیمی و جدید، هیچ‌کدام خودکار سوییچ نمی‌شوند:

```json
{ "compatibility_flags": ["new_module_registry"] }
```

رجیستری قبلی specifier را مثل مسیر فایل‌سیستم می‌دید، نه URL. نتیجه: `import.meta.url` تمیز پیاده نمی‌شد، import نسبی با `new URL()` یکی نبود، و پروتکل‌های `node:` و `cloudflare:` پیشوند رشته‌ای خاص بودند. کل باندل از اول compile می‌شد، حتی ماژولی که هیچ‌وقت import نمی‌شد، و هر isolate کپی خصوصی خودش را نگه می‌داشت.

## وقتی specifier واقعاً URL است

با رجیستری جدید، `import.meta.url`، `import.meta.main` و `import.meta.resolve()` کار می‌کنند. resolve یک تبدیل رشته است، مثل Node و مرورگر: وجود فایل را چک نمی‌کند؛ specifier غیرقابل‌parse برابر `TypeError` است نه `null`. query string و fragment هویت جدا می‌سازند: `./counter.js?a` و `./counter.js?b` دو instance با state جدا هستند.

import attribute دیگر silently ignore نمی‌شود. فقط **`type: 'json'`** (Stage 4) قبول است. `text` و `bytes` شناخته می‌شوند و با خطای مشخص رد می‌شوند. کلید ناشناخته مثل `cache` هم خطای سخت است.

**`require(esm)`** قواعد Node را دنبال می‌کند: اگر export رشته‌ای `'module.exports'` باشد همان برمی‌گردد؛ وگرنه namespace. builtinهای `node:` در workerd default export را مستقیم می‌دهند تا `.default` لازم نباشد. top-level `await` در گراف یعنی `require()` پرتاب می‌کند — معادل `ERR_REQUIRE_ASYNC_MODULE`. برای async باید `import()` بگذارید.

خطاها روی static import و `import()` و `require()` یک شکل‌اند: «Module not found» از جنس `Error`، specifier خراب از جنس `TypeError`. Wasm **source phase import** دارد (`import source` / `import.source`) و `WebAssembly.Module` برمی‌گرداند؛ روی نوع دیگر `SyntaxError` است.

کامپایل **تنبل** است: اولین import استاتیک یا دینامیک. APIهای پایدار Node در Workers به‌صورت پیش‌فرض روشن‌اند و سقف باندل به **۶۴ MiB** روی همه پلن‌ها رسیده (حد compressed برداشته شده). رجیستری قدیمی نمی‌رود؛ Workerهای فعلی همان رفتار قبل را دارند.

اگر bundler (Rolldown در Vite 8، یا `--no-bundle`) گراف را بیشتر دست‌نخورده می‌فرستد، این رجیستری همان جایی است که runtime باید شبیه Node رفتار کند. رگرسیون را در [workerd](https://github.com/cloudflare/workerd) گزارش کنید، نه به‌عنوان «فلگ را روشن کردم و import.meta آمد» — آن تغییر است، نه باگ.

</div>
