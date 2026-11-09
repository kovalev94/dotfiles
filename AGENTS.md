# AGENTS.md

Инструкции для AI-агентов, работающих с этим репозиторием.

## Что это за репозиторий

Персональные dotfiles:

- конфигурации Guix System и Guix Home;
- собственные модули и пакеты Guix;
- дотфайлы программ (Emacs, Alacritty, qutebrowser и т. д.).

Репозиторий одновременно является Guix-каналом по имени `dotfiles`
(см. `.guix-channel` и `news.txt`).

Основной язык — Guile Scheme. Документация и заметки — в Org-файлах
(`README.org`, `Dream-System.org`).

## Репозиторий — Guix-канал

- Машины потребляют этот репозиторий как канал: он включён в `%my-channels`
  (`guix-config/channels.scm`), а зависимость от nonguix с проверкой подписи
  объявлена в `.guix-channel` и подтягивается автоматически.
- **После каждого коммита и пуша в `main` на целевых машинах нужно выполнять
  `guix pull`** — иначе система и home-окружения будут собираться из старой
  версии модулей.
- Для проверки изменений до публикации укажите в `channels.scm` на тестовой
  машине локальный путь к репозиторию вместо URL на GitHub:

  ```scheme
  (channel
   (name 'dotfiles)
   (url "/home/user/path/to/dotfiles"))  ; локальный клон репозитория
  ```

  Затем выполните `guix pull`. Учтите: `guix pull` видит только
  **закоммиченное** состояние локального репозитория — коммитьте изменения
  локально, пушить на GitHub не нужно. После проверки верните URL на GitHub.
- Ломающие изменения оформляются записью в `news.txt` (формат
  `channel-news`) — пользователи канала увидят её через `guix pull --news`.

## Структура репозитория

- `.guix-channel` — объявление канала.
- `news.txt` — новости канала.
- `guix-config/` — корень иерархии модулей, namespace `(guix-config ...)`.
  - `channels.scm` — определения каналов, закреплённые (pinned) версии,
    substitute-серверы и авторизованные ключи; также здесь
    `%distro-root-directory` — корень репозитория, вычисляемый через
    `%load-path`.
  - `packages.scm`, `keyboard.scm`, `ssh.scm`, `substitutes.scm`,
    `doom-modules-packages.scm` — общие переменные (списки пакетов,
    раскладка, ssh-хосты и т. п.).
  - `packages/` — собственные определения пакетов. Сгруппированы либо
    по назначению (`certs`, `fonts`, `linux`), либо по принадлежности
    к экосистеме (`emacs-xyz`, `golang-xyz`, `python-xyz`).
  - `system/` — всё, что касается конфигурации системы:
    - `operating-systems/` — конфигурации ОС. Базовые, от которых
      наследуются остальные: `base.scm`, `desktop.scm`. Конфигурации
      конкретных машин: `damocles`, `gawain`, `mirage`, `tristan`.
      Отдельно — `guix-installer.scm`: установочный ISO на базе
      nonguix (`installation-os-nonfree`).
    - `aux-files/` — вспомогательные файлы, подключаемые в конфиги
      через `local-file` (dhcpd.conf, правила iptables и т. п.).
    - `images/` — определения образов.
  - `home/` — всё, что касается home-окружений пользователей:
    - `home-environments/` — home-окружения. Базовые, от которых
      наследуются остальные: `base.scm`, `desktop.scm`. Окружения
      конкретных пользователей: `gino`, `lulu`, `schneizel`,
      `vitaliy-kovalev`.
    - `aux-files/` — дотфайлы программ, разбитые на каталоги-слои
      (см. раздел «Дотфайлы»).

## Дотфайлы

Дотфайлы лежат в `guix-config/home/aux-files/` и разбиты на каталоги-слои:
`base`, `desktop`, `gino`, `lulu`, `schneizel`, `vitaliy.kovalev`.
Имена каталогов соответствуют home-окружениям (обратите внимание:
`vitaliy.kovalev` — с точкой, а модуль называется `vitaliy-kovalev`).

- Внутри каждого каталога — обычная структура домашнего каталога:
  `.config/...`, `.ssh/...`, `.local/...` и т. д.
  - `base/` — минимальный общий слой (`.config/mc`, `.ssh`).
  - `desktop/` — десктопные программы: `.config/alacritty`, `.config/doom`
    (конфигурация Doom Emacs), `.config/dunst`, `.config/exwm`,
    `.config/herbstluftwm`, `.config/nyxt`, `.config/qutebrowser`,
    `.config/rofi`, а также `.exwm`, `.xinitrc-herbst`.
  - пользовательские каталоги — персональные переопределения поверх
    `base` + `desktop`.
- Разворачиваются сервисом `home-dotfiles-service-type`. Набор слоёв
  задаётся в Scheme-конфигурации home-окружения через `directories`:
  базовый слой в `base.scm`, `desktop.scm` добавляет `desktop`,
  пользовательские окружения добавляют свой каталог через
  `cons*` + `home-dotfiles-configuration-directories`
  (пример — `home-environments/vitaliy-kovalev.scm`).
- **Настройки программ (включая Emacs) правятся в этих дотфайлах, а не в
  Scheme.** В Scheme меняются только подключаемые слои и списки пакетов.
- Публичные ключи из пользовательских слоёв (например,
  `vitaliy.kovalev/.ssh/keys/*.pub`) подключаются в конфигурации через
  `local-file` + `%distro-root-directory`.

## Команды

```sh
# Обновить каналы (включая этот) до последних коммитов —
# обязательно после пуша в main, перед reconfigure
guix pull

# Проверить конфигурацию ОС без применения (сборка)
guix system build guix-config/system/operating-systems/<host>.scm

# Применить конфигурацию ОС (только по явному запросу пользователя)
sudo guix system reconfigure guix-config/system/operating-systems/<host>.scm

# Проверить home-окружение без применения
guix home build guix-config/home/home-environments/<name>.scm

# Применить home-окружение (только по явному запросу пользователя)
guix home reconfigure guix-config/home/home-environments/<name>.scm

# Собрать пакет из локальных определений
guix build <package-name>

# То же самое напрямую из канала, без файла: -e + экспортируемая переменная
guix system build -e '(@ (guix-config system operating-systems tristan) tristan-system)'
guix home build -e '(@ (guix-config home home-environments gino) gino-home)'
```

## Соглашения по коду

- Каждый `.scm`-файл — модуль `(define-module (guix-config ...) ...)`;
  путь файла соответствует имени модуля:
  `guix-config/system/operating-systems/tristan.scm` →
  `(guix-config system operating-systems tristan)`.
- Экспортируемые значения верхнего уровня — с префиксом `%`
  (`%my-base-system`, `%my-channels`). Исключение — записи конкретных
  машин и home-окружений (`tristan-system`, `gino-home`).
- Конфигурации машин наследуются от базовых через `inherit`
  (`(operating-system (inherit %my-base-system) ...)`); сервисы правятся
  только через `modify-services`, не перечислять `%desktop-services` заново.
- Файл с ОС/образом завершается выражением, возвращающим запись
  (последняя строка — имя переменной), чтобы работал `guix system <file>`.
- Пути к файлам из `aux-files` строятся через `%distro-root-directory`
  из `(guix-config channels)` — не хардкодить абсолютные пути.
- Стиль — идиоматичный Guix: gexp (`#~`, `#$`), `plain-file` / `local-file`,
  `modify-services`. Отступы — 2 пробела, как в существующих файлах;
  комментарии через `;;`.
- Значения по умолчанию в базовой системе: локаль `ru_RU.utf8`,
  таймзона `Asia/Novosibirsk`, LVM-разделы `Guix-Root/Guix-Home/Guix-Swap`.

## Правила безопасности и процесса

- Никаких секретов в репозитории. `*.nmconnection`, `rclone.conf`,
  ключи и сертификаты syncthing, ssh-ключи добавляются на машину вручную —
  не генерировать их и не коммитить. Публичные ключи (`*.pub`) — можно.
- Не выполнять `guix system reconfigure` / `guix home reconfigure` без
  явного запроса пользователя; по умолчанию только `build` или `--dry-run`.
- Pinned-каналы (`%my-pinned-channels` в `channels.scm`) обновлять
  осознанно и отдельным коммитом.
- Правки `base.scm` и `desktop.scm` (system и home), а также слоёв
  `base` и `desktop` в дотфайлах влияют на все машины — предупреждать
  пользователя перед такими изменениями.
- `Dream-System.org` — личная дорожная карта с TODO; при выполнении
  задач из него отмечать пункты как `[X]`.

## Известные нюансы

- Конфигурация Doom Emacs живёт в дотфайлах
  (`home/aux-files/desktop/.config/doom`), сам Doom Emacs устанавливается
  вручную после reconfigure (идёт миграция на vanilla Emacs — см.
  `Dream-System.org`).
- `guix-config/packages/emacs-ewm.scm` — очень большой файл (~127 КБ),
  править точечно, не переписывать целиком.
