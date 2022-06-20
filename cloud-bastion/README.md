### Процесс выполнения

 * Создал пару ключей при помощи `ssh-keygen`
 * Создал инстансы в Yandex.cloud
   * bastion -- 51.250.75.243 (внешний IP)
   * someinternalhost -- 10.128.0.4 (внутренний IP)
 * Попробовал доступ по ssh
   * К bastion: `ssh -i ~/.ssh/appuser appuser@<bastion_IP>`
   * К someinternalhost:
```
$ ssh-add ~/.ssh/appuser
$ ssh -i ~/.ssh/appuser -A appuser@<bastion_IP>
bastion $ ssh <someinternalhost_IP>
```
   * Через `~/.ssh/config`
```
Host bastion
  HostName 51.250.73.188   ### Put bastion_IP here
  User appuser
  IdentityFile ~/.ssh/appuser

Host someinternalhost
  HostName 10.128.0.4      ### Put someinternalhost_IP here
  User appuser
  IdentityFile ~/.ssh/appuser
  ProxyJump bastion
```

   * После этого входим на bastion через `ssh bastion`
   * ... и на someinternalhost через `ssh someinternalhost`

 * Добавил VPN
   * Модифицировал [скрипт настойки vpn на bastion](https://gist.github.com/kaineer/f1dc96fbf1eaf9627efc176613d92c5a)
   * Скачал его на bastion при помощи wget и запустил командой `sudo bash setupvpn.sh`
   * Настроил vpn, пользуясь методичкой и [обучалкой](https://docs.pritunl.com/docs/accessing-a-private-network)
   * Запустил сервер, скачал профиль себе на машину
   * Втянул профиль в клиент pritunl и соединился
   * Выполнил `ssh -i ~/.ssh/appuser appuser@<someinternalhost_IP>`, попал на someinternal host.
   * Доп задание про сертификаты пока отложил в дальний ящик.
