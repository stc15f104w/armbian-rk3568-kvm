BOARD_NAME="IKAS KVM RK3568"
BOARD_VENDOR="ydtx"
BOARDFAMILY="rockchip64"
BOARD_MAINTAINER=""
INTRODUCED="2026"
BOOT_SOC="rk3568"
KERNEL_TARGET="current,edge"
KERNEL_TEST_TARGET="current"
BOOT_FDT_FILE="rockchip/rk3568-ydtx-kvm.dtb"
SRC_EXTLINUX="no"
IMAGE_PARTITION_TABLE="gpt"
BOOT_LOGO="desktop"
FULL_DESKTOP="no"
ASOUND_STATE="asound.state.station-m2"

# R5C images are known to boot on this hardware family; keep the same
# RK3568 U-Boot generation path and replace only the Linux DTB.
enable_extension "uboot-btrfs"

BOOTBRANCH_BOARD="tag:v2026.01"
BOOTPATCHDIR="v2026.01"
BOOTCONFIG="nanopi-r5c-rk3568_defconfig"

OVERLAY_PREFIX="rockchip-rk3568"

function post_family_config__uboot_config() {
	display_alert "$BOARD" "u-boot ${BOOTBRANCH_BOARD} overrides" "info"
	BOOTDELAY=2
	UBOOT_TARGET_MAP="ROCKCHIP_TPL=${RKBIN_DIR}/${DDR_BLOB} BL31=$RKBIN_DIR/$BL31_BLOB spl/u-boot-spl u-boot.bin flash.bin;;idbloader.img u-boot.itb"
}
