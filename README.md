# Infra

## packer-base [7]

### Что сделано

 * Установил инструмент direnv
 * Установил инструмент packer
 * Создал сервисный аккаунт `otus-packer`
```
### Переменные берутся из файла .envrc
yc \
  iam \
  service-account \
  create \
  --name $SVC_ACCT \
  --folder-id $FOLDER_ID
```
 * Выдал права сервисному аккаунту
```
yc resource-manager \
  folder \
  add-access-binding \
  --id $FOLDER_ID \
  --role editor \
  --service-account-id $ACCT_ID
```
 * Сохранили service account key
```
### Команды выполнялись *вне* репозитария
###   поэтому ./key.json в репозитарий не попал
yc iam \
   key create \
   --service-account-id $ACCT_ID \
   --output ./key.json
```
 * Создал базовый шаблон [ubuntu16.json](./packer/ubuntu16.json), создал на его основе VM, установил туда reddit, настроил, проверил
 * Обнаружил, что запушил .envrc, удалил ветку на github и локально и добавил все заново
 * Создал шаблон [immutable.json](./packer/immutable.json), создал на его основе VM, проверил, что работает
 * Так и не смог сделать, чтобы вместо аккаунта ubuntu создавался сразу же аккаунт appuser
 * При сдаче понял, что файл с примерами переменных д.б. называться variables.json.example, а не variables.example.json
 * А ещё обнаружил, что packer validate требует наличия файла с ключами. Добавил пустой файл с пустым объектом.

## cloud-testapp [6]

### Данные для доступа к тестовому приложению

```
testapp_IP = 51.250.94.226
testapp_port = 9292
```

### Команда, используемая для создания инстанса

```
./startup.sh
```

В stderr вывалится yaml-документ, в нем будет внешний адрес инстанса.

## cloud-bastion [5]

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
   * `ssh appuser@10.128.0.4`

### Дополнительное задание про сертификат
 * Нашел описание [в чужом PR](https://github.com/Otus-DevOps-2022-05/virtualb0x_infra/pull/9) и использовал. Страничка https://51.250.75.243 открывается без предупреждений (но значок <s>https:</s> всё-равно присутствует).
