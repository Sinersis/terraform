### Задача:
* Развернуть несколько серверов
* Написать необходимые ansible playbooks для установки стеков
  * PHP 8.0 + NGINX + NVM + NODE + GitlabRunner (по необходимости)
  * PHP 8.1 + NGINX + NVM + NODE + GitlabRunner (по необходимости)
  * PHP 8.2 + NGINX + NVM + NODE + GitlabRunner (по необходимости)
  * Docker
* Установка ПО:
  * Duplicati (file backup)
  * Git
  * Composer
  * NVM
  * Gitlab Runner
  * PHP (8.0, 8.1, 8.2) - {components}

Как должно работать:

1. Запускаем терраформ манифест, для развертывания железа
2. Автоматически запускается ансибл плейбук для установки ПО
3. Автоматически запускаеть плейбук для развертывания проектов (дев/мастер веток)
4. Автоматическая настройка GitLab Runner (авто деплой) (подумать про ssh shared runner)