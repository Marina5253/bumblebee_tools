# Bumblebee Tools

Небольшое приложение на flutter, есть поддержка android, web. Не помню добавлял ли я разрешения для получения локации на ios, поэтому на нём скорее всего не будет работать погода.

Функции:
1) Автоматическое определение местоположения
Описание: Эта функция позволяет приложению автоматически определять текущее местоположение пользователя, используя GPS, Wi-Fi или данные мобильного оператора.
Использование: Это может быть необходимо для предоставления персонализированных услуг, таких как местная погода, рекомендации местных заведений или маршрутизация.
Технические аспекты: Приложение должно запрашивать разрешение на доступ к местоположению у пользователя и обрабатывать эти данные в соответствии с законодательством о конфиденциальности.
2) Показ погоды и изменение картинки погоды в зависимости от кода, который получен из API
Описание: Функция отображает текущую погоду в месте нахождения пользователя и может менять фоновую картинку на основе кода погоды, полученного из внешнего API погоды.
Использование: Это помогает пользователям быстро оценить текущую погоду и её изменения, что важно для планирования деятельности на день.
Технические аспекты: Приложение должно быть интегрировано с API погоды (например, OpenWeatherMap или Weatherstack), обрабатывать полученные данные и корректно отображать их.
3) Создание записок, возможность их удаления, отмечения выполнеными, редактирования
Описание: Эта функция позволяет пользователям создавать личные заметки, управлять ими (удалять, отмечать как выполненные, редактировать), а также добавлять или изменять текст в заметках.
Использование: Это полезно для организации ежедневных задач, планов или просто для хранения важных мыслей и идей.
Технические аспекты: Приложение должно обеспечивать удобный интерфейс для создания и управления заметками, а также должно быть защищено от потери данных.

<img src="https://github.com/Kawler/ReadMd/blob/main/Screenshot_20240304_144713.png"/>
<img src="https://github.com/Kawler/ReadMd/blob/main/Screenshot_20240304_144734.png"/>

