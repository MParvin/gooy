---
title: "نصب داکر در عصر حجر"
date: 2026-04-26
draft: false
description: "نصب داکر بدون اینترنت جهانی"
image: "/images/docker-stone-age-install.jpg"
-------------------------------

آپدیت:
یک اسکریپت نوشتم و داخل سایت قرار دادم که بتونید با استفاده ازش اتوماتیک داکر و داکر کامپوز رو نصب کنید:
[Install Docker]( /files/install_docker.sh )

* فعلا فقط لینوکس X86_64 رو ساپورت میکنه

راحت ترین راه برای نصب آخرین نسخه داکر از طریق این اسکریپت هست

[get.docker.com](https://get.docker.com)

قبلا توی یه پست ویرگول نوشتم که چرا روش خوبی هست:

[بهترین روش نصب داکر - ویرگول](https://virgool.io/@MParvin/%D8%A8%D9%87%D8%AA%D8%B1%DB%8C%D9%86-%D8%B1%D9%88%D8%B4-%D9%86%D8%B5%D8%A8-%D8%AF%D8%A7%DA%A9%D8%B1-%D8%AF%D8%B1-%D9%84%DB%8C%D9%86%D9%88%DA%A9%D8%B3-z34oqfuzlegq)

ولی میدونیم دسترسی به فایل هایی که این اسکریپت دانلود میکنه نیست
پس فایل های داکر رو توی لپ تاپ دانلود کردم
آدرس اصلی:

```
https://download.docker.com/linux/static/stable/x86_64/docker-29.0.1.tgz
```

بعد از دانلود با قطره نت، آپلودش کردم اینجا که از داخل ایران بشه دانلود کرد:

```
[Docker-29.3.1.tgz](https://dl.gooy.site/docker-29.3.1.tgz)
[Docker.service](https://dl.gooy.site/docker.service)
```


اگر سرور اینترنت ملی داره،‌ این کامند رو بزنید

```
wget https://dl.gooy.site/docker-29.3.1.tgz
wget https://dl.gooy.site/docker.service
```

اگر سرور حتی اون رو هم نداره، روی لپ تاپ خودتون دانلود کنید بعد

کپی از لپ تاپ به سرور

```
scp docker-29.0.1.tgz gooy:
```

اونجایی که نوشتم gooy بجاش آی پی یا دامین سرورتون رو بنویسید.

extract کردن

```
tar xvf docker-29.3.1.tgz
```

انتقال به پوشه ها

```
mv docker/* /usr/bin/
mv docker.service /etc/systemd/system/docker.service
```

ریلود و فعال کردن سرویس ها

```
systemctl daemon-reload
systemctl enable --now docker
```

امیدوارم مفید باشه