---
title: "کوبرنتیز ۱٫۳۷: noexec روی bind mount و sticky bit برای emptyDir، هنوز آلفا"
date: 2026-09-17T12:40:00+03:30
draft: false
slug: "kubernetes-v1-37-hardening-container-storage"
tags: ["kubernetes", "emptydir", "noexec", "sig-storage", "kep-5855"]
categories: ["DevOps", "Security"]
description: "۱۶ سپتامبر: VolumeBindMountOptions و EmptyDirVolumeMode در v1.37 آلفا. noexec/nosuid/nodev روی bind mount؛ mode مثل 01777 برای emptyDir. غیر از هیستوگرام و Memory QoS."
image: "/images/kubernetes-v1-37-hardening-container-storage.png"
---

<div dir="rtl">

پست‌های قبلی ۱٫۳۷ در گوی دربارهٔ هیستوگرام بومی پرومتئوس، Memory QoS و Workload-Aware Scheduling بودند. ۱۶ سپتامبر ۲۰۲۶ Nispriha Jagan و Neeraj Krishna Gopalakrishna از Red Hat در [بلاگ کوبرنتیز](https://kubernetes.io/blog/2026/09/16/kubernetes-v1-37-hardening-container-storage/) مسیر دیگری را باز کردند: سخت‌کردن **volume mount** داخل کانتینر.

پیش‌فرض امروز این است که runtime و kubelet volume را بدون `noexec`، `nosuid` و `nodev` bind می‌کنند. حتی با `readOnlyRootFilesystem: true`، پروسهٔ compromised می‌تواند روی `emptyDir` یا PersistentVolume باینری بنویسد، `chmod +x` کند و اجرا کند. `mountOptions` روی PV هم همان لایه نیست: فلگ فایل‌سیستم CSI است، نه فلگ bind داخل کانتینر.

## دو feature gate، دو KEP

هر دو در v1.37 **آلفا**اند و باید روی API server و kubelet روشن شوند:

- **`VolumeBindMountOptions`** (KEP-5855). فیلد `bindMountOptions` روی `volumeMounts`؛ مثلاً `[noexec, nosuid]`. روی emptyDir، PV، CSI، projected، ConfigMap و Secret کار می‌کند. **image volume پشتیبانی نمی‌شود.**
- **`EmptyDirVolumeMode`** (KEP-5502). فیلد `mode` روی خود `emptyDir`. پیش‌فرض تاریخی **0777** بود؛ حالا می‌شود **01777** (sticky bit مثل `/tmp`) یا مثلاً **0750**.

Auditها این شکاف را سال‌ها نوشته بودند: issue **#48912** و یافتهٔ NCC در audit امنیتی ۱٫۲۴ (**NCC-E003660-7HM** / issue **#119627**).

برای `/tmp` مشترک بین builder و sidecar، sticky bit یعنی فقط owner فایل (یا root) حق حذف دارد؛ یک کانتینر فایل دیگری را `rm` نمی‌کند. تأیید داخل پاد:

```text
sh: ./test.sh: Permission denied   # روی volume با noexec
rm: can't remove '/tmp/guest_file': Operation not permitted  # روی 01777
```

## چیزی که آلفا را شکننده می‌کند

Runtime باید فیلد CRI `mount_options` را advertise کند. scheduler با Node Declared Features پاد را روی نود ناسازگار نمی‌گذارد؛ اگر برسد kubelet **reject** می‌کند، silent degradation نیست. خود `mode` برای emptyDir به پشتیبانی runtime نیاز ندارد. اگر API server گیت را داشته باشد و kubelet نه، `mode` پذیرفته می‌شود و kubelet به 0777 برمی‌گردد.

`fsGroup` مجوز گروه را روی `mode` emptyDir override می‌کند — همان رفتار `defaultMode` برای Secret/ConfigMap. لینوکس فقط؛ روی ویندوز `bindMountOptions` اثر ندارد و `mode` skip می‌شود.

اگر omit کنید رفتار قدیمی می‌ماند. این هنوز GA نیست؛ برای سیاست CIS روی writable mount، بالاخره مسیر native آمده نه initContainer با `chmod`.

</div>
