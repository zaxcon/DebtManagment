#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Функция определяет значения реквизитов выбранного контрагента.
//
// Параметры:
//  Контрагент - СправочникСсылка.Контрагенты - Ссылка на контрагента.
//
// Возвращаемое значение:
//	Структура - реквизиты выбранного контрагента.
//
Функция ПолучитьРеквизитыКонтрагента(Контрагент) Экспорт
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	Контрагенты.Наименование КАК Наименование,
	|	ВЫРАЗИТЬ(Контрагенты.НаименованиеПолное КАК Строка(1000)) КАК НаименованиеПолное,
	|	Контрагенты.ИНН КАК ИНН,
	|	Контрагенты.КПП КАК КПП,
	|	Контрагенты.КодПоОКПО КАК КодПоОКПО
	|ИЗ
	|	Справочник.Контрагенты КАК Контрагенты
	|ГДЕ
	|	Контрагенты.Ссылка = &Контрагент
	|");
	Запрос.УстановитьПараметр("Контрагент", Контрагент);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		Представление = Выборка.Наименование;
		Наименование = ?(Не ПустаяСтрока(Выборка.НаименованиеПолное), Выборка.НаименованиеПолное, Выборка.Наименование);
		ИНН = Выборка.ИНН;
		КПП = Выборка.КПП;
		КодПоОКПО = Выборка.КодПоОКПО;
	Иначе
		Представление = "";
		Наименование = "";
		ИНН = "";
		КПП = "";
		КодПоОКПО = "";
	КонецЕсли;
	
	СтруктураРеквизитов = Новый Структура;
	СтруктураРеквизитов.Вставить("Представление",Представление);
	СтруктураРеквизитов.Вставить("Наименование",Наименование);
	СтруктураРеквизитов.Вставить("ИНН",ИНН);
	СтруктураРеквизитов.Вставить("КПП",КПП);
	СтруктураРеквизитов.Вставить("КодПоОКПО",КодПоОКПО);
	
	Возврат СтруктураРеквизитов;

КонецФункции

// Функция определяет наименование контрагента.
//
// Параметры:
//  Контрагент - СправочникСсылка.Контрагенты - Ссылка на контрагента.
//
// Возвращаемое значение:
//	Строка - Наименование контрагента.
//
Функция ПолучитьНаименованиеКонтрагента(Контрагент) Экспорт
	
	Наименование = "";
	
	Запрос = Новый Запрос(
		"ВЫБРАТЬ
		|	Контрагенты.Наименование КАК Наименование,
		|	Контрагенты.НаименованиеПолное КАК НаименованиеПолное
		|ИЗ
		|	Справочник.Контрагенты КАК Контрагенты
		|ГДЕ
		|	Контрагенты.Ссылка = &Контрагент
		|");
	
	Запрос.УстановитьПараметр("Контрагент", Контрагент);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		Наименование = ?(ЗначениеЗаполнено(Выборка.НаименованиеПолное), Выборка.НаименованиеПолное, Выборка.Наименование);
	КонецЕсли;
	
	Возврат Наименование;

КонецФункции

// Вызывается при переходе на версию РТ 2.2.
//
Процедура ОбновитьПредопределенныеВидыКонтактнойИнформацииОрганизаций() Экспорт
	
	Если Не ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.КонтактнаяИнформация") Тогда
		Возврат;
	КонецЕсли;
	
	МодульУправлениеКонтактнойИнформацией = ОбщегоНазначения.ОбщийМодуль("УправлениеКонтактнойИнформацией");
	
	ПараметрыВида = МодульУправлениеКонтактнойИнформацией.ПараметрыВидаКонтактнойИнформации("Адрес");
	ПараметрыВида.Вид = "ЮрАдресКонтрагента";
	ПараметрыВида.МожноИзменятьСпособРедактирования = Истина;
	ПараметрыВида.Порядок = 1;
	ПараметрыВида.НастройкиПроверки.ТолькоНациональныйАдрес = Истина;
	МодульУправлениеКонтактнойИнформацией.УстановитьСвойстваВидаКонтактнойИнформации(ПараметрыВида);
	
	ПараметрыВида = МодульУправлениеКонтактнойИнформацией.ПараметрыВидаКонтактнойИнформации("Адрес");
	ПараметрыВида.Вид = "ФактАдресКонтрагента";
	ПараметрыВида.МожноИзменятьСпособРедактирования = Истина;
	ПараметрыВида.Порядок = 2;
	МодульУправлениеКонтактнойИнформацией.УстановитьСвойстваВидаКонтактнойИнформации(ПараметрыВида);
	
	ПараметрыВида = МодульУправлениеКонтактнойИнформацией.ПараметрыВидаКонтактнойИнформации("Адрес");
	ПараметрыВида.Вид = "ПочтовыйАдресКонтрагента";
	ПараметрыВида.МожноИзменятьСпособРедактирования = Истина;
	ПараметрыВида.Порядок = 3;
	МодульУправлениеКонтактнойИнформацией.УстановитьСвойстваВидаКонтактнойИнформации(ПараметрыВида);
	
	ПараметрыВида = МодульУправлениеКонтактнойИнформацией.ПараметрыВидаКонтактнойИнформации("Телефон");
	ПараметрыВида.Вид = "ТелефонКонтрагента";
	ПараметрыВида.МожноИзменятьСпособРедактирования = Истина;
	ПараметрыВида.РазрешитьВводНесколькихЗначений = Истина;
	ПараметрыВида.Порядок = 4;
	МодульУправлениеКонтактнойИнформацией.УстановитьСвойстваВидаКонтактнойИнформации(ПараметрыВида);
	
	ПараметрыВида = МодульУправлениеКонтактнойИнформацией.ПараметрыВидаКонтактнойИнформации("Факс");
	ПараметрыВида.Вид = "ФаксКонтрагента";
	ПараметрыВида.МожноИзменятьСпособРедактирования = Истина;
	ПараметрыВида.РазрешитьВводНесколькихЗначений = Истина;
	ПараметрыВида.Порядок = 5;
	МодульУправлениеКонтактнойИнформацией.УстановитьСвойстваВидаКонтактнойИнформации(ПараметрыВида);
	
	ПараметрыВида = МодульУправлениеКонтактнойИнформацией.ПараметрыВидаКонтактнойИнформации("АдресЭлектроннойПочты");
	ПараметрыВида.Вид = "EmailКонтрагента";
	ПараметрыВида.МожноИзменятьСпособРедактирования = Истина;
	ПараметрыВида.РазрешитьВводНесколькихЗначений = Истина;
	ПараметрыВида.Порядок = 5;
	МодульУправлениеКонтактнойИнформацией.УстановитьСвойстваВидаКонтактнойИнформации(ПараметрыВида);
	
	ПараметрыВида = МодульУправлениеКонтактнойИнформацией.ПараметрыВидаКонтактнойИнформации("Другое");
	ПараметрыВида.Вид = "ДругаяИнформацияКонтрагента";
	ПараметрыВида.МожноИзменятьСпособРедактирования = Истина;
	ПараметрыВида.Порядок = 7;
	МодульУправлениеКонтактнойИнформацией.УстановитьСвойстваВидаКонтактнойИнформации(ПараметрыВида);
	
КонецПроцедуры

// Определяет настройки объекта для подсистемы ВерсионированиеОбъектов.
//
// Параметры:
//  Настройки - Структура - настройки подсистемы.
Процедура ПриОпределенииНастроекВерсионированияОбъектов(Настройки) Экспорт
	
КонецПроцедуры

Процедура ОбновитьИНННеРезидента() Экспорт
	
	ИНННеРезидента = "000000000000";
	ЮрФизЛицоНеРезидент = Перечисления.ЮрФизЛицо.ЮрЛицоНеРезидент;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	Контрагенты.ЮрФизЛицо КАК ЮрФизЛицо,
	|	Контрагенты.Ссылка КАК Ссылка,
	|	Контрагенты.ИНН КАК ИНН
	|ИЗ
	|	Справочник.Контрагенты КАК Контрагенты
	|ГДЕ
	|	Контрагенты.ИНН <> &ИНННеРезидента
	|	И Контрагенты.ЭтоГруппа = ЛОЖЬ
	|	И Контрагенты.ЮрФизЛицо = &ЮрФизЛицоНеРезидент";
	
	Запрос.УстановитьПараметр("ИНННеРезидента", ИНННеРезидента);
	Запрос.УстановитьПараметр("ЮрФизЛицоНеРезидент", ЮрФизЛицоНеРезидент);
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		КонтрагентОбъект = Выборка.Ссылка.ПолучитьОБъект();
		КонтрагентОбъект.ИНН = ИНННеРезидента;
		ОбновлениеИнформационнойБазы.ЗаписатьДанные(КонтрагентОбъект);
		
	КонецЦикла;
	
КонецПроцедуры

// СтандартныеПодсистемы.ШаблоныСообщений

// Вызывается при подготовке шаблонов сообщений и позволяет переопределить список реквизитов и вложений.
//
// Параметры:
//  Реквизиты               - ДеревоЗначений - список реквизитов шаблона.
//         ** Имя            - Строка - Уникальное имя общего реквизита.
//         ** Представление  - Строка - Представление общего реквизита.
//         ** Тип            - Тип    - Тип реквизита. По умолчанию строка.
//         ** Формат         - Строка - Формат вывода значения для чисел, дат, строк и булевых значений.
//  Вложения                - ТаблицаЗначений - печатные формы и вложения
//         ** Имя            - Строка - Уникальное имя вложения.
//         ** Представление  - Строка - Представление варианта.
//         ** ТипФайла       - Строка - Тип вложения, который соответствует расширению файла: "pdf", "png", "jpg", mxl" и др.
//  ДополнительныеПараметры - Структура - дополнительные сведения о шаблоне сообщений.
//
Процедура ПриПодготовкеШаблонаСообщения(Реквизиты, Вложения, ДополнительныеПараметры) Экспорт
	
КонецПроцедуры

// Вызывается в момент создания сообщений по шаблону для заполнения значений реквизитов и вложений.
//
// Параметры:
//  Сообщение - Структура - структура с ключами:
//    * ЗначенияРеквизитов - Соответствие - список используемых в шаблоне реквизитов.
//      ** Ключ     - Строка - имя реквизита в шаблоне;
//      ** Значение - Строка - значение заполнения в шаблоне.
//    * ЗначенияОбщихРеквизитов - Соответствие - список используемых в шаблоне общих реквизитов.
//      ** Ключ     - Строка - имя реквизита в шаблоне;
//      ** Значение - Строка - значение заполнения в шаблоне.
//    * Вложения - Соответствие - значения реквизитов 
//      ** Ключ     - Строка - имя вложения в шаблоне;
//      ** Значение - ДвоичныеДанные, Строка - двоичные данные или адрес во временном хранилище вложения.
//  ПредметСообщения - ЛюбаяСсылка - ссылка на объект являющийся источником данных.
//  ДополнительныеПараметры - Структура -  Дополнительная информация о шаблоне сообщения.
//
Процедура ПриФормированииСообщения(Сообщение, ПредметСообщения, ДополнительныеПараметры) Экспорт
	
КонецПроцедуры

// Заполняет список получателей SMS при отправке сообщения сформированного по шаблону.
//
// Параметры:
//   ПолучателиSMS - ТаблицаЗначений - список получается SMS.
//     * НомерТелефона - Строка - номер телефона, куда будет отправлено сообщение SMS.
//     * Представление - Строка - представление получателя сообщения SMS.
//     * Контакт       - СправочникСсылка - контакт, которому принадлежит номер телефона.
//  ПредметСообщения - ЛюбаяСсылка - ссылка на объект являющийся источником данных.
//
Процедура ПриЗаполненииТелефоновПолучателейВСообщении(ПолучателиSMS, ПредметСообщения) Экспорт
	
КонецПроцедуры

// Заполняет список получателей письма при отправки сообщения сформированного по шаблону.
//
// Параметры:
//   ПолучателиПисьма - ТаблицаЗначений - список получается письма.
//     * Адрес           - Строка - адрес электронной почты получателя.
//     * Представление   - Строка - представление получается письма.
//     * ВариантОтправки - Строка - Варианты отправки письма: "Кому", "Копия", "СкрытаяКопия", "ОбратныйАдреса";
//  ПредметСообщения - ЛюбаяСсылка - ссылка на объект являющийся источником данных.
//
Процедура ПриЗаполненииПочтыПолучателейВСообщении(ПолучателиПисьма, ПредметСообщения) Экспорт
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.ШаблоныСообщений

#Область ОбновлениеИнформационнойБазы

// Регистрирует контрагентов для заполнения СНО
//
// Параметры:
//  Параметры - Структура - структура параметров выполнения операции.
//
Процедура ЗарегистрироватьКонтрагентовДляЗаполнениюСНО(Параметры) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	Контрагенты.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.Контрагенты КАК Контрагенты
		|ГДЕ
		|	Контрагенты.УдалитьСистемаНалогообложения <> ЗНАЧЕНИЕ(Перечисление.УдалитьСистемыНалогообложения.ПустаяСсылка)
		|	И Контрагенты.Удалить_СистемаНалогообложения = ЗНАЧЕНИЕ(Перечисление.ТипыСистемНалогообложенияККТ.ПустаяСсылка)";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	МассивКонтрагентов = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	
	ОбновлениеИнформационнойБазы.ОтметитьКОбработке(Параметры, МассивКонтрагентов);
	
КонецПроцедуры

// Заполняет систему налогообложения контрагента.
//
// Параметры:
//  Параметры - Структура - структура параметров выполнения операции.
//
Процедура ЗаполнитьСистемуНалогообложенияКонтрагентов(Параметры) Экспорт
	
	МетаданныеКонтрагент = Метаданные.Справочники.Контрагенты;
	ПолноеИмяОбъекта = МетаданныеКонтрагент.ПолноеИмя();
	
	Выборка = ОбновлениеИнформационнойБазы.ВыбратьСсылкиДляОбработки(Параметры.Очередь, ПолноеИмяОбъекта);
	
	ШаблонТекстаОшибки = НСтр("ru = 'Не удалось установить систему налогообложения контрагенту %1 по причине:
									|%2'");
	
	Пока Выборка.Следующий() Цикл
		
		НачатьТранзакцию();
		
		Попытка
			
			Блокировка = Новый БлокировкаДанных;
			ЭлементБлокировки = Блокировка.Добавить(ПолноеИмяОбъекта);
			ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
			ЭлементБлокировки.УстановитьЗначение("Ссылка", Выборка.Ссылка);
			Блокировка.Заблокировать();
			
			КонтрагентОбъект = Выборка.Ссылка.ПолучитьОбъект();
			
			Если КонтрагентОбъект = Неопределено Тогда
				ОтменитьТранзакцию();
				Продолжить;
			КонецЕсли;
			
			Если КонтрагентОбъект.УдалитьСистемаНалогообложения = Перечисления.УдалитьСистемыНалогообложения.Общая Тогда
				КонтрагентОбъект.Удалить_СистемаНалогообложения = Перечисления.ТипыСистемНалогообложенияККТ.ОСН;
			ИначеЕсли КонтрагентОбъект.УдалитьСистемаНалогообложения = Перечисления.УдалитьСистемыНалогообложения.Упрощенная Тогда
				КонтрагентОбъект.Удалить_СистемаНалогообложения = Перечисления.ТипыСистемНалогообложенияККТ.УСНДоход;
			КонецЕсли;
			
			ОбновлениеИнформационнойБазы.ЗаписатьОбъект(КонтрагентОбъект);
			ЗафиксироватьТранзакцию();
			
		Исключение
			
			ОтменитьТранзакцию();
			
			ТекстОшибки = СтрШаблон(ШаблонТекстаОшибки, Выборка.Ссылка, ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			
			ЗаписьЖурналаРегистрации(НСтр("ru = 'Обновление информационной базы'",
				ОбщегоНазначения.КодОсновногоЯзыка()),
				УровеньЖурналаРегистрации.Ошибка,,,
				ТекстОшибки);
			
		КонецПопытки;
			
	КонецЦикла;
	
	Параметры.ОбработкаЗавершена = НЕ ОбновлениеИнформационнойБазы.ЕстьДанныеДляОбработки(Параметры.Очередь, ПолноеИмяОбъекта);
	
КонецПроцедуры

Процедура ЗарегистрироватьКонтрагентовПокупательПоставщик(Параметры) Экспорт
	
	Если ПланыОбмена.ГлавныйУзел() <> Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ЗаказПоставщику.Контрагент КАК Контрагент
		|ПОМЕСТИТЬ ВТ_ПокупателиПоставщики
		|ИЗ
		|	Документ.ЗаказПоставщику КАК ЗаказПоставщику
		|ГДЕ
		|	ЗаказПоставщику.Проведен
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ВозвратТоваровПоставщику.Контрагент
		|ИЗ
		|	Документ.ВозвратТоваровПоставщику КАК ВозвратТоваровПоставщику
		|ГДЕ
		|	ВозвратТоваровПоставщику.Проведен
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ПоступлениеТоваров.Контрагент
		|ИЗ
		|	Документ.ПоступлениеТоваров КАК ПоступлениеТоваров
		|ГДЕ
		|	ПоступлениеТоваров.Проведен
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ЗаказПокупателя.Контрагент
		|ИЗ
		|	Документ.ЗаказПокупателя КАК ЗаказПокупателя
		|ГДЕ
		|	ЗаказПокупателя.Проведен
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ВозвратТоваровОтПокупателя.Контрагент
		|ИЗ
		|	Документ.ВозвратТоваровОтПокупателя КАК ВозвратТоваровОтПокупателя
		|ГДЕ
		|	ВозвратТоваровОтПокупателя.Проведен
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ЧекККМ.Контрагент
		|ИЗ
		|	Документ.ЧекККМ КАК ЧекККМ
		|ГДЕ
		|	ЧекККМ.Проведен
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	РеализацияТоваров.Контрагент
		|ИЗ
		|	Документ.РеализацияТоваров КАК РеализацияТоваров
		|ГДЕ
		|	РеализацияТоваров.Проведен
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ПриходныйКассовыйОрдер.Контрагент
		|ИЗ
		|	Документ.ПриходныйКассовыйОрдер КАК ПриходныйКассовыйОрдер
		|ГДЕ
		|	ПриходныйКассовыйОрдер.Проведен
		|	И ПриходныйКассовыйОрдер.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПоступлениеОплатыОтКлиента)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ПриходныйКассовыйОрдер.Контрагент
		|ИЗ
		|	Документ.ПриходныйКассовыйОрдер КАК ПриходныйКассовыйОрдер
		|ГДЕ
		|	ПриходныйКассовыйОрдер.Проведен
		|	И ПриходныйКассовыйОрдер.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ВозвратДенежныхСредствОтПоставщика)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ПриходныйКассовыйОрдер.Контрагент
		|ИЗ
		|	Документ.ПриходныйКассовыйОрдер КАК ПриходныйКассовыйОрдер
		|ГДЕ
		|	ПриходныйКассовыйОрдер.Проведен
		|	И ПриходныйКассовыйОрдер.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ВознаграждениеОтКомитента)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	РасходныйКассовыйОрдер.Контрагент
		|ИЗ
		|	Документ.РасходныйКассовыйОрдер КАК РасходныйКассовыйОрдер
		|ГДЕ
		|	РасходныйКассовыйОрдер.Проведен
		|	И РасходныйКассовыйОрдер.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ОплатаПоставщику)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	РасходныйКассовыйОрдер.Контрагент
		|ИЗ
		|	Документ.РасходныйКассовыйОрдер КАК РасходныйКассовыйОрдер
		|ГДЕ
		|	РасходныйКассовыйОрдер.Проведен
		|	И РасходныйКассовыйОрдер.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ВозвратОплатыКлиенту)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ОплатаОтПокупателяПлатежнойКартой.Контрагент
		|ИЗ
		|	Документ.ОплатаОтПокупателяПлатежнойКартой КАК ОплатаОтПокупателяПлатежнойКартой
		|ГДЕ
		|	ОплатаОтПокупателяПлатежнойКартой.Проведен
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	РегистрацияБезналичнойОплаты.Контрагент
		|ИЗ
		|	Документ.РегистрацияБезналичнойОплаты КАК РегистрацияБезналичнойОплаты
		|ГДЕ
		|	РегистрацияБезналичнойОплаты.Проведен
		|	И РегистрацияБезналичнойОплаты.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ОплатаПоставщику)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	РегистрацияБезналичнойОплаты.Контрагент
		|ИЗ
		|	Документ.РегистрацияБезналичнойОплаты КАК РегистрацияБезналичнойОплаты
		|ГДЕ
		|	РегистрацияБезналичнойОплаты.Проведен
		|	И РегистрацияБезналичнойОплаты.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ВозвратДенежныхСредствОтПоставщика)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	РегистрацияБезналичнойОплаты.Контрагент
		|ИЗ
		|	Документ.РегистрацияБезналичнойОплаты КАК РегистрацияБезналичнойОплаты
		|ГДЕ
		|	РегистрацияБезналичнойОплаты.Проведен
		|	И РегистрацияБезналичнойОплаты.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПоступлениеОплатыОтКлиента)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	РегистрацияБезналичнойОплаты.Контрагент
		|ИЗ
		|	Документ.РегистрацияБезналичнойОплаты КАК РегистрацияБезналичнойОплаты
		|ГДЕ
		|	РегистрацияБезналичнойОплаты.Проведен
		|	И РегистрацияБезналичнойОплаты.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ВозвратОплатыКлиенту)
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Контрагент
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТ_ПокупателиПоставщики.Контрагент КАК Контрагент
		|ПОМЕСТИТЬ ВТ_ПокупателиПоставщикиСгруппированные
		|ИЗ
		|	ВТ_ПокупателиПоставщики КАК ВТ_ПокупателиПоставщики
		|
		|СГРУППИРОВАТЬ ПО
		|	ВТ_ПокупателиПоставщики.Контрагент
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|УНИЧТОЖИТЬ ВТ_ПокупателиПоставщики
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТ_ПокупателиПоставщикиСгруппированные.Контрагент КАК Контрагент
		|ИЗ
		|	ВТ_ПокупателиПоставщикиСгруппированные КАК ВТ_ПокупателиПоставщикиСгруппированные
		|ГДЕ
		|	НЕ ВТ_ПокупателиПоставщикиСгруппированные.Контрагент.Покупатель
		|	И НЕ ВТ_ПокупателиПоставщикиСгруппированные.Контрагент.Поставщик
		|
		|ОБЪЕДИНИТЬ
		|
		|ВЫБРАТЬ
		|	КонтрагентРозничныйПокупатель.Значение
		|ИЗ
		|	Константа.КонтрагентРозничныйПокупатель КАК КонтрагентРозничныйПокупатель
		|ГДЕ
		|	НЕ КонтрагентРозничныйПокупатель.Значение.Покупатель";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	МассивКонтрагентов = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Контрагент");
	
	ОбновлениеИнформационнойБазы.ОтметитьКОбработке(Параметры, МассивКонтрагентов);
	
КонецПроцедуры

Процедура УстановитьПризнакПокупательПоставщик(Параметры) Экспорт
	
	МетаданныеКонтрагент = Метаданные.Справочники.Контрагенты;
	ПолноеИмяОбъекта = МетаданныеКонтрагент.ПолноеИмя();
	
	Выборка = ОбновлениеИнформационнойБазы.ВыбратьСсылкиДляОбработки(Параметры.Очередь, ПолноеИмяОбъекта);
	
	СписокКонтрагентовДляОбработки = Новый СписокЗначений;
	
	Пока Выборка.Следующий() Цикл
		СписокКонтрагентовДляОбработки.Добавить(Выборка.Ссылка);
	КонецЦикла;
		
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ЗаказПоставщику.Контрагент КАК Контрагент,
		|	ИСТИНА КАК Поставщик,
		|	ЛОЖЬ КАК Покупатель
		|ПОМЕСТИТЬ ВТ_ПокупателиПоставщики
		|ИЗ
		|	Документ.ЗаказПоставщику КАК ЗаказПоставщику
		|ГДЕ
		|	ЗаказПоставщику.Проведен
		|	И ЗаказПоставщику.Контрагент В(&СписокКонтрагентов)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ВозвратТоваровПоставщику.Контрагент,
		|	ИСТИНА,
		|	ЛОЖЬ
		|ИЗ
		|	Документ.ВозвратТоваровПоставщику КАК ВозвратТоваровПоставщику
		|ГДЕ
		|	ВозвратТоваровПоставщику.Проведен
		|	И ВозвратТоваровПоставщику.Контрагент В(&СписокКонтрагентов)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ПоступлениеТоваров.Контрагент,
		|	ИСТИНА,
		|	ЛОЖЬ
		|ИЗ
		|	Документ.ПоступлениеТоваров КАК ПоступлениеТоваров
		|ГДЕ
		|	ПоступлениеТоваров.Проведен
		|	И ПоступлениеТоваров.Контрагент В(&СписокКонтрагентов)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ЗаказПокупателя.Контрагент,
		|	ЛОЖЬ,
		|	ИСТИНА
		|ИЗ
		|	Документ.ЗаказПокупателя КАК ЗаказПокупателя
		|ГДЕ
		|	ЗаказПокупателя.Проведен
		|	И ЗаказПокупателя.Контрагент В(&СписокКонтрагентов)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ВозвратТоваровОтПокупателя.Контрагент,
		|	ЛОЖЬ,
		|	ИСТИНА
		|ИЗ
		|	Документ.ВозвратТоваровОтПокупателя КАК ВозвратТоваровОтПокупателя
		|ГДЕ
		|	ВозвратТоваровОтПокупателя.Проведен
		|	И ВозвратТоваровОтПокупателя.Контрагент В(&СписокКонтрагентов)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ЧекККМ.Контрагент,
		|	ЛОЖЬ,
		|	ИСТИНА
		|ИЗ
		|	Документ.ЧекККМ КАК ЧекККМ
		|ГДЕ
		|	ЧекККМ.Проведен
		|	И ЧекККМ.Контрагент В(&СписокКонтрагентов)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	РеализацияТоваров.Контрагент,
		|	ЛОЖЬ,
		|	ИСТИНА
		|ИЗ
		|	Документ.РеализацияТоваров КАК РеализацияТоваров
		|ГДЕ
		|	РеализацияТоваров.Проведен
		|	И РеализацияТоваров.Контрагент В(&СписокКонтрагентов)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ПриходныйКассовыйОрдер.Контрагент,
		|	ВЫБОР
		|		КОГДА ПриходныйКассовыйОрдер.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ВозвратДенежныхСредствОтПоставщика)
		|				ИЛИ ПриходныйКассовыйОрдер.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ВознаграждениеОтКомитента)
		|			ТОГДА ИСТИНА
		|		ИНАЧЕ ЛОЖЬ
		|	КОНЕЦ,
		|	ВЫБОР
		|		КОГДА ПриходныйКассовыйОрдер.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПоступлениеОплатыОтКлиента)
		|			ТОГДА ИСТИНА
		|		ИНАЧЕ ЛОЖЬ
		|	КОНЕЦ
		|ИЗ
		|	Документ.ПриходныйКассовыйОрдер КАК ПриходныйКассовыйОрдер
		|ГДЕ
		|	ПриходныйКассовыйОрдер.Проведен
		|	И ПриходныйКассовыйОрдер.Контрагент В(&СписокКонтрагентов)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	РасходныйКассовыйОрдер.Контрагент,
		|	ВЫБОР
		|		КОГДА РасходныйКассовыйОрдер.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ОплатаПоставщику)
		|			ТОГДА ИСТИНА
		|		ИНАЧЕ ЛОЖЬ
		|	КОНЕЦ,
		|	ВЫБОР
		|		КОГДА РасходныйКассовыйОрдер.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ВозвратОплатыКлиенту)
		|			ТОГДА ИСТИНА
		|		ИНАЧЕ ЛОЖЬ
		|	КОНЕЦ
		|ИЗ
		|	Документ.РасходныйКассовыйОрдер КАК РасходныйКассовыйОрдер
		|ГДЕ
		|	РасходныйКассовыйОрдер.Проведен
		|	И РасходныйКассовыйОрдер.Контрагент В(&СписокКонтрагентов)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ОплатаОтПокупателяПлатежнойКартой.Контрагент,
		|	ЛОЖЬ,
		|	ИСТИНА
		|ИЗ
		|	Документ.ОплатаОтПокупателяПлатежнойКартой КАК ОплатаОтПокупателяПлатежнойКартой
		|ГДЕ
		|	ОплатаОтПокупателяПлатежнойКартой.Проведен
		|	И ОплатаОтПокупателяПлатежнойКартой.Контрагент В(&СписокКонтрагентов)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	РегистрацияБезналичнойОплаты.Контрагент,
		|	ВЫБОР
		|		КОГДА РегистрацияБезналичнойОплаты.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ОплатаПоставщику)
		|				ИЛИ РегистрацияБезналичнойОплаты.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ВозвратДенежныхСредствОтПоставщика)
		|			ТОГДА ИСТИНА
		|		ИНАЧЕ ЛОЖЬ
		|	КОНЕЦ,
		|	ВЫБОР
		|		КОГДА РегистрацияБезналичнойОплаты.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПоступлениеОплатыОтКлиента)
		|				ИЛИ РегистрацияБезналичнойОплаты.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ВозвратОплатыКлиенту)
		|			ТОГДА ИСТИНА
		|		ИНАЧЕ ЛОЖЬ
		|	КОНЕЦ
		|ИЗ
		|	Документ.РегистрацияБезналичнойОплаты КАК РегистрацияБезналичнойОплаты
		|ГДЕ
		|	РегистрацияБезналичнойОплаты.Проведен
		|	И РегистрацияБезналичнойОплаты.Контрагент В(&СписокКонтрагентов)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	КонтрагентРозничныйПокупатель.Значение,
		|	ЛОЖЬ,
		|	ИСТИНА
		|ИЗ
		|	Константа.КонтрагентРозничныйПокупатель КАК КонтрагентРозничныйПокупатель
		|ГДЕ
		|	КонтрагентРозничныйПокупатель.Значение В(&СписокКонтрагентов)
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Контрагент
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТ_ПокупателиПоставщики.Контрагент КАК Контрагент,
		|	МАКСИМУМ(ВТ_ПокупателиПоставщики.Поставщик) КАК Поставщик,
		|	МАКСИМУМ(ВТ_ПокупателиПоставщики.Покупатель) КАК Покупатель
		|ИЗ
		|	ВТ_ПокупателиПоставщики КАК ВТ_ПокупателиПоставщики
		|
		|СГРУППИРОВАТЬ ПО
		|	ВТ_ПокупателиПоставщики.Контрагент";
	
	Запрос.УстановитьПараметр("СписокКонтрагентов", СписокКонтрагентовДляОбработки);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаКонтрагентов = РезультатЗапроса.Выбрать();
	
	ШаблонТекстаОшибки = НСтр("ru = 'Не удалось установить признак Покупатель, Поставщик контрагенту %1 по причине:
									|%2'");
	
	Пока ВыборкаКонтрагентов.Следующий() Цикл
		
		НачатьТранзакцию();
		
		Попытка
			
			Блокировка = Новый БлокировкаДанных;
			ЭлементБлокировки = Блокировка.Добавить(ПолноеИмяОбъекта);
			ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
			ЭлементБлокировки.УстановитьЗначение("Ссылка", ВыборкаКонтрагентов.Контрагент);
			Блокировка.Заблокировать();
			
			КонтрагентОбъект = ВыборкаКонтрагентов.Контрагент.ПолучитьОбъект();
			
			Если КонтрагентОбъект = Неопределено Тогда
				ОтменитьТранзакцию();
				Продолжить;
			КонецЕсли;
			
			Если ВыборкаКонтрагентов.Покупатель Тогда
				КонтрагентОбъект.Покупатель = ВыборкаКонтрагентов.Покупатель;
			Иначе
				КонтрагентОбъект.Поставщик  = ВыборкаКонтрагентов.Поставщик;
			КонецЕсли;
			
			ОбновлениеИнформационнойБазы.ЗаписатьОбъект(КонтрагентОбъект, Истина);
			ЗафиксироватьТранзакцию();
			
		Исключение
			
			ОтменитьТранзакцию();
			
			ТекстОшибки = СтрШаблон(ШаблонТекстаОшибки, ВыборкаКонтрагентов.Контрагент, ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			
			ЗаписьЖурналаРегистрации(НСтр("ru = 'Обновление информационной базы'",
				ОбщегоНазначения.КодОсновногоЯзыка()),
				УровеньЖурналаРегистрации.Ошибка,,,
				ТекстОшибки);
			
		КонецПопытки;
		
	КонецЦикла;
	
	Параметры.ОбработкаЗавершена = НЕ ОбновлениеИнформационнойБазы.ЕстьДанныеДляОбработки(Параметры.Очередь, ПолноеИмяОбъекта);
	
КонецПроцедуры

#КонецОбласти


#КонецОбласти

#КонецЕсли
