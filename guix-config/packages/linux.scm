(define-module (guix-config packages linux)
  #:use-module (guix download)
  #:use-module (guix packages)
  #:use-module (gnu packages linux))


(define-public linux-libre-arm64-armbian
  (customize-linux
   #:name "linux-libre-arm64-armbian"
   #:linux linux-libre-arm64-generic
   #:extra-version "arm64-armbian"
   #:defconfig (let ((version "v26.02")
                     (repo-url "https://github.com/armbian/build/blob/")
                     (subversion "current"))
                 (origin
                   (method url-fetch)
                   (uri
                    (string-append
                     repo-url
                     "/config/kernel/"
                     "linux-rockchip64"
                     "-"
                     subversion
                     ".config"))
                   (sha256
                    (base32
                     "1k80cmfkm3pp3gp5498vm5jhmzvrc44wv2x436vrii7hkm40gm9f"))))))

(define-public linux-libre-arm64-generic+nft
  (customize-linux
   #:name "linux-libre-arm64-generic+nft"
   #:linux linux-libre-arm64-generic
   #:extra-version "arm64-generic+nft"
   #:configs '("CONFIG_NF_CONNTRACK=m"
               "CONFIG_NF_CONNTRACK_SECMARK=y"
               "CONFIG_NETWORK_SECMARK=y"
               "CONFIG_NF_CONNTRACK_ZONES=y"
               "CONFIG_NF_CONNTRACK_EVENTS=y"
               "CONFIG_NF_CONNTRACK_TIMEOUT=y"
               "CONFIG_NF_CONNTRACK_TIMESTAMP=y"
               "CONFIG_NF_CONNTRACK_AMANDA=m"
               "CONFIG_NF_CONNTRACK_FTP=m"
               "CONFIG_NF_CONNTRACK_H323=m"
               "CONFIG_NF_CONNTRACK_IRC=m"
               "CONFIG_NF_CONNTRACK_NETBIOS_NS=m"
               "CONFIG_NF_CONNTRACK_SNMP=m"
               "CONFIG_NF_CONNTRACK_PPTP=m"
               "CONFIG_NF_CONNTRACK_SANE=m"
               "CONFIG_NF_CONNTRACK_SIP=m"
               "CONFIG_NF_CONNTRACK_TFTP=m"
               "CONFIG_NF_CT_NETLINK=m"
               "CONFIG_NF_CT_NETLINK_TIMEOUT=m"
               "CONFIG_NF_CT_NETLINK_HELPER=m"
               "CONFIG_NETFILTER_QUEUE=m"
               "CONFIG_NF_TABLES=m"
               "CONFIG_NF_TABLES_INET=y"
               "CONFIG_NF_TABLES_NETDEV=y"
               "CONFIG_NF_FLOW_TABLE_INET=m"
               "CONFIG_NF_FLOW_TABLE=m"
               "CONFIG_NF_TABLES_ARP=y"
               "CONFIG_NF_LOG_ARP=m"
               "CONFIG_NF_LOG_IPV4=m"
               "CONFIG_NF_TABLES_BRIDGE=m"
               "CONFIG_NF_CONNTRACK_BRIDGE=m"
               "CONFIG_NFT_NUMGEN=m"
               "CONFIG_NFT_CT=m"
               "CONFIG_NFT_FLOW_OFFLOAD=m"
               "CONFIG_NFT_CONNLIMIT=m"
               "CONFIG_NFT_LOG=m"
               "CONFIG_NFT_LIMIT=m"
               "CONFIG_NFT_MASQ=m"
               "CONFIG_NFT_REDIR=m"
               "CONFIG_NFT_NAT=m"
               "CONFIG_NFT_TUNNEL=m"
               "CONFIG_NFT_QUEUE=m"
               "CONFIG_NETFILTER_NETLINK_QUEUE=m"
               "CONFIG_NFT_QUOTA=m"
               "CONFIG_NFT_REJECT=m"
               "CONFIG_NFT_COMPAT=m"
               "CONFIG_NFT_HASH=m"
               "CONFIG_NFT_FIB_INET=m"
               "CONFIG_NFT_XFRM=m"
               "CONFIG_XFRM"
               "CONFIG_NFT_SOCKET=m"
               "CONFIG_NFT_OSF=m"
               "CONFIG_NFT_TPROXY=m"
               "CONFIG_NFT_SYNPROXY=m"
               "CONFIG_NFT_DUP_NETDEV=m"
               "CONFIG_NFT_FWD_NETDEV=m"
               "CONFIG_NFT_FIB_NETDEV=m"
               "CONFIG_NFT_REJECT_NETDEV=m"
               "CONFIG_NFT_DUP_IPV4=m"
               "CONFIG_NFT_FIB_IPV4=m"
               "CONFIG_NFT_DUP_IPV6=m"
               "CONFIG_NFT_FIB_IPV6=m"
               "CONFIG_NFT_BRIDGE_META=m"
               "CONFIG_NFT_BRIDGE_REJECT=m")))

(define-public linux-libre-arm64-full
  (package
    (inherit
     ((@@ (gnu packages linux) make-linux-libre*)
      (@@ (gnu packages linux) linux-libre-version)
      (@@ (gnu packages linux) linux-libre-gnu-revision)
      (@@ (gnu packages linux) linux-libre-source)
      '("aarch64-linux")
      #:defconfig "defconfig"
      #:configuration-file (@@ (gnu packages linux) kernel-config)
      #:extra-version "arm64-full"
      #:extra-options
      (append
       `(("CONFIG_MMC" . #t)
         ("CONFIG_MMC_BLOCK" . #t)
         ("CONFIG_MMC_DW" . #t)
         ("CONFIG_MMC_DW_ROCKCHIP" . #t)
         ("CONFIG_COMMON_CLK_RK3328" . #t)
         ;; Provide support for ath9k wireless
         ("CONFIG_ATH9K_HTC" . m)
         ;; Support Orange Pi R1 Plus LTS ethernet PHY.
         ("CONFIG_MOTORCOMM_PHY" . m)
         ;; needed to fix the RTC on rockchip platforms
         ("CONFIG_RTC_DRV_RK808" . #t)
         ;; Pinebook display, battery, charger and usb
         ("CONFIG_DRM_ANALOGIX_ANX6345" . m)
         ("CONFIG_CHARGER_AXP20X" . m)
         ("CONFIG_INPUT_AXP20X_PEK" . m)
         ("CONFIG_CHARGER_AXP20X" . m)
         ("CONFIG_BATTERY_AXP20X" . m)
         ("CONFIG_PINCTRL_AXP209" . m)
         ("CONFIG_AXP20X_POWER" . m)
         ("CONFIG_AXP20X_ADC" . m)
         ;; Pinebook PRO battery and sound support
         ("CONFIG_BATTERY_CW2015" . m)
         ("CONFIG_CHARGER_GPIO" . m)
         ("CONFIG_SND_SOC_ES8316" . m))
       ((@@ (gnu packages linux) default-extra-linux-options) linux-libre-version))))
    (name "linux-libre-arm64-full")))
