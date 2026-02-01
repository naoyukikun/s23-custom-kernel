<!-- BEGIN-EN -->
# Kokuban Kernel for Samsung Galaxy S23 Series by naoyuki

<p align="center">
<img src="https://raw.githubusercontent.com/YuzakiKokuban/Kokuban_Kernel_CI_Center/main/docs/kokuban_logo.png" alt="Logo" width="150">
</p>

<p align="center">
<a href="https://github.com/YuzakiKokuban/android_kernel_samsung_sm8550_S23/releases"><img src="https://img.shields.io/github/v/release/YuzakiKokuban/android_kernel_samsung_sm8750?style=for-the-badge&logo=github&color=blue" alt="GitHub release"></a>
<a href="https://t.me/kokubanchat"><img src="https://img.shields.io/badge/Telegram-Chat-blue.svg?style=for-the-badge&logo=telegram" alt="Telegram"></a>
</p>

This is a high-performance custom kernel for the **Samsung Galaxy S23 Series**, built upon Samsung's official kernel source. It is designed to deliver exceptional stability and smoothness while integrating the latest KernelSU features for the ultimate user experience.

## 📌 Highlights

* **Official Source Base**: Built on the latest official kernel source from Samsung, ensuring optimal compatibility and stability.

* **Performance-Tuned**: Targeted performance and scheduling optimizations for a smoother daily usage and gaming experience.

* **KernelSU Integrated**: Comes with multiple KernelSU variants (Official, MKSU, ReSukiSU) built-in for an out-of-the-box experience.

* **Version Info**: `-android13-Kokuban-Firefly-EYI7`

## 🧩 Available Variants Explained

* **LKM (Loadable Kernel Module)**

  * Does not include any built-in root solution, maintaining the purity of the stock kernel.

  * **Security**: Only essential Samsung security policies that affect modding (like RKP, KDP) are removed.

  * **Usage**: Requires you to manually patch your device's `init_boot` partition using the KernelSU Manager App to achieve root.

* **KSU (KernelSU)**

  * Built-in with the official, unmodified KernelSU for the most authentic root experience.

* **MKSU (Magic KernelSU)**

  * Features KernelSU modified by `5ec1cff`, which notably supports Magic Mount for easier module management.

* **ReSuki (ReSukiSU)**

  * Integrated with the powerful ReSukiSU, supporting SUSFS and KPM modules, offering advanced features for power users.

## ⚙️ Installation Guide

1. **Unlock Bootloader**: Ensure your device's bootloader is unlocked.

2. **Flash Recovery**: It is recommended to use the latest version of TWRP or OrangeFox Recovery.

3. **Flash Kernel**: Flash the kernel `zip` package downloaded from the Releases page in this project via Recovery.

4. **(LKM Version Only) Patch `init_boot`**:

   * Back up your current `init_boot.img`.

   * Use the KernelSU Manager App to select and patch this image.

   * Flash the resulting `kernelsu_boot.img` to your device's `init_boot` partition via Fastboot or Recovery.

5. **Reboot your device** and enjoy the new kernel!

## 📥 Downloads

All the latest builds can be found on the [**Releases Page**](https://github.com/YuzakiKokuban/android_kernel_samsung_sm8550_S23/releases).

## ⚠️ Disclaimer

Flashing custom software carries inherent risks. Please make a full backup of your personal data before proceeding. I am not responsible for any damage to your device or data loss that may occur as a result of flashing this kernel.

---
<!-- END-EN -->

<p align="center">
<a href="https://www.paypal.me/LangQin280">☕ Support Me</a>
</p>
