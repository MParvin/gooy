---
title: "Cilium 1.20: Gateway API تا v1.6، ENI IPv6 و باینری CNI حدود ۸۰٪ کوچک‌تر"
date: 2026-09-15T10:40:00+03:30
draft: false
tags: ["cilium", "cni", "gateway-api", "ebpf", "clustermesh", "kubernetes"]
categories: ["DevOps"]
description: "ریلیز ۱.۲۰ سیلیوم Gateway API را از v1.4 به v1.6 برد؛ ExternalAuth، CORS، ListenerSets، TCPRoute/UDPRoute، ENI IPv6 بتا، و cilium-cni از ۷۶MB به ۱۶MB."
image: "/images/cilium-1-20-gateway-api.png"
---

<div dir="rtl">

۱۴ سپتامبر ۲۰۲۶، Nico Vibert و Donia Chaiehloudj در [وبلاگ CNCF](https://www.cncf.io/blog/2026/09/14/cilium-1-20-gateway-api-externalauth-tcproute-udproute-eni-ipam-for-ipv6-and-more/) نسخه **۱٫۲۰** را دومین major متن‌باز سیلیوم در ۲۰۲۶ بعد از ۱٫۱۹ معرفی کردند. سه خط داستان خودشان این است: north-south دیگر فقط HTTP نیست؛ datapath برای cloud provider قابل گسترش شده؛ و قابلیت‌هایی که سیلیوم زودتر ساخته بود حالا کنار APIهای portable کوبرنتیز نشسته‌اند.

## از Ingress به یک API برای HTTP و L4

۱٫۱۹ روی Gateway API **v1.4** بود. ۱٫۲۰ به **v1.6** می‌پرد. از مسیر v1.5، فیلتر CORS روی HTTPRoute و **ListenerSets** به کانال Standard رسیده‌اند؛ authentication سطح Gateway/HTTPRoute هنوز experimental است. از v1.6، **TCPRoute** و **UDPRoute** هم Standard شده‌اند.

**ExternalAuth** (GEP-1494) همان شکاف north-south را می‌بندد: فیلتر روی HTTPRoute، قبل از backend، با یک سرویس authorization خارجی حرف می‌زند. `200` یعنی عبور؛ `302` ریدایرکت لاگین؛ `401`/`403` ایست در خود gateway. نویسنده می‌تواند هدر هویت تزریق کند تا اپ پسورد را نبیند.

اگر هنوز سرویس TCP/UDP را با LoadBalancer خام می‌دهید، حالا همان Gateway مشترک می‌تواند پورت دیتابیس و DNS را هم نگه دارد. ListenerSets هم مالکیت را می‌شکند: تیم پلتفرم Gateway را دارد، تیم اپ از namespace خودش Listener اضافه می‌کند، آدرس یکی می‌ماند.

## جایی که سیلیوم دیگر appliance بسته نیست

**ENI IPAM برای IPv6** بعد از چهار سال درخواست، در ۱٫۲۰ **بتا** است. قبلاً حالت ENI فقط IPv4 بود. operator یک prefix **IPv6 /80** با Prefix Delegation به ENI نود می‌چسباند و agent آدرس پاد را از همان می‌دهد. کار Datadog.

**datapath plugin**ها را گوگل ساخته: پروسه جدا، image جدا، بدون fork کردن سیلیوم. کرش پلاگین agent را پایین نمی‌آورد. CRD: `CiliumDatapathPlugin`.

**netkit auto:** `bpf.datapathMode=auto` موقع استارت کرنل را probe می‌کند؛ اگر ≥۶٫۸ باشد netkit، وگرنه veth. پیش‌فرض هنوز veth است تا چیزی بی‌اجازه عوض نشود.

**ClusterNetworkPolicy** بالادستی را پیاده کرده: tier **Admin** بالاتر از NetworkPolicy نام‌فضا، **Baseline** به‌عنوان پیش‌فرض قابل override. **MCS-API** در ClusterMesh به سطح **stable** رسیده؛ DNS استاندارد `*.svc.clusterset.local`.

**ztunnel** هنوز بتا است ولی CA قابل تنظیم شده (`internal` بدون SPIRE، یا SPIRE/SPIFFE) و متریک Prometheus گرفته. maintainers **legacy Mutual Authentication** را deprecated کرده‌اند؛ حذف برای ریلیز بعدی برنامه‌ریزی شده. ztunnel احراز و رمز را وسط مسیر می‌گذارد، first-packet drop مدل قدیمی را ندارد، و ترافیک هم‌نود را هم رمز می‌کند.

باینری **cilium-cni** در ۱٫۱۹ حدود **۷۶MB** بود؛ در ۱٫۲۰ حدود **۱۶MB** — برش حدود **۷۹٪**، همان «نزدیک ۸۰٪» اعلام. Maglev هم وزن `service.cilium.io/weight` را از EndpointSlice می‌خواند؛ وزن ۰ یعنی drain بدون قطع اتصال موجود.

</div>
