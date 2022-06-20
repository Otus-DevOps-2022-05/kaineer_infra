# Infra

## cloud-bastion

### Адреса инстансов в yandex.cloud

```
bastion_IP = 51.250.75.243
someinternalhost_IP = 10.128.0.4
```

(bastion_IP сменится не позже чем 21.06.2022, в 09:30 MSK, просьба до этого времени проверить или маякнуть мне, я перезапущу инстансы и поменяю внешний IP бастиона здесь)

### Подключение к удалённым хостам
 * Доступ по ssh
   * к bastion: `ssh -i ~/.ssh/appuser appuser@<bastion_IP>`
   * к someinternalhost:
```
$ ssh-add ~/.ssh/appuser
$ ssh -i ~/.ssh/appuser -A appuser@<bastion_IP>
bastion $ ssh <someinternalhost_IP>
```
   * После модификации `~/.ssh/config`
```
Host bastion
  HostName 51.250.75.243
  User appuser
  IdentityFile ~/.ssh/appuser

Host someinternalhost
  HostName 10.128.0.4
  User appuser
  IdentityFile ~/.ssh/appuser
  ProxyJump bastion
```
   * После этого входим на bastion через `ssh bastion`
   * ... и на someinternalhost через `ssh someinternalhost`
 * После втягивания `cloud-bastion.ovpn`
   * `ssh -i ~/.ssh/appuser appuser@10.128.0.4`

### Дополнительное задание про сертификат
 * Пока не добрался
