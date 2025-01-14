#!/bin/bash
#Author [ RC-Rick ]
#OS [ AstraLinux Smolenks 1.8.1.6 ]
#Ver. [ 0.1 ]

status() {
    if [ $1 -eq 0 ];then
        echo "[ Успешно ]"
    else
        echo "[ Ошибка ]"
    fi
}

echo "Запускаю загрузку NVidia-all"
if [ ! -f ~/Загрузки/ALSE17-NVidia-all-240531-1.7.5.uu1.tar.gz ];then
    wget -qO ~/Загрузки/ALSE17-NVidia-all-240531-1.7.5.uu1.tar.gz https://disk.astralinux.ru/s/k5p8jxi6dPdqAf7/download/ALSE17-NVidia-all-240531-1.7.5.uu1.tar.gz
    status $?
fi

echo "Распаковываю архив ALSE17 в директорию /srv"
if [ ! -f /srv/ALSE17-NVidia-all-240531-1.7.5.uu1 ];then
    sudo tar xf ALSE17-NVidia-all-240531-1.7.5.uu1.tar.gz -C /srv
    status $?
fi

echo "Добавляю локальный репозиторий ALSE17"
if [ $(grep ALSE17-NVidia-all-240531-1.7.5.uu1 /etc/apt/sources.list) ];then
    echo ""
else
    sudo echo "deb file:/srv/ALSE17-NVidia-all-240531-1.7.5.uu1 1.7_x86-64 non-free" >> /etc/apt/sources.list
    status $?
fi

echo "Обновляю список репозиториев"
sudo apt update
status $?

echo "Устанавливаю пакет [ nvidia-detect-525 ]"
sudo apt install -y nvidia-detect-525
status $?

echo "Запускаю [ nvidia-detect ]"
nvidia-detect
status $?

echo "Устанавливаю пакет [ nvidia-driver-550 ]"
sudo apt install -y nvidia-driver-550
status $?

echo "Скрипт завершил свою работу. Через 1 минуту будет перезагружен компьютер."
sleep 60
sudo /sbin/init 6

