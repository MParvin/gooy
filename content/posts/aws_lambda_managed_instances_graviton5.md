---
title: "Lambda Managed Instances روی Graviton5: خانواده‌های C9g و M9g تا ۲۵٪ سریع‌تر از Graviton4"
date: 2026-09-17T13:20:00+03:30
draft: false
slug: "aws-lambda-managed-instances-graviton5"
tags: ["aws", "lambda", "graviton5", "c9g", "arm"]
categories: ["Cloud"]
description: "۹ سپتامبر: Lambda Managed Instances روی C9g/C9gd/M9g/M9gd. تا حدود ۲۵٪ compute بهتر نسبت به نسل Graviton4. انتخاب در capacity provider؛ default هم Graviton5 را در لیست می‌گذارد."
image: "/images/aws-lambda-graviton5.png"
---

<div dir="rtl">

Lambda Managed Instances همان مدل میانی است: تابع Lambda را روی EC2 حساب خودتان می‌گذارید، ولی lifecycle اینستنس، پچ OS/runtime، routing، load balancing و auto-scaling را خود لامبدا نگه می‌دارد. ایزولاسیون اینجا Firecracker ناوگان اشتراکی نیست؛ کانتینر روی Nitro در حساب شماست. قیمت هم per-request پیش‌فرض لامبدا نیست؛ EC2 به‌علاوهٔ کارمزد مدیریت.

۹ سپتامبر ۲۰۲۶ AWS در [What's New](https://aws.amazon.com/about-aws/whats-new/2026/09/aws-lambda-graviton5-ec2/) نوشت همین مدل حالا اینستنس‌های **Graviton5** را می‌گیرد. ادعای عملکرد: تا حدود **۲۵٪ compute بهتر** نسبت به اینستنس‌های **Graviton4**.

## چهار تایپ، یک capacity provider

خانواده‌ها:

- **C9g** / **C9gd** — compute
- **M9g** / **M9gd** — general purpose (d یعنی NVMe محلی)

موقع ساخت capacity provider تایپ را صریح می‌گذارید. اگر instance type را **default** بگذارید، لامبدا Graviton5 را هم در فهرست انتخاب می‌گذارد — بر اساس architecture تابع، حافظه، و نسبت memory-to-vCPU.

منطقه: هر جایی که **هم** Lambda Managed Instances **هم** این اینستنس‌های EC2 موجود باشند. این پست کنترل‌پلین مسیریابی مرز AWS نیست؛ فقط compute نسل بعد روی همین محصول Managed Instances است.

اسناد Managed Instances هنوز در بخش قابلیت‌ها از «آخرین CPU مثل Graviton4» حرف می‌زنند؛ اعلام ۹ سپتامبر همان فهرست را یک نسل جلو برد. تفاوت مدل اجرا سر جایش است: چند invoke هم‌زمان داخل یک execution environment (مناسب I/O)، scale بر اساس CPU نه cold start به ازای هر درخواست، و حداقل environment وقتی ترافیک صفر است.

اگر تابع burstی دارید که scale-to-zero می‌خواهد، مسیر پیش‌فرض لامبدا همان است. اگر بار پایدار می‌خواهید روی ARM تازه و Reserved Instance/Savings Plan، C9g/M9g همان دکمه‌ای است که ۹ سپتامبر باز شد.

</div>
