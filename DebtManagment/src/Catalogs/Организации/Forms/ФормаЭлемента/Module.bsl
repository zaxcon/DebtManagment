#Область ПрограммныйИнтерфейс

&НаКлиенте
Перем ОтключитьЗаполнениеПоИНН;

&НаКлиенте
Перем ФормаДлительнойОперации Экспорт;

#КонецОбласти


#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	УправлениеКонтактнойИнформацией.ПриСозданииНаСервере(ЭтотОбъект, Объект, "СтраницаКонтактнаяИнформация",ПоложениеЗаголовкаЭлементаФормы.Лево);
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация
	
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтотОбъект);
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	
	Если ЗначениеЗаполнено(Объект.Ссылка) Тогда
		
		ЗаполнитьДанныеФИО();
		
		ЗаполнитьДанныеОтветственныхЛиц();
			
	Иначе
		УправлениеЭлементамиФормыНаСервере();
	КонецЕсли;
	
	ПодготовитьФормуНаСервере();
	
	// ИнтернетПоддержкаПользователей.СПАРКРиски
	
		
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// ИнтернетПоддержкаПользователей.СПАРКРиски
	;
	// Конец ИнтернетПоддержкаПользователей.СПАРКРиски
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// ЭлектронноеВзаимодействие.ОбменСКонтрагентами
	//ПараметрыПриОткрытии = ОбменСКонтрагентамиКлиент.ПараметрыПриОткрытии();
	//ПараметрыПриОткрытии.Форма                            = ЭтотОбъект;
	//ПараметрыПриОткрытии.МестоРазмещенияКоманд            = Элементы.КомандыЭДО;
	//ПараметрыПриОткрытии.ЕстьОбработчикОбновитьКомандыЭДО = Истина;
	//
	//ОбменСКонтрагентамиКлиент.ПриОткрытии(ПараметрыПриОткрытии);
	// Конец ЭлектронноеВзаимодействие.ОбменСКонтрагентами
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	УправлениеКонтактнойИнформацией.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация
	
	ПодготовитьФормуНаСервере();
	УправлениеЭлементамиФормыНаСервере();
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ЗаписатьДанныеОтветственныхЛиц(ТекущийОбъект);
	ЗаписатьДанныеФИО(ТекущийОбъект);
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	Если Объект.ЮрФизЛицо <>  Перечисления.ЮрФизЛицо.ИндивидуальныйПредприниматель Тогда
		ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "Фамилия");
	КонецЕсли;
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	УправлениеКонтактнойИнформацией.ОбработкаПроверкиЗаполненияНаСервере(ЭтотОбъект, Объект, Отказ);
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация

		
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	УправлениеКонтактнойИнформацией.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация

	ОбновитьИнтерфейс = ТекущийОбъект.ЭтоНовый();
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	
	ЗаписатьПараметрыПодключенияНСПК();
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	УправлениеЭлементамиФормыНаСервере();
	
	Если ОбновитьИнтерфейс Тогда
		
		ОбновитьИнтерфейс();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ИзменениеОтветственныхЛиц" Тогда
		
		ЗаполнитьДанныеОтветственныхЛиц();
		
	ИначеЕсли ИмяСобытия = "ЗагруженАдресныйКлассификатор" Тогда
		
		Элементы.ДекорацияАдресныйКлассификаторНеЗагружен.Видимость = АдресныйКлассификаторПуст();
		
	ИначеЕсли ИмяСобытия = "ИзменениеСНООрганизации" И Параметр = Объект.Ссылка Тогда
		
		УправлениеЭлементамиСНО();
		
	Иначе
		
		// ЭлектронноеВзаимодействие.ОбменСКонтрагентами
		//ПараметрыОповещенияЭДО = ОбменСКонтрагентамиКлиент.ПараметрыОповещенияЭДО_ФормаСправочника();
		//ПараметрыОповещенияЭДО.Форма                            = ЭтотОбъект;
		//ПараметрыОповещенияЭДО.МестоРазмещенияКоманд            = Элементы.КомандыЭДО;
		//ПараметрыОповещенияЭДО.ЕстьОбработчикОбновитьКомандыЭДО = Истина;
		//
		//ОбменСКонтрагентамиКлиент.ОбработкаОповещения_ФормаСправочника(ИмяСобытия, Параметр, Источник, ПараметрыОповещенияЭДО);
		// Конец ЭлектронноеВзаимодействие.ОбменСКонтрагентами
		
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ЮрФизЛицоПриИзменении(Элемент)
	
	ЮрФизЛицоПриИзмененииНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ДекорацияАдресныйКлассификаторНеЗагруженОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	Если НавигационнаяСсылкаФорматированнойСтроки = "ЗагрузитьАдресныйКлассификатор" Тогда
		СтандартнаяОбработка = Ложь;
		АдресныйКлассификаторКлиент.ЗагрузитьАдресныйКлассификатор();
	КонецЕсли;
КонецПроцедуры


&НаКлиенте
Процедура ДекорацияИзменитьСНОНажатие(Элемент)
		
	Если ЗначениеЗаполнено(Объект.Ссылка) Тогда
		
		Отбор 			= Новый Структура("Организация", Объект.Ссылка);		
		ПараметрыФормы 	= Новый Структура("Отбор", Отбор);	
		
		// &ЗамерПроизводительности 	
        ОценкаПроизводительностиРТКлиент.НачатьЗамер(
                 Истина, "РегистрСведений.ПрименениеСистемНалогообложения.Форма.ФормаСпискаСНООрганизации");
		
		ОткрытьФорму("РегистрСведений.ПрименениеСистемНалогообложения.Форма.ФормаСпискаСНООрганизации", ПараметрыФормы, ЭтотОбъект);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ИННПриИзменении(Элемент)
	// ИнтернетПоддержкаПользователей.СПАРКРиски
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
	
	МодульУправлениеКонтактнойИнформациейКлиент =
		ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеКонтактнойИнформациейКлиент");
	МодульУправлениеКонтактнойИнформациейКлиент.АвтоПодборАдреса(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	МодульУправлениеКонтактнойИнформациейКлиент =
		ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеКонтактнойИнформациейКлиент");
	МодульУправлениеКонтактнойИнформациейКлиент.ОбработкаВыбора(ЭтотОбъект, ВыбранноеЗначение, Элемент.Имя, СтандартнаяОбработка);
	
КонецПроцедуры



#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Объект, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияПриИзменении(Элемент)
	
	МодульУправлениеКонтактнойИнформациейКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеКонтактнойИнформациейКлиент");
	МодульУправлениеКонтактнойИнформациейКлиент.ПриИзменении(ЭтотОбъект, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	МодульУправлениеКонтактнойИнформациейКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеКонтактнойИнформациейКлиент");
	МодульУправлениеКонтактнойИнформациейКлиент.НачалоВыбора(ЭтотОбъект, Элемент, , СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияПриНажатии(Элемент, СтандартнаяОбработка)
	
	МодульУправлениеКонтактнойИнформациейКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеКонтактнойИнформациейКлиент");
	МодульУправлениеКонтактнойИнформациейКлиент.НачалоВыбора(ЭтотОбъект, Элемент,, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияОчистка(Элемент, СтандартнаяОбработка)
	
	МодульУправлениеКонтактнойИнформациейКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеКонтактнойИнформациейКлиент");
	МодульУправлениеКонтактнойИнформациейКлиент.Очистка(ЭтотОбъект, Элемент.Имя);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияВыполнитьКоманду(Команда)
	
	МодульУправлениеКонтактнойИнформациейКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеКонтактнойИнформациейКлиент");
	МодульУправлениеКонтактнойИнформациейКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда.Имя);
	
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ОбновитьКонтактнуюИнформацию(Результат) Экспорт
	
	МодульУправлениеКонтактнойИнформацией = ОбщегоНазначения.ОбщийМодуль("УправлениеКонтактнойИнформацией");
	МодульУправлениеКонтактнойИнформацией.ОбновитьКонтактнуюИнформацию(ЭтотОбъект, Объект, Результат);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередатьСведенияОбОрганизацииГИСМ(Команда)
	
		Возврат;
	
КонецПроцедуры

// ЭлектронноеВзаимодействие.ОбменСКонтрагентами

&НаКлиенте
Процедура Подключаемый_ВыполнитьКомандуЭДО(Команда)
	
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбработчикОжиданияЭДО()
	
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКомандыЭДО()
	
	
КонецПроцедуры

// Конец ЭлектронноеВзаимодействие.ОбменСКонтрагентами

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Процедура управляет видимостью и доступностью элементов на форме.
//
&НаСервере
Процедура УправлениеЭлементамиФормыНаСервере()
	
	ЭтоЮридическоеЛицо =  Объект.ЮрФизЛицо = Перечисления.ЮрФизЛицо.ЮрЛицо
		ИЛИ Объект.ЮрФизЛицо = Перечисления.ЮрФизЛицо.ЮрЛицоНеРезидент;
		
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "КПП", "Видимость", ЭтоЮридическоеЛицо);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "РеквизитыИП", "Видимость", Не ЭтоЮридическоеЛицо);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ПодменюПерейти", "Доступность", ЗначениеЗаполнено(Объект.Ссылка));
	
	Если ЭтоЮридическоеЛицо Тогда
		Элементы.ИНН.Маска = "9999999999";//10
		Элементы.КодПоОКПО.Маска = "99999999";//8
		Элементы.ОГРН.Маска = "9999999999999";//13
		Элементы.ОГРН.Заголовок = "ОГРН";
	Иначе
		Элементы.ИНН.Маска = "999999999999";//12
		Элементы.КодПоОКПО.Маска = "9999999999";//10
		Элементы.ОГРН.Маска = "999999999999999";//15
		Элементы.ОГРН.Заголовок = Нстр("ru='ОГРН ИП'");
	КонецЕсли;
	
	Элементы.ГруппаОбособленное.Видимость = ЭтоЮридическоеЛицо;
	Элементы.ГоловнаяОрганизация.Доступность = Объект.ОбособленноеПодразделение;
	
	УправлениеЭлементамиСНО();
			
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДанныеОтветственныхЛиц()
	//
	Руководитель = Справочники.ФизическиеЛица.ПустаяСсылка();
	Бухгалтер = Справочники.ФизическиеЛица.ПустаяСсылка();
	Кассир = Справочники.ФизическиеЛица.ПустаяСсылка();
	
	ОтветственныеЛица = Новый Массив;
	ОтветственныеЛица.Добавить(Перечисления.ОтветственныеЛицаОрганизаций.Руководитель);
	ОтветственныеЛица.Добавить(Перечисления.ОтветственныеЛицаОрганизаций.ГлавныйБухгалтер);
	ОтветственныеЛица.Добавить(Перечисления.ОтветственныеЛицаОрганизаций.Кассир);
	ОтветственныеЛица.Добавить(Перечисления.ОтветственныеЛицаОрганизаций.Логист);
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос("ВЫБРАТЬ
	|	ОтветственныеЛица.ФизическоеЛицо КАК ФизическоеЛицо,
	|	ОтветственныеЛица.ОтветственноеЛицо КАК ОтветственноеЛицо
	|ИЗ
	|	РегистрСведений.ОтветственныеЛицаОрганизаций.СрезПоследних(
	|			&Период,
	|			СтруктурнаяЕдиница = &СтруктурнаяЕдиница
	|				И ОтветственноеЛицо В (&ОтветственныеЛица)) КАК ОтветственныеЛица");
	
	Запрос.УстановитьПараметр("СтруктурнаяЕдиница", Объект.Ссылка);
	Запрос.УстановитьПараметр("ОтветственныеЛица", ОтветственныеЛица);
	Запрос.УстановитьПараметр("Период", ТекущаяДатаСеанса());
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		Если Выборка.ОтветственноеЛицо = Перечисления.ОтветственныеЛицаОрганизаций.Руководитель Тогда
			
			Руководитель = Выборка.ФизическоеЛицо;
			
		ИначеЕсли Выборка.ОтветственноеЛицо = Перечисления.ОтветственныеЛицаОрганизаций.ГлавныйБухгалтер Тогда
			
			Бухгалтер = Выборка.ФизическоеЛицо;
			
		ИначеЕсли Выборка.ОтветственноеЛицо = Перечисления.ОтветственныеЛицаОрганизаций.Кассир Тогда
			
			Кассир = Выборка.ФизическоеЛицо;
			
		ИначеЕсли Выборка.ОтветственноеЛицо = Перечисления.ОтветственныеЛицаОрганизаций.Логист Тогда
			
			Логист = Выборка.ФизическоеЛицо;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Элементы.СтраницаОтветственныеЛица.ТолькоПросмотр = ЭтотОбъект.ТолькоПросмотр;
	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьДанныеОтветственныхЛиц(ТекущийОбъект);
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("Руководитель", Перечисления.ОтветственныеЛицаОрганизаций.Руководитель);
	СтруктураПараметров.Вставить("Бухгалтер", Перечисления.ОтветственныеЛицаОрганизаций.ГлавныйБухгалтер);
	СтруктураПараметров.Вставить("Кассир", Перечисления.ОтветственныеЛицаОрганизаций.Кассир);
	СтруктураПараметров.Вставить("Логист", Перечисления.ОтветственныеЛицаОрганизаций.Логист);
	
	Для каждого КлючИЗначение Из СтруктураПараметров Цикл
		СтруктураЗаписи = РегистрыСведений.ОтветственныеЛицаОрганизаций.ПолучитьПоследнее(
			ТекущаяДатаСеанса(),
			Новый Структура("СтруктурнаяЕдиница, ОтветственноеЛицо", ТекущийОбъект.Ссылка, КлючИЗначение.Значение)
			);
			
		Если СтруктураЗаписи.ФизическоеЛицо <> ЭтотОбъект[КлючИЗначение.Ключ] Тогда
			
			МенеджерЗаписи = РегистрыСведений.ОтветственныеЛицаОрганизаций.СоздатьМенеджерЗаписи();
			МенеджерЗаписи.Период = ТекущаяДатаСеанса();
			МенеджерЗаписи.СтруктурнаяЕдиница = ТекущийОбъект.Ссылка;
			МенеджерЗаписи.ОтветственноеЛицо = КлючИЗначение.Значение;
			МенеджерЗаписи.ФизическоеЛицо = ЭтотОбъект[КлючИЗначение.Ключ];
			МенеджерЗаписи.Записать();
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДанныеФИО()
	
	//Запрос = Новый Запрос("ВЫБРАТЬ
	//|	ФИОФизЛицСрезПоследних.Имя,
	//|	ФИОФизЛицСрезПоследних.Отчество,
	//|	ФИОФизЛицСрезПоследних.Фамилия
	//|ИЗ
	//|	РегистрСведений.ФИОФизЛиц.СрезПоследних(&Период, ФизЛицо = &Ссылка) КАК ФИОФизЛицСрезПоследних");
	//
	//Запрос.УстановитьПараметр("Ссылка",Объект.Ссылка);
	//Запрос.УстановитьПараметр("Период",ТекущаяДатаСеанса());
	//
	//РезультатЗапроса = Запрос.Выполнить();
	//
	//Если НЕ РезультатЗапроса.Пустой() Тогда
	//	
	//	Выборка = РезультатЗапроса.Выбрать();
	//	
	//	Если Выборка.Следующий() Тогда
	//		
	//		Фамилия = Выборка.Фамилия;
	//		Имя = Выборка.Имя;
	//		Отчество = Выборка.Отчество;
	//		
	//	КонецЕсли;
	//	
	//КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ЗаписатьДанныеФИО(ТекущийОбъект)
	
	//ТекущаяДатаСеанса = ТекущаяДатаСеанса();
	//
	//Если ТекущийОбъект.ЮрФизЛицо = Перечисления.ЮрФизЛицо.ИндивидуальныйПредприниматель Тогда
	//	
	//	ТекущаяДатаСеанса = ТекущаяДатаСеанса();
	//	СтруктураЗаписи = РегистрыСведений.ФИОФизЛиц.ПолучитьПоследнее(ТекущаяДатаСеанса, Новый Структура("ФизЛицо", ТекущийОбъект.Ссылка));
	//	Если СтруктураЗаписи.Фамилия <> Фамилия
	//		ИЛИ СтруктураЗаписи.Отчество <> Отчество
	//		ИЛИ СтруктураЗаписи.Имя <> Имя Тогда
	//		МенеджерЗаписи = РегистрыСведений.ФИОФизЛиц.СоздатьМенеджерЗаписи();
	//		МенеджерЗаписи.ФизЛицо = ТекущийОбъект.Ссылка;
	//		МенеджерЗаписи.Период = ТекущаяДатаСеанса;
	//		МенеджерЗаписи.Фамилия = Фамилия;
	//		МенеджерЗаписи.Имя = Имя;
	//		МенеджерЗаписи.Отчество = Отчество;
	//		МенеджерЗаписи.Записать(Истина);
	//	КонецЕсли;
	//	
	//Иначе
	//	
	//	Запрос = Новый Запрос("ВЫБРАТЬ
	//	|	ФИОФизЛицСрезПоследних.Имя,
	//	|	ФИОФизЛицСрезПоследних.Отчество,
	//	|	ФИОФизЛицСрезПоследних.Фамилия
	//	|ИЗ
	//	|	РегистрСведений.ФИОФизЛиц.СрезПоследних(&Период, ФизЛицо = &Ссылка) КАК ФИОФизЛицСрезПоследних");
	//	
	//	Запрос.УстановитьПараметр("Ссылка",Объект.Ссылка);
	//	Запрос.УстановитьПараметр("Период",ТекущаяДатаСеанса);
	//	
	//	РезультатЗапроса = Запрос.Выполнить();
	//	
	//	Если НЕ РезультатЗапроса.Пустой() Тогда
	//		
	//		Выборка = РезультатЗапроса.Выбрать();
	//		Если Выборка.Фамилия <> Фамилия
	//			ИЛИ Выборка.Имя <> Имя
	//			ИЛИ Выборка.Отчество <> Отчество Тогда
	//			
	//			МенеджерЗаписи = РегистрыСведений.ФИОФизЛиц.СоздатьМенеджерЗаписи();
	//			МенеджерЗаписи.ФизЛицо = ТекущийОбъект.Ссылка;
	//			МенеджерЗаписи.Период = ТекущаяДатаСеанса;
	//			МенеджерЗаписи.Фамилия = Фамилия;
	//			МенеджерЗаписи.Имя = Имя;
	//			МенеджерЗаписи.Отчество = Отчество;
	//			МенеджерЗаписи.Записать(Истина);
	//			
	//		КонецЕсли;
	//					
	//	КонецЕсли;
	//	
	//КонецЕсли;
	
КонецПроцедуры


&НаСервере
Процедура УправлениеЭлементамиСНО()
	
КонецПроцедуры

&НаСервере
Процедура ПодготовитьФормуНаСервере()
	
	Элементы.ДекорацияАдресныйКлассификаторНеЗагружен.Видимость = АдресныйКлассификаторПуст();
	
	Текст = СтрШаблон(
		НСтр("ru = 'Для автоподбора и выбора адресных сведений необходимо <a href = %1 >загрузить классификатор</a>.'"),
		"ЗагрузитьАдресныйКлассификатор");
		ФорматированнаяСтрока = СтроковыеФункции.ФорматированнаяСтрока(Текст);
		Элементы.ДекорацияАдресныйКлассификаторНеЗагружен.Заголовок = ФорматированнаяСтрока;
		
	//Элементы.ЗаполнитьПоИНН.Видимость = ИнтернетПоддержкаПользователей.ЗаполненыДанныеАутентификацииПользователяИнтернетПоддержки();
	
	НастроитьСНО = НСтр("ru = 'Настроить использование нескольких систем налогообложения'");
	
//	Элементы.СобственныйКонтрагент.Доступность = ПолучитьФункциональнуюОпцию("ИспользоватьОбменЭД");
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция АдресныйКлассификаторПуст()
	Возврат НЕ АдресныйКлассификатор.АдресныйКлассификаторЗагружен();
КонецФункции




&НаСервере
Процедура ЗаполнитьЭлементКонтактнойИнформации(ВидКонтактнойИнформации, СтруктураДанных)
	
	Если СтруктураДанных = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Отбор = Новый Структура("Вид", ВидКонтактнойИнформации);
	Строки = ЭтотОбъект.КонтактнаяИнформацияОписаниеДополнительныхРеквизитов.НайтиСтроки(Отбор);
	ДанныеСтроки = ?(Строки.Количество() = 0, Неопределено, Строки[0]);
	Если ДанныеСтроки = Неопределено Тогда
		Возврат;
	КонецЕсли;
	ДанныеСтроки.Представление = СтруктураДанных.Представление;
	ДанныеСтроки.Значение = СтруктураДанных.КонтактнаяИнформация;
	ЭтотОбъект[ДанныеСтроки.ИмяРеквизита] = СтруктураДанных.Представление;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбособленноеПодразделениеПриИзменении(Элемент)
	
	ОбособленноеПодразделениеПриИзмененииСервер();
	
КонецПроцедуры

&НаСервере
Процедура ОбособленноеПодразделениеПриИзмененииСервер()
	Если НЕ Объект.ОбособленноеПодразделение Тогда
		Объект.ГоловнаяОрганизация = Справочники.Организации.ПустаяСсылка();
	КонецЕсли;
	УправлениеЭлементамиФормыНаСервере();
КонецПроцедуры


&НаКлиентеНаСервереБезКонтекста
Функция ПоказатьИнформациюСпарк(Форма)
	
	Объект = Форма.Объект;
	ПоказатьИнформацию = (Объект.ЮрФизЛицо = ПредопределенноеЗначение("Перечисление.ЮрФизЛицо.ЮрЛицо"));
	Возврат ПоказатьИнформацию;
	
КонецФункции

&НаКлиенте
Процедура ОткрытьФормуПрименениеСистемНалогообложения()
	
	Отбор 			= Новый Структура("Организация", Объект.Ссылка);
	ПараметрыФормы 	= Новый Структура("Отбор", Отбор);	
	
	// &ЗамерПроизводительности
	ОценкаПроизводительностиРТКлиент.НачатьЗамер(
		Истина, "РегистрСведений.ПрименениеСистемНалогообложения.ФормаСписка");
	
	ОткрытьФорму("РегистрСведений.ПрименениеСистемНалогообложения.ФормаСписка", ПараметрыФормы, ЭтотОбъект);
	
КонецПроцедуры

&НаСервере
Процедура ЮрФизЛицоПриИзмененииНаСервере()
	
	Если Объект.ЮрФизЛицо <> Перечисления.ЮрФизЛицо.ИндивидуальныйПредприниматель Тогда
		
				
	КонецЕсли; 
	
	УправлениеЭлементамиФормыНаСервере();
	
КонецПроцедуры


&НаСервере
Процедура ЗаписатьПараметрыПодключенияНСПК()
	

КонецПроцедуры

#КонецОбласти