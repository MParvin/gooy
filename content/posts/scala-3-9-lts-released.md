---
title: "Scala 3.9 خط جدید LTS شد؛ SIP-71 و backend پایدار WebAssembly همراهش آمدند"
date: 2026-09-15T15:49:00+03:30
draft: false
tags: ["scala", "lts", "scalajs", "sip-71", "opensource"]
categories: ["Programming", "Open-source"]
description: "اعلام ۳ سپتامبر ۲۰۲۶ برای Scala 3.9.0 به‌عنوان LTS بعدی بعد از 3.3؛ into پایدار، Scala.js 1.22 با Wasm، Sloth برای LazyVals روی JDK 26+."
image: "/images/scala-3-9-lts.png"
---

<div dir="rtl">

۳ سپتامبر ۲۰۲۶ Wojciech Mazur از VirtusLab در [scala-lang.org/news/3.9](https://scala-lang.org/news/3.9/) نسخه **۳.۹.۰** را خط جدید **Long Term Support** معرفی کرد. جانشین **Scala 3.3 LTS** است: خط پایه برای نویسندهٔ کتابخانه و تیم production محافظه‌کار. خط Scala Next جدا می‌ماند برای کسی که ویژگی زبان را زود می‌خواهد.

کتابخانه‌ای که با ۳.۹ ساخته شود را می‌شود از پچ‌های بعدی ۳.۹ و از Scala Next مصرف کرد؛ ولی artifact نسخه‌ٔ ۳.۹ را پروژهٔ ۳.۳ نمی‌تواند مصرف کند. پس مهاجرت از ۳.۳ به ۳.۹ برای maintainer یک تصمیم انتشار minor است، نه فقط bump کامپایلر. خود ۳.۳ تا یک سال بعد از ۳.۹.۰ نگهداری می‌شود و ۳.۳.۹ در راه است؛ حجم backport کمتر می‌شود چون دو codebase از هم فاصله گرفته‌اند.

## `into` دیگر preview نیست

**SIP-71** در ۳.۸ به‌صورت preview آمد؛ در ۳.۹ پایدار است. نویسندهٔ API می‌تواند پارامتر یا نوع را با `into` علامت بزند تا conversion ضمنی همان‌جا مجاز باشد، بدون این‌که همهٔ implicit conversionهای پروژه روشن شوند. هم به‌صورت soft modifier روی خود نوع، هم با `into[T]` وقتی تعریف نوع دست شما نیست.

Scala 3.9 با **Scala.js 1.22** می‌آید. backend جزو کامپایلر است، نه پلاگین جدا؛ پس کل خط LTS روی همین minor می‌ماند. ویژگی اصلی ۱.۲۲: **backend پایدار WebAssembly** روی میزبان JavaScript (Node، Deno، Bun، مرورگر) نه runtime فقط-Wasm. پیش‌نیاز: ECMAScript 2022، موتور Wasm 3.0، `ESModule`. Node 25، Chrome 137، Firefox 134 و Safari 26 این خط را می‌گیرند.

برای تیم‌هایی که به JDK جدید می‌روند، **Sloth** در Scala CLI مهم است. کد ۳.۰ تا ۳.۷ برای `lazy val` از `sun.misc.Unsafe` می‌گذرد؛ در JDK 24 این API به‌صورت terminal deprecate شده و در JDK 26 هنوز warning می‌دهد. حتی کامپایل با ۳.۸ کافی نیست اگر dependency قدیمی همان bytecode را بیاورد. Sloth بایت‌کد را به پیاده‌سازی `VarHandle` بازنویسی می‌کند — پیشاپیش روی classpath یا با agent موقع load. هر دو opt-in و experimentalاند (`--power`).

یک هشدار به‌سمت ۳.۱۰: implicit داخل companion غیرقابل‌دسترس دیگر از call site پیدا نمی‌شود. ۳.۹ با `-deprecation` warning می‌دهد؛ ۳.۱۰ کامپایل را می‌شکند. Open Community Build حدود ۲۰ پروژه را روی این نقطه گرفته. اگر کتابخانه می‌نویسید، warning را قبل از ۳.۱۰ در خود کتابخانه ببندید — مصرف‌کننده معمولاً نمی‌تواند از بیرون درستش کند.

</div>
