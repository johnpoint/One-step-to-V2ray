# One-step-to-V2ray #

一个一键安装/配置V2ray的脚本

## 获取&使用 ##

脚本分为两个版本，基础版与高级版，对使用人群没有特殊要求，只是高级版的配置更为繁琐但更加个性化，基础版配置简单。

### 基础版 ###

```
wget https://github.com/johnpoint/One-step-to-V2ray/raw/master/v2ray-base.sh && chmod +x v2ray-base.sh && ./v2ray-base.sh
```

### 高级版 ###

```
wget https://github.com/johnpoint/One-step-to-V2ray/raw/master/v2ray-dev.sh && chmod +x v2ray-dev.sh && ./v2ray-dev.sh
```

## 功能 ##

*目前已经实现的*

| 功能 | 基础版 | 高级版 |
| ---------- | --- | --- |
| Vmess | √ | √ |
| Socks | √ | √ |
| Shadowsocks | × | × |
| Mux.Cool | √ | √ |
| mKcp | × | × |
| http伪装 | × | × |
| Blackhole | × | × |
| Dokodemo-door | × | × |
| Websocket | × | × |
| 本地策略 | × | × |

## TODO #

- [x] 完善Vmess
- [x] 完善socks安装
- [x] 增加shawdsocks加密协议
- [ ] 完善shawdsocks安装
- [ ] 完善高级版脚本
- [ ] 增加http伪装
- [ ] 增加自定义客户端路由
- [ ] 增加Dokodemo-door配置
- [ ] 添加mKcp
- [ ] 实现本地配置设定

## License ##

[GPL v3](https://github.com/johnpoint/One-step-to-V2ray/blob/master/LICENSE)
