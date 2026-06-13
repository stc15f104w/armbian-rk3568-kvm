#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
src_dir="${repo_root}/armbian-rk3568-kvm"
build_dir="${1:-${repo_root}/build}"
userpatches="${build_dir}/userpatches"

mkdir -p \
  "${userpatches}/config/boards" \
  "${userpatches}/kernel/rockchip-rk3568-current" \
  "${userpatches}/kernel/rockchip-rk3568-edge" \
  "${userpatches}/kernel/rockchip64-current" \
  "${userpatches}/kernel/rockchip64-edge" \
  "${userpatches}/kernel/archive/rockchip-rk3568-6.12" \
  "${userpatches}/kernel/archive/rockchip-rk3568-6.6" \
  "${userpatches}/kernel/archive/rockchip64-6.12" \
  "${userpatches}/kernel/archive/rockchip64-6.6"

cp "${src_dir}/config/rk3568-ydtx-kvm.csc" \
  "${userpatches}/config/boards/rk3568-ydtx-kvm.csc"

for target in \
  "${userpatches}/kernel/rockchip-rk3568-current/patch-001-add-rk3568-ydtx-kvm-dts.patch" \
  "${userpatches}/kernel/rockchip-rk3568-edge/patch-001-add-rk3568-ydtx-kvm-dts.patch" \
  "${userpatches}/kernel/rockchip64-current/patch-001-add-rk3568-ydtx-kvm-dts.patch" \
  "${userpatches}/kernel/rockchip64-edge/patch-001-add-rk3568-ydtx-kvm-dts.patch" \
  "${userpatches}/kernel/archive/rockchip-rk3568-6.12/patch-001-add-rk3568-ydtx-kvm-dts.patch" \
  "${userpatches}/kernel/archive/rockchip-rk3568-6.6/patch-001-add-rk3568-ydtx-kvm-dts.patch" \
  "${userpatches}/kernel/archive/rockchip64-6.12/patch-001-add-rk3568-ydtx-kvm-dts.patch" \
  "${userpatches}/kernel/archive/rockchip64-6.6/patch-001-add-rk3568-ydtx-kvm-dts.patch"; do
  {
    printf '%s\n' 'diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile'
    printf '%s\n' 'index 000000000000..111111111111 100644'
    printf '%s\n' '--- a/arch/arm64/boot/dts/rockchip/Makefile'
    printf '%s\n' '+++ b/arch/arm64/boot/dts/rockchip/Makefile'
    printf '%s\n' '@@ -0,0 +1 @@'
    printf '%s\n' '+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-ydtx-kvm.dtb'
    printf '%s\n' 'diff --git a/arch/arm64/boot/dts/rockchip/rk3568-ydtx-kvm.dts b/arch/arm64/boot/dts/rockchip/rk3568-ydtx-kvm.dts'
    printf '%s\n' 'new file mode 100644'
    printf '%s\n' 'index 000000000000..222222222222'
    printf '%s\n' '--- /dev/null'
    printf '%s\n' '+++ b/arch/arm64/boot/dts/rockchip/rk3568-ydtx-kvm.dts'
    sed 's/^/+/' "${src_dir}/patches/rk3568-ydtx-kvm.dts"
  } > "${target}"
done

echo "Prepared Armbian userpatches in ${userpatches}"
