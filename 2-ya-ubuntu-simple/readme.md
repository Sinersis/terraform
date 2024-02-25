Скрип запуска виртуальных машин в Yandex Cloud, с подключением ssh ключа.
Реализовано через count loop

Обязательно заполнить файл `personal.auto.tfvars`, пример файла называется
`personal.auto.tfvars.example`

Параметры для заполнения:
- `token` - OAuth токен
- `cloud_id` - Ид Облака
- `folder_id` - Иди папки
- `subnet_id` - Ид подсети
- `ssh_key_path` - путь до локального ssh ключа (можно оставить пустым если у вас дефолтный путь такого вида `~/.ssh/id_rsa.pub`)

