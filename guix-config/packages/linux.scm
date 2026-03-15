(define-module (guix-config packages linux)
  #:use-module (gnu packages linux)
  #:use-module (nongnu packages linux))

;;
(define-public linux-arm64-generic+nft
  (customize-linux
   #:name "linux-arm64-generic+nft"
   #:linux linux-arm64-generic
   #:extra-version "arm64-generic+nft"

   #:configs '("CONFIG_IP_ADVANCED_ROUTER=y"
               "CONFIG_IP_MULTIPLE_TABLES=y"
               "CONFIG_IPV6_MULTIPLE_TABLES=y"
               "CONFIG_IPV6_SUBTREES=y"
               "CONFIG_NF_TABLES_IPV6=y"
               "CONFIG_NFT_FIB_IPV6=m"
               "CONFIG_NF_NAT_IPV4=y"
               "CONFIG_NF_NAT_IPV6=y"
               "CONFIG_NF_DEFRAG_IPV4=m"
               "CONFIG_IP_NF_IPTABLES_LEGACY=m"
               "CONFIG_NF_SOCKET_IPV4=m"
               "CONFIG_NF_TPROXY_IPV4=m"
               "CONFIG_NF_TABLES_IPV4=y"
               "CONFIG_NFT_REJECT_IPV4=m"
               "CONFIG_NFT_DUP_IPV4=m"
               "CONFIG_NFT_FIB_IPV4=m"
               "CONFIG_NF_TABLES_ARP=y"
               "CONFIG_NF_DUP_IPV4=m"
               "CONFIG_NF_LOG_ARP=m"
               "CONFIG_NF_LOG_IPV4=m"
               "CONFIG_NF_REJECT_IPV4=m"
               "CONFIG_NF_NAT_SNMP_BASIC=m"
               "CONFIG_NF_NAT_PPTP=m"
               "CONFIG_NF_NAT_H323=m"
               "CONFIG_IP_NF_IPTABLES=m"
               "CONFIG_IP_NF_MATCH_AH=m"
               "CONFIG_IP_NF_MATCH_ECN=m"
               "CONFIG_IP_NF_MATCH_RPFILTER=m"
               "CONFIG_IP_NF_MATCH_TTL=m"
               "CONFIG_IP_NF_FILTER=m"
               "CONFIG_IP_NF_TARGET_REJECT=m"
               "CONFIG_IP_NF_TARGET_SYNPROXY=m"
               "CONFIG_IP_NF_NAT=m"
               "CONFIG_IP_NF_TARGET_MASQUERADE=m"
               "CONFIG_IP_NF_TARGET_NETMAP=m"
               "CONFIG_IP_NF_TARGET_REDIRECT=m"
               "CONFIG_IP_NF_MANGLE=m"
               "CONFIG_IP_NF_TARGET_ECN=m"
               "CONFIG_IP_NF_TARGET_TTL=m"
               "CONFIG_IP_NF_RAW=m"
               "CONFIG_IP_NF_SECURITY=m"
               "CONFIG_IP_NF_ARPTABLES=m"
               "CONFIG_NFT_COMPAT_ARP=m"
               "CONFIG_IP_NF_ARPFILTER=m"
               "CONFIG_IP_NF_ARP_MANGLE=m"
               "CONFIG_NETFILTER=y"
               "CONFIG_NETFILTER_ADVANCED=y"
               "CONFIG_NETFILTER_INGRESS=y"
               "CONFIG_NETFILTER_EGRESS=y"
               "CONFIG_NETFILTER_SKIP_EGRESS=y"
               "CONFIG_NETFILTER_NETLINK=m"
               "CONFIG_NETFILTER_FAMILY_BRIDGE=y"
               "CONFIG_NETFILTER_FAMILY_ARP=y"
               "CONFIG_NETFILTER_BPF_LINK=y"
               "CONFIG_NETFILTER_NETLINK_HOOK=m"
               "CONFIG_NETFILTER_NETLINK_ACCT=m"
               "CONFIG_NETFILTER_NETLINK_QUEUE=m"
               "CONFIG_NETFILTER_NETLINK_LOG=m"
               "CONFIG_NETFILTER_NETLINK_OSF=m"
               "CONFIG_NF_CONNTRACK=m"
               "CONFIG_NF_LOG_SYSLOG=m"
               "CONFIG_NETFILTER_CONNCOUNT=m"
               "CONFIG_NF_CONNTRACK_MARK=y"
               "CONFIG_NF_CONNTRACK_SECMARK=y"
               "CONFIG_NF_CONNTRACK_ZONES=y"
               "CONFIG_NF_CONNTRACK_PROCFS=y"
               "CONFIG_NF_CONNTRACK_EVENTS=y"
               "CONFIG_NF_CONNTRACK_TIMEOUT=y"
               "CONFIG_NF_CONNTRACK_TIMESTAMP=y"
               "CONFIG_NF_CONNTRACK_LABELS=y"
               "CONFIG_NF_CONNTRACK_OVS=y"
               "CONFIG_NF_CT_PROTO_GRE=y"
               "CONFIG_NF_CT_PROTO_SCTP=y"
               "CONFIG_NF_CT_PROTO_UDPLITE=y"
               "CONFIG_NF_CONNTRACK_AMANDA=m"
               "CONFIG_NF_CONNTRACK_FTP=m"
               "CONFIG_NF_CONNTRACK_H323=m"
               "CONFIG_NF_CONNTRACK_IRC=m"
               "CONFIG_NF_CONNTRACK_BROADCAST=m"
               "CONFIG_NF_CONNTRACK_NETBIOS_NS=m"
               "CONFIG_NF_CONNTRACK_SNMP=m"
               "CONFIG_NF_CONNTRACK_PPTP=m"
               "CONFIG_NF_CONNTRACK_SANE=m"
               "CONFIG_NF_CONNTRACK_SIP=m"
               "CONFIG_NF_CONNTRACK_TFTP=m"
               "CONFIG_NF_CT_NETLINK=m"
               "CONFIG_NF_CT_NETLINK_TIMEOUT=m"
               "CONFIG_NF_CT_NETLINK_HELPER=m"
               "CONFIG_NETFILTER_NETLINK_GLUE_CT=y"
               "CONFIG_NF_NAT=m"
               "CONFIG_NF_NAT_AMANDA=m"
               "CONFIG_NF_NAT_FTP=m"
               "CONFIG_NF_NAT_IRC=m"
               "CONFIG_NF_NAT_SIP=m"
               "CONFIG_NF_NAT_TFTP=m"
               "CONFIG_NF_NAT_REDIRECT=y"
               "CONFIG_NF_NAT_MASQUERADE=y"
               "CONFIG_NF_NAT_OVS=y"
               "CONFIG_NETFILTER_SYNPROXY=m"
               "CONFIG_NF_TABLES=m"
               "CONFIG_NF_TABLES_INET=y"
               "CONFIG_NF_TABLES_NETDEV=y"
               "CONFIG_NFT_NUMGEN=m"
               "CONFIG_NFT_CT=m"
               "# CONFIG_NFT_EXTHDR_DCCP is not set"
               "# CONFIG_NFT_FLOW_OFFLOAD is not set"
               "CONFIG_NFT_CONNLIMIT=m"
               "CONFIG_NFT_LOG=m"
               "CONFIG_NFT_LIMIT=m"
               "CONFIG_NFT_MASQ=m"
               "CONFIG_NFT_REDIR=m"
               "CONFIG_NFT_NAT=m"
               "CONFIG_NFT_TUNNEL=m"
               "CONFIG_NFT_QUEUE=m"
               "CONFIG_NFT_QUOTA=m"
               "CONFIG_NFT_REJECT=m"
               "CONFIG_NFT_REJECT_INET=m"
               "CONFIG_NFT_COMPAT=m"
               "CONFIG_NFT_HASH=m"
               "CONFIG_NFT_FIB=m"
               "CONFIG_NFT_FIB_INET=m"
               "CONFIG_NFT_XFRM=m"
               "CONFIG_NFT_SOCKET=m"
               "CONFIG_NFT_OSF=m"
               "CONFIG_NFT_TPROXY=m"
               "CONFIG_NFT_SYNPROXY=m"
               "CONFIG_NF_DUP_NETDEV=m"
               "CONFIG_NFT_DUP_NETDEV=m"
               "CONFIG_NFT_FWD_NETDEV=m"
               "CONFIG_NFT_FIB_NETDEV=m"
               "CONFIG_NFT_REJECT_NETDEV=m"
               "CONFIG_NF_FLOW_TABLE_INET=m"
               "CONFIG_NF_FLOW_TABLE=m"
               "CONFIG_NF_FLOW_TABLE_PROCFS=y"
               "CONFIG_NETFILTER_XTABLES=m"
               "CONFIG_NETFILTER_XTABLES_COMPAT=y"
               "CONFIG_NETFILTER_XTABLES_LEGACY=y")))


(define-public linux-arm64-full-nonguix
  (let ((base
         ((@@ (gnu packages linux) make-linux-libre*)
          (@@ (gnu packages linux) linux-libre-version)
          (@@ (gnu packages linux) linux-libre-gnu-revision)
          (@@ (gnu packages linux) linux-libre-source)
          '("aarch64-linux")
          #:configuration-file (@@ (gnu packages linux) kernel-config)
          #:extra-version "arm64-full-nonguix"
          #:extra-options
          (append
           `(("CONFIG_MMC" . "y")
             ("CONFIG_MMC_BLOCK" . "y")
             ("CONFIG_MMC_DW" . "y")
             ("CONFIG_MMC_DW_ROCKCHIP" . "y")
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
           ((@@ (gnu packages linux) default-extra-linux-options) linux-libre-version)))))
    (corrupt-linux base #:name "linux-arm64-full-nonguix")))
