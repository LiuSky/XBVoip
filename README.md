## 网络电话

## 证书配置
1.请求CSR文件,在MAC应用程序中找到钥匙串访问，打开它。点击选项栏中的钥匙串访问中的证书助理：
<p align="center">
  <img src="https://raw.githubusercontent.com/LiuSky/XBVoip/master/images/1.png" title="证书助理">
</p>

2.选择从证书颁发机构申请证书:
<p align="center">
  <img src="https://github.com/LiuSky/XBVoip/blob/master/images/2.png?raw=true" title="证书助理">
</p>
填写电子邮件和名称，选择储存到磁盘，然后继续。
这时，我们存储的地方有了这样一个文件：CertificateSigningRequest.certSigningRequest

3.创建Voip证书,到https://developer.apple.com的member Center,选择Certificates选项组的All选项卡:
<p align="center">
  <img src="https://github.com/LiuSky/XBVoip/blob/master/images/3.png?raw=true" title="证书助理">
</p>
<p align="center">
  <img src="https://github.com/LiuSky/XBVoip/blob/master/images/4.png?raw=true" title="证书助理">
</p>

4.创建好了下载cer文件到本地:
<p align="center">
  <img src="https://github.com/LiuSky/XBVoip/blob/master/images/5.png?raw=true" title="证书助理">
</p>

## 证书处理
### 1. php编写的服务端发送Voip通知
<ul>
<li><a href="https://www.cnblogs.com/grimm/p/6047811.html"><code>php命令</code></a></li>
</ul>

### 2.直接用SmartPush推送测试工具
<ul>
<li><a href="https://github.com/shaojiankui/SmartPush"><code>SmartPush</code></a></li>
</ul>


## License
XBVoip is released under an MIT license. See [LICENSE](LICENSE) for more information.
