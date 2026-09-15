---
title: "React 19.3: View Transitions و Fragment Refs از حالت آزمایشی خارج شدند"
date: 2026-09-15T15:21:00+03:30
draft: false
slug: "react-19-3-view-transitions-fragment-refs"
tags: ["react", "javascript", "view-transitions", "ssr", "frontend"]
categories: ["Programming", "Web"]
description: "ریلیز ۹ سپتامبر ۲۰۲۶ ری‌اکت ۱۹.۳: ViewTransition پایدار، Fragment Refs، browser() برای opt-out از SSR، Trusted Types، و رندر مستقیم Context در Server Components."
image: "/images/react-19-3-view-transitions.png"
---

<div dir="rtl">

۹ سپتامبر ۲۰۲۶ تیم ری‌اکت در [بلاگ رسمی](https://react.dev/blog/2026/09/09/react-19-3) نسخه **۱۹.۳** را روی npm گذاشت. دو API که پارسال experimental بودند، حالا stableاند: **View Transitions** و **Fragment Refs**. بقیهٔ این ریلیز کمتر براق است ولی برای SSR و امنیت DOM به همان اندازه به کار می‌آید.

`<ViewTransition>` از [View Transition API](https://developer.mozilla.org/en-US/docs/Web/API/View_Transition_API) مرورگر استفاده می‌کند تا ورود، خروج، جابه‌جایی یا تغییر اندازه را انیمیت کند. تکهٔ UI را در این کامپوننت می‌پیچید؛ وقتی یک آپدیتِ علامت‌خورده به‌عنوان Transition فرزند را عوض کند یا خود `ViewTransition` mount/unmount شود، ری‌اکت انیمیشن را اجرا می‌کند. آپدیت فوری بیرون از Transition انیمیشن نمی‌گیرد — همان چیزهایی که باید بی‌درنگ روی صفحه بنشینند. منبع انیمیشن می‌تواند `startTransition`، آشکار شدن `<Suspense>`، یا `useDeferredValue` باشد. نوع حرکت را خود درخت تعیین می‌کند: enter، exit، update، یا share برای یک `ViewTransition` نام‌دار که یک‌جا حذف و جای دیگر اضافه می‌شود.

## ref بدون دست‌کاری کامپوننت داخلی

Fragment Refs مجموعه‌ای محدود از متدهای DOM را روی هر کامپوننت ری‌اکت می‌گذارد، مستقل از این‌که آن کامپوننت چه چیزی رندر می‌کند. ایده این است که رفتار را به کامپوننت دیگری بچسبانید بدون این‌که internalsش را عوض کنید یا ساختار DOM موجود را به هم بزنید. جزئیات در مستند `Fragment` همان سایت ری‌اکت است.

از `react-dom` هم `browser()` آمده. کامپوننت می‌تواند `use(browser())` صدا بزند تا از SSR opt-out کند: روی سرور نزدیک‌ترین Suspense fallback در HTML می‌آید؛ بعد از hydrate روی کلاینت، همان فراخوانی دیگر suspend نمی‌شود. مثل بقیهٔ `use`، می‌شود داخل شرط یا بعد از early return صداش کرد.

دو تغییر دیگر که کمتر در توییتر می‌چرخد:

- **Trusted Types:** قبلاً ری‌اکت مقدار را قبل از دادن به DOM به رشته تبدیل می‌کرد و objectهای `TrustedHTML` را خراب می‌کرد. ۱۹.۳ آن‌ها را بدون coercion رد می‌کند تا CSP با `require-trusted-types-for 'script'` درست کار کند.
- **Server Components:** هنوز نمی‌توانند Context بسازند، ولی در ۱۹.۳ می‌توانند Context را مستقیم از یک ماژول `'use client'` import و رندر کنند؛ دیگر لازم نیست یک wrapper خالی فقط برای پاس‌دادن prop بنویسید.

اگر روی ۱۹.۲ هستید و انیمیشن صفحه یا ref روی Fragment را آزمایشی نگه داشته‌اید، مسیر پایدار همان ۱۹.۳ است.

</div>
