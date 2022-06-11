# Data Engineer

## Задание

Сгененировать и наполнить два источника - БД (postgre) и кафка. 
В бд справочники, в кафке сами данные в виде json.
 
Необходимо построить пайплайн с загрузкой данных раз в 15 минут. Обновление справочников раз в сутки. 
данные надо партицировать по неделям. 

Инструменты - NiFi, запись в hdfs (для теста попробовать в бд), оркестрацию можно сделать в самом nifi, либо oozie либо airflow


## Как запустить

Развернуть docker-compose и перейти на localhost:8443/nifi/ для управления процессами.

Система генерации связки Покупатель-Продукт с последующими записями в хранилища выглядит следующим образом:
![This is an image](/generation.jpg)
![This is an image](/process.jpg)

## Вопросы

### Как будете партицировать данные?

По неделям.
Лидер и ведомые партиции (три реплики в общем, но в данном примере он один) распараллелить на брокеров. Sticky partitioning равномерно заполнит батч для раздела, внутри которого топики наполняются записями в рамках одной недели (каждый новый топик - новая неделя).

### Что будете мониторить и как?

В первую очередь необходимо отслеживать статусы процессов - логировать успешные и отмечать неуспешные (для поиска потенциального бага).
Помимо этого само количество запросов в очереди важный показатель - количество выходящих запросов с прошлого процесса должно перейти в то же количество входящих данных в следующий процесс.

### Что будете логгировать?

Логирование как упорядоченное представление всех событий, произошедших в системе, записывает результаты успешных процесссов. Соответсвтенно, логируются полученные результаты поставленных процессов. В данном случае логируются сообщения, которые далее загружаются в хранилища.

### Что будете делать с оффсетом?

Оффсет в случае успешного чтения позволяет продолжать чтение дальше (вперед и назад во времени), но в случае ошибки при чтении у консьюмера определю Dead letter queue: необходимось определеить функционал, записывающий ошибочное сообщение в отдельный топик для повторной обработки (ручной или автоматической), для того, тобы иметь возможность продолжить последовательно идти по офсетам, но не потерять пропавшие за счет этих брокеров.

### Сериализация данных?

Сериализация позволяет контролировать распределение ресурсов и в данном случае зависит от входного вида и наполненности данных. В данном случае использовать сериалайзер Avro так как он переводит данные в формат json
