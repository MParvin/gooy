---
title: "KubeletInUserNamespace در v1.37 بتا شد؛ گیت روشن است، خود kubelet rootless نمی‌شود"
date: 2026-09-11T06:20:00+03:30
draft: false
slug: "kubernetes-v1-37-kubelet-user-namespace"
tags: ["kubernetes", "rootless", "user-namespace", "kubelet", "sig-node"]
categories: ["DevOps", "Security"]
description: "۴ سپتامبر: گیت KubeletInUserNamespace بتا و default-on است اما kubelet را خودکار داخل user namespace نمی‌برد. نود می‌تواند به‌عنوان غیر-root با userns لینوکس اجرا شود."
image: "/images/kubernetes-v1-37-kubelet-user-namespace.png"
---

<div dir="rtl">

تاریخچه breakout روی نود، تکراری است: CRI-O با `kernel.core_pattern` (CVE-2022-0811)، runc و masked paths (CVE-2023-27561)، kubelet و volume `gitRepo` (CVE-2024-10220)، دوباره runc روی procfs میزبان (CVE-2025-31133)، containerd و label تصویر (CVE-2026-53488). همه به root واقعی host می‌رسیدند. ۴ سپتامبر ۲۰۲۶ آکی‌هیرو سودا (NTT) در [بلاگ کوبرنتیز](https://kubernetes.io/blog/2026/09/04/kubernetes-v1-37-rootless-beta/) نوشت گیت **`KubeletInUserNamespace`** در **v1.37** بتا شده — همان «rootless mode» که از آزمایش ۲۰۱۸ و آلفا در v1.22 (KEP-2033) آمده.

جمله مهم پست را نباید جا انداخت: **گیت حالا پیش‌فرض روشن است، ولی kubelet را خودکار داخل user namespace نمی‌برد.** کلاستر rootful موجود بعد از ارتقا همان rootful می‌ماند. گیت فقط اجازه می‌دهد اگر نود را خودتان داخل userns لینوکس راه انداخته باشید، kubelet خطاهای permission روی بعضی sysctl (`vm.overcommit_memory`، `kernel.panic`) و watch روی `/dev/kmsg` را نادیده بگیرد. خود پست می‌گوید گیت «boring» است.

داخل userns، UID ۰ جعلی است و به همان namespace محدود. برای mount و cgroup و netns پاد معمولاً کافی است. آسیب به حساب کاربر غیر-root محدود می‌شود؛ مهاجم کرنل و bootloader و firmware را عوض نمی‌کند. userns آسیب‌پذیری **خود کرنل** را نمی‌بندد؛ باید با seccomp و سخت‌کردن سنتی همراه باشد. بعضی CNI/CSI با این مدل سازگار نیستند.

این را با **`UserNamespacesSupport`** پاد (`hostUsers: false`، GA از v1.36) عوض نگیرید. آن یکی پاد را در userns می‌گذارد و اجزای نود همچنان root می‌مانند. دو گیت تعارض ندارند؛ با کرنل جدید و containerd می‌شود تودرتو کرد: کلاستر nested داخل پاد `hostUsers: false` بدون `privileged: true`.

## از Alpha تا Beta چه دیده می‌شود

`kubectl get nodes -o yaml` حالا **`runningInUserNamespace`** را گزارش می‌کند تا admin بتواند taint/label بگذارد و installerهایی که root واقعی می‌خواهند روی نود rootless نیایند. تست conformance نود در CI روی کلاستر rootless هم می‌دود (`ci-kubernetes-e2e-kind-rootless`).

بیرون از گیت، چند قطعه مسیر nested را باز کرده: idmapped tmpfs در کرنل ۶٫۳، `UserNamespacesSupport` default-on از v1.33، cgroup قابل‌نوشتن در containerd ۲٫۱.

برای امتحان: **kind** روی Rootless Docker/nerdctl/Podman، **minikube** با `--driver=docker` بعد از `dockerd-rootless-setuptool.sh`، **Usernetes** برای چند نود با Flannel/VXLAN، و **k3s** rootless بدون runtime خارجی. GA هنوز وابسته به بازخورد است؛ KEP-5474 و KEP-5714 هم برای ساده‌تر کردن Kubernetes-in-Kubernetes روی میز SIG Node هستند.

</div>
