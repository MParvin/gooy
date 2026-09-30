---
title: "Git ۲.۵۶: stage امن conflict، history drop و merge-base سریع‌تر روی monorepo"
date: 2026-09-28T10:00:00+03:30
draft: false
slug: "git-2-56-0-released"
tags: ["git", "vcs", "opensource", "developer-tools", "monorepo"]
categories: ["Programming", "Open Source"]
description: "اعلام Junio C Hamano برای Git 2.56.0: add --resolved، توقف هوشمند merge-base، git history drop آزمایشی، refs CRUD و بهبودهای مقیاس برای مخازن بزرگ."
image: "/images/git-2-56-0-release.png"
---

<div dir="rtl">

ابزار روزمرهٔ بیشتر توسعه‌دهنده‌ها نسخهٔ تازه‌ای گرفت. طبق [هایلایت‌های GitHub Blog](https://github.blog/open-source/git/highlights-from-git-2-56/) و پوشش [LWN](https://lwn.net/Articles/1097213/)، **Git ۲.۵۶.۰** با اعلام Junio C Hamano منتشر شد: **۷۴۸** commit غیرmerge از **۱۰۴** توسعه‌دهنده، که **۳۹** نفرشان برای اولین‌بار مشارکت کرده‌اند. تاریخ این بسته در تقویم ما ۲۸ سپتامبر ۲۰۲۶ است.

## conflict بدون markerهای جا مانده

`git add --resolved` فقط pathهای unmerged/conflicted را stage می‌کند و اگر conflict marker باقی مانده باشد، رد می‌کند. این دقیقاً همان workflowی است که در تیم‌های شلوغ، «فایل resolve شد ولی `<<<<<<<` هنوز داخلش بود» را کم می‌کند — نه جادو، فقط سخت‌گیری درست در لحظهٔ stage.

کنارش، قانون توقف پیمایش **merge-base** سرعت را روی monorepoهای بزرگ بالا برده است. path-walk در repack حالا با **reachability bitmap** و **delta island** سازگار است؛ یعنی بهینه‌سازی‌های ذخیره‌سازی که قبلاً با هم قاطی می‌شدند، هم‌مسیر شده‌اند.

## تاریخچه، ref و clone جزئی

`git history drop` هنوز experimental است، ولی برای دور انداختن تاریخ به‌شکل کنترل‌شده دیده می‌شود. خانوادهٔ `git refs create/update/delete/rename` مدیریت ref را صریح‌تر کرده؛ `git branch --delete-merged` شاخه‌های ادغام‌شده را جمع می‌کند. در bisect، `git bisect run --reset-when-found` بعد از پیدا کردن commit هدف، وضعیت را reset می‌کند. `git replay --linearize` برای بازچینی خطی‌تر تاریخ است.

روی سمت clone جزئی، `git repack --drop-filtered` می‌تواند blobهای فیلترشده را بیندازد. `git log --follow` هم در تاریخ غیرخطی رفتار بهتری دارد — همان جایی که rename tracking معمولاً گیج می‌شد.

اگر میزبان مخزن بزرگ دارید یا روزانه conflict resolve می‌کنید، ۲.۵۶ بیشتر از یک bump نسخه‌ای معمولی است: workflow امن‌تر برای resolve و مقیاس بهتر برای serverهای شلوغ.

</div>
