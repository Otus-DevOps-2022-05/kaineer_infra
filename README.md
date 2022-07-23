# Infra

![Самостоятельная проверка](https://github.com/Otus-DevOps-2022-05/kaineer_infra/actions/workflows/run-self-tests.yml/badge.svg)


## ansible-3 [12]

 * Проверка pre-commit

## ansible-2 [11]

 * Попробовал способы установки окружения через
   * Один сценарий внутри одного плэйбука
   * Нескольких сценариев внутри одного плэйбука
   * Нескольких плэйбуков для разных хостов
 * Какое-то время почесал репу над готовым рецептом из PR, но потом просто взял команду `yc compute instances list --format json` и накрутил вокруг свой скрипт. Получилось не такое общее, но рабочее что-то.
 * При помощи пакера и провижнеров типа `ansible` создал новые образы для настройки виртуалок. В процессе понял, что работать в docker из-под рута -- можно, но чревато. В итоге создал нового пользвателя и какое-то время копировал в него репозитории и креденшалы.
 * Удалил старые образы, настроил terraform на использование новых образов и создал виртуалки из `terraform/stage`.
 * Запустил `ansible-playbook site.yml`, дождался настройки и проверил, что страничка с приложением открывается.
 * Где-то в середине разобрался с форматом inventory, чтобы имена хостов и группы - всё, как надо.
 * Уложился всего в один коммит для исправления чеков.

## ansible-1 [10]

 * Создал VM в облаке, по команде terraform apply из каталога terraform/stage
 * Установил ansible
 * Настроил разные варианты для inventory (plaintext, yaml)
 * Настроил ansible.cfg
 * Добавил сохранение адресов в файл ansible/servers.yml (см. terraform/stage/inventory.tf, например)
 * Настроил скрипт inventory.sh для генерации json, который можно использовать, как inventory.
 * Выполнил команда ansible all -m ping, и она работает.

## terraform-2 [9]

 * Вынес две конфигурации в подкаталоги prod и stage
 * Вынес содержимое main.tf в модули app, db и vpc
 * Добавил возможность управления провижном в флаг deploy
 * В результате terraform apply в консоль выводится url работающего приложения
 * Чтобы не ругались валидаторы, закомментировал содержимое providers.tf
 * В процессе выяснил, что для того, чтобы terraform init успевал подтягивать плагины, нужно установить переменную TF\_REGISTRY\_CLIENT\_TIMEOUT, иначе клиент не успевает получить список версий плагина

## terraform-1 [8]

 * Установил terraform с [зеркала](https://hc-mirror.express42.net/terraform/) -> 1.1.9
 * Подтянул провайдеров, добавив в main.tf описание
```hcl
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0.35"
    }
  }
  required_version = ">= 0.13"
}
```
 * И сделав terraform init
 * ... после этого (на самом деле, уже после создания PR) этот кусок файла удалил, чтобы не ругался валидатор

 * Настроил файл с переменными для terraform
```
# $PROJECT_ROOT/terraform-1/.envrc

export TF_VAR_token=$(yc config list | grep token | sed 's/token: //')
export TF_VAR_cloud=$(yc config list | grep cloud-id | sed 's/cloud-id: //')
export TF_VAR_folder_id=$(yc config list | grep folder-id | sed 's/folder-id: //')
export TF_VAR_zone=$(yc config list | grep compute-default-zone | sed 's/compute-default-zone: //')
export TF_VAR_subnet_id="e8bgt14n27pnl847kaoo"
```
   * subnet_id взял на страничке подсети

 * Собрал файл ~/.terraformrc со ссылкой на mirror
```
provider_installation {
  network_mirror {
    url = "https://terraform-mirror.yandexcloud.net/"
    include = ["registry.terraform.io/*/*"]
  }
  direct {
    exclude = ["registry.terraform.io/*/*"]
  }
}
```
 * Собрал файл main.tf со ссылкой на yandex provider
```
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud
  folder_id = var.folder_id
  zone      = var.zone
}
```

 * Запустил `terraform init` -> плагин провайдера подтянулся.
 * Выполнил настройку main.tf чтобы создавать VM
   * Сделал создание VM по образу reddit-base
   * Добавил provisioning с пользователем appuser
   * Проверил, что VM создается и доступен
 * Добавил описание балансера из задания со звездой
   * Скопировал готовое и допилил напильником
   * Сделал, чтобы провижнинг соединялся со своим хостом
   * Проверил, чтобы puma запускалась на обоих VM
   * Проверил, что балансер отдаёт результат даже если остановить puma на одном из VM
 * Поковырялся в автопроверке
   * Выяснил, что terraform в автопроверке ставится устаревший (версия 0.12.19)
   * Решил забить на успешную проверку в данном случае

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
