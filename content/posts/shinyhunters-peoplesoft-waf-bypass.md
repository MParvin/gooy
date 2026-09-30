---
title: "ShinyHunters با URL-encoding سد WAF را روی PeopleSoft CVE-2026-35273 دور زد"
date: 2026-09-26T15:00:00+03:30
draft: false
slug: "shinyhunters-peoplesoft-waf-bypass"
tags: ["peoplesoft", "oracle", "waf", "rce", "shinyhunters", "mandiant"]
categories: ["Security"]
description: "Mandiant از بهره‌برداری مجدد UNC6240 می‌گوید: encoding مسیر PSEMHUB قوانین WAF را دور می‌زند؛ وصله به‌جای اتکا به WAF، و شکار لاگ برای variantهای encoded."
image: "/images/shinyhunters-peoplesoft-waf-bypass.png"
---

<div dir="rtl">

درس هفته برای تیم‌هایی که روی WAF حساب کرده‌اند: **encoding می‌تواند قاعدهٔ مسیر را دور بزند، و WAF جایگزین پچ نیست.**

**CVE-2026-35273** یک RCE بدون احراز هویت در Oracle PeopleSoft (PeopleTools) از مسیر **PSEMHUB** است. اوراکل ژوئن ۲۰۲۶ آن را بست؛ پیش‌تر **ShinyHunters (UNC6240)** بهره‌برداری گسترده کرده بود. حالا طبق پوشش [BleepingComputer در ۲۶ سپتامبر](https://www.bleepingcomputer.com/news/security/shinyhunters-uses-waf-bypass-trick-in-oracle-peoplesoft-attacks/) و گزارش‌های Mandiant/GTIG حدود ۲۵ سپتامبر، exploitation از نو برگشته — این‌بار با ترفند دور زدن قوانینی که مسیر تحت‌اللفظی `/PSEMHUB/` را بلاک می‌کنند.

## وقتی `%50` همان `P` است

مهاجم به‌جای `/PSEMHUB/` چیزی شبیه `/%50SEMHUB/` می‌فرستد (`%50` برابر `P`). بسیاری از WAFها path خام را قبل از decode می‌سنجند؛ WebLogic decode می‌کند و درخواست را به endpoint آسیب‌پذیر می‌رساند. probeها معمولاً POSTهای Java سریال‌شده به `/%50SEMHUB/hub` هستند. بعد از آن webshellهای JSP مثل `x.jsp`، `u.jsp`، `u2.jsp`، تانل **Neo-reGeorg**، **SIDEEYE (Ple64.exe)** روی ویندوز و **MeshAgent** روی لینوکس دیده شده است.

قربانی‌ها ده‌ها سازمان در آموزش، فناوری، سلامت، دولت و حوزه‌های مشابه‌اند. توصیهٔ Mandiant مستقیم است: پچ کنید، به WAF تکیه نکنید؛ در لاگ هم شکل تحت‌اللفظی PSEMHUB و هم variantهای encoded را شکار کنید. اگر هنوز PeopleTools آسیب‌پذیر پشت یک rule مسیر دارید، آن rule فقط حس امنیت می‌دهد.

</div>
