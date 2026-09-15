---
title: "لینوکس ۷.۳-rc3: rc نسبتاً بزرگ با ردپای بیشتر فایل‌سیستم"
date: 2026-09-15T11:00:00+03:30
draft: false
tags: ["linux", "kernel", "7.3", "xfs", "smb", "rc"]
categories: ["Linux"]
description: "لینوس ۷.۳-rc3 را rc نسبتاً بزرگی خواند که ردپای فایل‌سیستم‌اش از معمول بیشتر است؛ عمدتاً XFS و SMB client، هرچند بخش عمده پچ هنوز درایور است."
image: "/images/linux-kernel-7-3-rc3.png"
---

<div dir="rtl">

۱۳ سپتامبر ۲۰۲۶ لینوس توروالدز **۷٫۳-rc3** را برای تست فرستاد. [خلاصه LWN](https://lwn.net/Articles/1093962/) همان دو جمله را برداشته؛ متن کامل در [اعلام لینوس](https://lwn.net/Articles/1093961/) است:

**«Another fairly large rc release, and again one with a bigger filesystem footprint that we usually see.»**

این‌بار عمدتاً **XFS** و **SMB client**، با فیکس‌هایی در **netfs** و **AFS** (و همچنین **erofs** و **btrfs**).

همان‌جا تعدیل کرده: «ردپای بزرگ‌تر از معمول» به‌معنی عظیم نیست. **بخش عمده** پچ rc3 هنوز سمت درایور است — این دور بیشتر sound و networking؛ GPU هست ولی خیلی بزرگ نیست. بقیه پخش است: فیکس core و شبکه، مقداری Landlock (و selftest)، و arch بیشتر روی **s390** و **powerpc**.

جملهٔ آخر اعلام مثل همیشه است: *Please keep testing.*

rc3 هنوز پیش‌نمایش است، نه درخت پایدار. اگر روی 7.3 تست می‌کنید، همین rc را بگیرید. برای production همان داستان همیشگی است: شاخهٔ stable توزیع یا درخت Greg، نه rc لینوس، مگر بدانید چرا rc می‌خواهید. دوشنبهٔ بعد همین هفته، Greg KH دستهٔ پایدار جداگانه‌ای با حجم بی‌سابقه فرستاد؛ آن را با rc3 قاطی نکنید.

</div>
