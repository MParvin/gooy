---
title: "AMD پچ‌های ESMTP را برای لینوکس فرستاد؛ حفاظت سخت‌افزاری SMT با SEV-SNP"
date: 2026-09-16T08:40:00+03:30
draft: false
slug: "amd-esmtp-sev-snp"
tags: ["amd", "sev-snp", "kvm", "smt", "esmtp", "linux"]
categories: ["Security", "Linux"]
description: "سری سه‌پچی ۱۴ سپتامبر ۲۰۲۶ روی LKML برای Enhanced SMT Protection: وقتی vCPU مهمان SEV-SNP اجراست، همزاد SMT باید host-idle باشد یا vCPU قانونی همان مهمان. Opt-in؛ نیاز به QEMU/OVMF."
image: "/images/amd-esmtp-sev-snp.png"
---

<div dir="rtl">

۱۴ سپتامبر ۲۰۲۶ Pratik R. Sampat از AMD سری **۳ پچ** با عنوان «Introduce Enhanced SMT Protection for SEV-SNP» را به LKML فرستاد — [cover letter](https://lkml.iu.edu/2609.1/16643.html). [Phoronix](https://www.phoronix.com/news/AMD-Enhanced-SMT-Protection) همان روز نوشت این اولین بار است ESMTP روی لیست کرنل دیده می‌شود؛ whitepaper AMD.com اوایل سال آمده بود و کمتر دیده شد. با زمان‌بندی enablement، Larabel حدس زده این قابلیت **EPYC 9006 «Venice»** باشد — حدس است، نه اعلام محصول.

ایده از core scheduling لینوکس آشناتر است و از آن سخت‌گیرانه‌تر.

## سخت‌افزار همزاد را باور نمی‌کند، نه کوکی زمان‌بند

Core scheduling با cookie در هستهٔ میزبان می‌گوید این دو thread باید هم‌خانواده باشند. ESMTP را CPU enforce می‌کند. ماسک همزاد داخل **VMSA** است. وقتی یک vCPU مهمان SEV-SNP در guest mode است، هر SMT sibling همان هستهٔ فیزیکی باید یا در host **idle** باشد، یا vCPUای را اجرا کند که خود مهمان قانونی‌اش اعلام کرده. میزبان حق ندارد روی sibling کار kernel، userspace یا حتی interrupt نامرتبط اجرا کند.

KVM و مهمان هر دو `VCPU_SIBLING_MASK` را پر می‌گذارند؛ یعنی همهٔ vCPUهای آن مهمان یک گروه می‌شوند و هر دو می‌توانند هم‌نشین باشند. با چک ASID، همزاد یک vCPU در guest mode یا vCPU همان مهمان است یا thread بیکار میزبان.

سه پچ سری:

1. KVM/SVM: رویدادهایی که inject نشده‌اند را دوباره صف کند
2. KVM/SVM: پشتیبانی میزبان ESMTP
3. x86/sev: پشتیبانی مهمان — نام ویژگی در dmesg میان SNP: `ESMTProt`

QEMU و OVMF جدا پچ می‌خواهند. نمونهٔ راه‌اندازی در cover letter:

`-object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,esmtp=on`

لینک OVMF: [edk2 PR 13128](https://github.com/tianocore/edk2/pull/13128). لینک QEMU روی lore.kernel.org/kvm در همان cover آمده. بدون SEV-SNP این ویژگی در دسترس نیست. SMTP قدیمی و ESMTP در SEV_FEATURES متقابل‌اند؛ روشن بودن هر دو VMRUN را با VMEXIT_INVALID می‌شکند — جزئیات در [سند AMD64 Enhanced SMT Protection](https://docs.amd.com/api/khub/documents/NonbFzm036g3YcW2EvrruQ/content) (مارس ۲۰۲۶).

## Opt-in، چون VMRUN صبر می‌کند

جملهٔ خود پچ: ESMTP پیش‌فرض نیست چون **هزینهٔ عملکرد** دارد؛ VMRUN تا وقتی sibling کار vCPU مورد اعتماد را اجرا کند یا host-idle شود stall می‌شود. برای ابر عمومی یا بار نامطمئن همان trade-off است که Phoronix برجسته کرده. تست تجربی cover letter: مهمان را روی siblingها pin کنید، داخل مهمان stress-ng روی هر دو thread؛ انتظار ۱۰۰٪ روی هر دو. بعد روی یکی از siblingها در میزبان بار بگذارید؛ آن CPU بین host و guest تقسیم می‌شود و thread همزاد مهمان مجبور به idle می‌شود.

این merge در mainline نیست. سری v1 روی لیست است، وابسته به QEMU/OVMF همگام، روی سخت‌افزاری که CPUID `EnhSmtProtection` را بدهد. اگر امروز Turin با SEV-SNP دارید، این پچ‌ها آن را جادو نمی‌کنند — برای نسل/سیلیکونی است که ESMTP دارد، و Phoronix آن را «احتمالاً Venice» خوانده.

</div>
