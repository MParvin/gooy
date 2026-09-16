---
title: "باگ سه‌ساله از دست رفتن بی‌صدا داده روی x86 بعد از MADV_FREE بسته شد"
date: 2026-09-16T07:00:00+03:30
draft: false
slug: "linux-madv-free-silent-data-loss"
tags: ["linux", "kernel", "thp", "madv-free", "x86", "memory"]
categories: ["Security", "Linux"]
description: "از لینوکس ۶٫۶ روی x86، نوشتن بعد از MADV_FREE روی THP ممکن بود زیر فشار حافظه بی‌صدا صفر شود. علت: pmd_modify بیت dirty را می‌کند. پچ یک‌خطی بعد از ۷٫۳-rc3 در mainline."
image: "/images/linux-madv-free-silent-data-loss.png"
---

<div dir="rtl">

۲ سپتامبر ۲۰۲۶ Orson Peters از تیم Polars یک reproducer کوتاه به linux-mm فرستاد: بافر را پر کن، `madvise(MADV_FREE)` بزن، دوباره بنویس، زیر فشار memcg نوشتهٔ دوم ناپدید می‌شود. خواندن بعدی صفحهٔ صفر برمی‌گرداند. هیچ errno، هیچ SIGBUS. [گزارش](https://lkml.iu.edu/2609.0/05957.html) می‌گوید کاربران Polars در production داده از دست داده‌اند — ترکیب درست hugepage، MADV_FREE و reclaim سنگین.

Phoronix ۱۴ سپتامبر (حدود ۶:۱۳ صبح EDT) نوشت پچ بعد از **Linux 7.3-rc3** برای باگ از دست رفتن بی‌صدای user-space که سه سال در کرنل بوده merge شده است. permalink دقیق مقاله را از اسلاگ‌های رایج نتوانستیم باز کنیم؛ خودِ پچ و tip tree منبع قطعی‌اند.

## یک بیت که از کار shadow-stack جا مانده بود

Vernon Yang علت را ظرف یک روز پیدا کرد. از لینوکس **۶٫۶**، در مسیر آماده‌سازی shadow-stack روی x86، `pmd_modify()` مقدار PMD را با `(_HPAGE_CHG_MASK & ~_PAGE_DIRTY)` ماسک می‌کرد و بیت dirty سخت‌افزار را دور می‌ریخت. `pmd_mksaveddirty()` قرار بود `_PAGE_DIRTY` را به `_PAGE_SAVED_DIRTY` منتقل کند، ولی چیزی برای انتقال نمانده بود. `pte_modify()` و `pud_modify()` این بیت را نگه می‌داشتند؛ PMD استثنا بود.

سناریوی قابل‌مشاهده روی THP نگاشت‌شده با PMD:

1. memset؛ PMD dirty است
2. `MADV_FREE` — PMD پاک می‌شود ولی writable می‌ماند، folio lazyfree
3. memset دوباره — سخت‌افزار `_PAGE_DIRTY` را برمی‌گرداند
4. `mprotect` فقط‌خواندنی (یا NUMA hinting) از `pmd_modify()` می‌گذرد و بیت را می‌کشد
5. reclaim، مثلاً زیر سقف cgroup، folio را در `__discard_anon_folio_pmd_locked()` آزاد می‌کند
6. fault بعدی صفحهٔ صفر تازه می‌آورد

NUMA balancing به‌تنهایی، از مسیر `do_huge_pmd_numa_page()`، همان ضرر را می‌زند. THP فایلی هم می‌تواند writeback را از دست بدهد.

## پچ یک خط است؛ تا رسیدن stable، THP را ببندید

در `arch/x86/include/asm/pgtable.h` ماسک به `_HPAGE_CHG_MASK` برگشته — `_PAGE_DIRTY` دیگر عمداً حذف نمی‌شود. [پچ](https://lists.openwall.net/linux-kernel/2026/09/03/262) و ورود به [tip: x86/urgent](https://lkml.iu.edu/2609.1/02798.html) با عنوان «Fix user-space data loss with MADV_FREE and THP». Fixes روی `bb3aadf7d446` («Start actually marking _PAGE_SAVED_DIRTY»). Reviewed-by از Rick Edgecombe که سری اصلی shadow-stack را نوشته. `Cc: stable@xxxxxxxxxxxxxxx`. [Techveda](https://www.techveda.live/2026/09/15/silent-data-loss-cra-reporting/) می‌گوید یک مهندس SUSE مورد مشتری جدا هم با همین پچ بسته؛ merge به mainline بعد از 7.3-rc3.

**arm64 درگیر نیست.** هر x86 از ۶٫۶ تا RCهای ۷٫۳ درگیر است. allocatorهای مدرن خودشان MADV_FREE می‌زنند؛ سقف حافظهٔ systemd و کانتینر هم معمولی است. تا نقطهٔ پایدار شاخه‌تان پچ را بگیرد، `transparent_hugepage=never` ماشه را برمی‌دارد — با هزینهٔ عملکرد. کل point release را بردارید، نه cherry-pick تک‌خط.

</div>
