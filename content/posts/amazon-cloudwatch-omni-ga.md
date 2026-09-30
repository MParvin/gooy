---
title: "CloudWatch Omni به GA رسید؛ observability یکپارچه برای اپ و agentهای AI"
date: 2026-09-23T16:00:00+03:30
draft: false
slug: "amazon-cloudwatch-omni-ga"
tags: ["aws", "cloudwatch", "observability", "opentelemetry", "ai-agents", "sre"]
categories: ["Cloud", "DevOps"]
description: "AWS عمومی شدن Amazon CloudWatch Omni را اعلام کرد: Spaces چندحسابی، OpenTelemetry، چت زبان طبیعی با DevOps Agent و observability اختصاصی برای frameworkهای agent."
image: "/images/amazon-cloudwatch-omni-ga.png"
---

<div dir="rtl">

SRE و تیم پلتفرم معمولاً بین داشبورد متریک، trace و لاگ agentها پاره می‌شوند. ۲۳ سپتامبر ۲۰۲۶ آمازون در [what's new](https://aws.amazon.com/about-aws/whats-new/2026/09/amazon-cloudwatch-omni-ai/) اعلام کرد **Amazon CloudWatch Omni** از حالت پیش‌نمایش خارج شده و **generally available** است: observability با محور تیم/اپ، و با نگاه AI-first به خود اپ و به agentهایی که کنارش اجرا می‌شوند.

مدل داده روی سازگاری **OpenTelemetry** و مقیاس CloudWatch نشسته است. تجربهٔ کاربری یک وب اپ standalone با SSO است، به‌علاوهٔ افزونهٔ IDE محلی برای **VS Code، Cursor و Kiro** تا کار agent بدون نیاز به AWS account روی خود اکستنشن جلو برود. **Spaces** می‌توانند حساب‌ها و Regionهای AWS و حتی ابرهای دیگر — از جمله Azure — را کنار هم ببینند.

کشف خودکار سرویس، dependency map و golden metrics بخشی از همان لایهٔ اول هستند. چت زبان طبیعی روی **AWS DevOps Agent** سوار شده تا سؤال عملیاتی را به سیگنال observability وصل کند. برای frameworkهای agent، observability و evaluation جداگانه برای **LangGraph، CrewAI، OpenAI Agents SDK، Vercel AI SDK و Strands** آمده است — یعنی نه فقط «لاگ مدل»، بلکه مسیر ارزیابی رفتار agent.

منطقه‌های GA اعلام‌شده: **us-east-1، us-west-2 و eu-west-1**. اگر از قبل pipeline تلمتری‌تان به OTel نزدیک است، Omni بیشتر شبیه لایهٔ سازمان‌دهی و کار روزمره است تا یک silo جدید؛ برای تیم‌هایی که هم اپ کلاسیک دارند هم agent در production، همین یکپارچگی نقطهٔ جذاب ماجراست.

</div>
