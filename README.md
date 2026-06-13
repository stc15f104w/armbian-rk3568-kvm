# IKAS KVM RK3568 Armbian Builder

This folder builds an Armbian mainline image for the RK3568 board described by `patches/rk3568-ydtx-kvm.dts`.

Defaults:

- board: `rk3568-ydtx-kvm`
- SoC family: `rockchip64`
- U-Boot config: `nanopi-r5c-rk3568_defconfig`
- kernel branch: `current`
- release: Debian `bookworm`
- image: minimal server image, no desktop

## GitHub Actions

Push this repository to GitHub, then run **Build Armbian RK3568 KVM** from the Actions tab.

The workflow downloads `armbian/build`, injects:

- `userpatches/config/boards/rk3568-ydtx-kvm.csc`
- a kernel patch that adds `rk3568-ydtx-kvm.dts`

When the job finishes, download the `armbian-rk3568-kvm-*` artifact. The image is under `build/output/images`.

## Local Notes

Windows is not used for compiling. If you later want a local build, use WSL2 or Linux with plenty of disk space, preferably on a large drive such as `D:\armbian-build`.

Example from Linux/WSL2:

```bash
mkdir -p /mnt/d/armbian-build
git clone --depth=1 https://github.com/armbian/build.git /mnt/d/armbian-build/build
./scripts/prepare-userpatches.sh /mnt/d/armbian-build/build
cd /mnt/d/armbian-build/build
./compile.sh build BOARD=rk3568-ydtx-kvm BRANCH=current RELEASE=bookworm BUILD_MINIMAL=yes BUILD_DESKTOP=no KERNEL_CONFIGURE=no EXPERT=yes
```

## First Boot Checklist

- Use serial console for the first boot.
- If U-Boot cannot find the board DTB, check `/boot/armbianEnv.txt` for `fdtfile=rockchip/rk3568-ydtx-kvm.dtb`.
- The board config intentionally follows Armbian's `nanopi-r5c.csc` boot settings because NanoPi R5C images are known to reach userspace on similar hardware.
- If the image builds but does not boot, try changing `BOOTCONFIG` in `config/rk3568-ydtx-kvm.csc` to another close RK3568 board U-Boot defconfig.
- Current Armbian/build does not provide `rockchip-rk3568` as a source family, so this board uses `rockchip64`.
- The DTS came from a vendor/decompiled tree, so mainline drivers may ignore some vendor-only nodes. Basic boot, UART, storage, USB and Ethernet should be validated first.
