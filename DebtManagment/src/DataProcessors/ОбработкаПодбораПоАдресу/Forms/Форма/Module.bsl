
&НаСервере
Процедура ПодборНаСервере()
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура Подбор(Команда)
	ПодборНаСервере();
	ПараметрыПодбора = Новый Структура("ЗакрыватьПриВыборе, МножественныйВыбор", Ложь, Истина);
 ОткрытьФорму("Справочник.Адреса.ФормаВыбора", ПараметрыПодбора, Элементы.ТаблицаАдресов);
КонецПроцедуры

&НаСервере
Процедура ТаблицаАдресовОбработкаВыбораНаСервере(ВыбранноеЗначение)
	// Вставить содержимое обработчика. 
	 Для Каждого вЗнч Из ВыбранноеЗначение Цикл
 Если ТаблицаАдресов.НайтиСтроки(Новый Структура("Адрес", вЗнч)).Количество() = 0 Тогда
 нСтр = ТаблицаАдресов.Добавить();
 нСтр.Адрес = вЗнч; 
 нСтр.Наименование=вЗнч.ПолноеНаименование();
 
 //нСтр.Предмет = вЗнч.ПроизводимыйПродукт;
 КонецЕсли;
 КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаАдресовОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	 СтандартнаяОбработка = Ложь;
 
 //ИтоговаяТаблицаОбработкаВыбораНаСервере(ВыбранноеЗначение);
	ТаблицаАдресовОбработкаВыбораНаСервере(ВыбранноеЗначение);
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьНаСервере()
	// Вставить содержимое обработчика. 
		//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ДолгиДолжников.Должник КАК Должник,
		|	ДолгиДолжников.Долг КАК Долг,
		|	СтатусыРаботыСДолгомСрезПоследних.СтатусРаботыСДолгом КАК СтатусРаботыСДолгом
		|ПОМЕСТИТЬ ТаблицаДолжники
		|ИЗ
		|	РегистрСведений.ДолгиДолжников КАК ДолгиДолжников
		|		ПРАВОЕ СОЕДИНЕНИЕ РегистрСведений.СтатусыРаботыСДолгом.СрезПоследних(&НаДату, ) КАК СтатусыРаботыСДолгомСрезПоследних
		|		ПО ДолгиДолжников.Долг = СтатусыРаботыСДолгомСрезПоследних.Долг
		|			И (СтатусыРаботыСДолгомСрезПоследних.СтатусРаботыСДолгом В (&СписокСтатусов))
		|ГДЕ
		|	ДолгиДолжников.Долг.ДоговорКонтрагента В(&СписокДоговоров)
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ДолжникиКонтактнаяИнформация.Ссылка КАК Ссылка,
		|	ТаблицаДолжники.Долг КАК Долг,
		|	ТаблицаДолжники.СтатусРаботыСДолгом КАК СтатусРаботыСДолгом,
		|	ДолжникиКонтактнаяИнформация.Представление КАК Представление,
		|	ДолжникиКонтактнаяИнформация.Вид КАК Вид
		|ИЗ
		|	Справочник.Должники.КонтактнаяИнформация КАК ДолжникиКонтактнаяИнформация
		|		ЛЕВОЕ СОЕДИНЕНИЕ ТаблицаДолжники КАК ТаблицаДолжники
		|		ПО ДолжникиКонтактнаяИнформация.Ссылка = ТаблицаДолжники.Должник
		|ГДЕ
		|	ДолжникиКонтактнаяИнформация.Адрес В ИЕРАРХИИ(&СписокАдресов)
		|	И ДолжникиКонтактнаяИнформация.Вид В(&СписокВидов)";

	
	Запрос.УстановитьПараметр("СписокАдресов", ПолучитьСписокАдресовДляЗаполнения());
	Запрос.УстановитьПараметр("СписокВидов", ПолучитьМассивВидовАдресовДляЗаполнения());
   	Запрос.УстановитьПараметр("СписокДоговоров",ПолучитьСписокДоговоровДляЗаполнения());
		Запрос.УстановитьПараметр("СписокСтатусов",ПолучитьМассивСтатусовДляЗаполнения());
	Запрос.УстановитьПараметр("НаДату",ТекущаяДата());
                                         
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		// Вставить обработку выборки ВыборкаДетальныеЗаписи 
		
		СтрокаРезультат = ТаблицаРезультат.Добавить();
		СтрокаРезультат.Должник =ВыборкаДетальныеЗаписи.Ссылка; 
		СтрокаРезультат.ВидАдреса = ВыборкаДетальныеЗаписи.Вид;
		СтрокаРезультат.Адрес = ВыборкаДетальныеЗаписи.Представление;
		СтрокаРезультат.Долг = ВыборкаДетальныеЗаписи.Долг;

	КонецЦикла;
	
	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА

КонецПроцедуры 
&НаСервере
Функция ПолучитьСписокАдресовДляЗаполнения()
	СписокАдресов = ТаблицаАдресов.Выгрузить().ВыгрузитьКолонку("Адрес");
	Возврат СписокАдресов;
КонецФункции
&НаСервере
Функция ПолучитьСписокДоговоровДляЗаполнения()
	СписокДоговоров = ТаблицаДоговоров.Выгрузить().ВыгрузитьКолонку("Договор");
	Возврат СписокДоговоров;
КонецФункции

&НаСервере
 Функция ПолучитьМассивСтатусовДляЗаполнения()
	МассивСтатусовДляЗаполнения =НОвый Массив;
	Для Каждого Элемент из СписокСтатусовРаботыСДолгом цикл
		Если Элемент.Пометка тогда
			МассивСтатусовДляЗаполнения.Добавить(Элемент.Значение);
		КонецЕсли;	
	КонецЦикла;	
		 Возврат МассивСтатусовДляЗаполнения ;
КонецФункции

&НаСервере
Функция ПолучитьМассивВидовАдресовДляЗаполнения()
	МассивВидовАдресовДляЗаполнения =НОвый Массив;
	Для Каждого Элемент из СписокВидовАдресов цикл
		Если Элемент.Пометка тогда
			МассивВидовАдресовДляЗаполнения.Добавить(Элемент.Значение);
		КонецЕсли;	
	КонецЦикла;	
		 Возврат МассивВидовАдресовДляЗаполнения ;
КонецФункции

//Функция ПолучитьМассивСтатусовДляЗаполнения()
//	МассивСтатусовДляЗаполнения =НОвый Массив;
//	Для Каждого Элемент из СписокСтатусовРаботыСДолгом цикл
//		Если Элемент.Пометка тогда
//			МассивСтатусовДляЗаполнения.Добавить(Элемент.Значение);
//		КонецЕсли;	
//	КонецЦикла;	
//		 Возврат МассивСтатусовДляЗаполнения ;
//КонецФункции


&НаКлиенте
Процедура Заполнить(Команда)
	ЗаполнитьНаСервере(); 
	Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.ГруппаСтраницаРезультат;
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	//Вставить содержимое обработчика  
ЗаполнитьСписокВидовАдресов();
ЗаполнитьСписокСтатусовРаботыСДолгом();
КонецПроцедуры  

 
&НаСервере	
Процедура ЗаполнитьСписокСтатусовРаботыСДолгом()
     	//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	СтатусыРаботыСДолгом.Ссылка КАК Ссылка
		|ИЗ
		|	Перечисление.СтатусыРаботыСДолгом КАК СтатусыРаботыСДолгом";
	
	РезультатЗапроса = Запрос.Выполнить().Выбрать();
	Пока РезультатЗапроса.Следующий() Цикл 
		СписокСтатусовРаботыСДолгом.Добавить(РезультатЗапроса.Ссылка);
		// Вставить обработку выборки ВыборкаДетальныеЗаписи
	КонецЦикла;
	
	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА

КонецПроцедуры
	
&НаСервере
Процедура ЗаполнитьСписокВидовАдресов()
	//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ВидыКонтактнойИнформации.Ссылка КАК Ссылка,
		|	ВидыКонтактнойИнформации.Представление КАК Представление
		|ИЗ
		|	Справочник.ВидыКонтактнойИнформации КАК ВидыКонтактнойИнформации
		|ГДЕ
		|	ВидыКонтактнойИнформации.Родитель = &Родитель
		|	И ВидыКонтактнойИнформации.Тип = Значение(Перечисление.ТипыКонтактнойИнформации.Адрес)";
	
	Запрос.УстановитьПараметр("Родитель", Справочники.ВидыКонтактнойИнформации.СправочникДолжники);
	
	РезультатЗапроса = Запрос.Выполнить().Выбрать();
		
	Пока РезультатЗапроса.Следующий() Цикл
		// Вставить обработку выборки ВыборкаДетальныеЗаписи                  Представление
		СписокВидовАдресов.Добавить(РезультатЗапроса.Ссылка,РезультатЗапроса.Представление);
	КонецЦикла;
	
	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА


КонецПроцедуры	

&НаСервере
Процедура ПодборДоговорНаСервере()
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура ПодборДоговор(Команда) 
	ПараметрыПодбора = Новый Структура("ЗакрыватьПриВыборе, МножественныйВыбор", Ложь, Истина);
 	ОткрытьФорму("Справочник.ДоговорыКонтрагентов.ФормаВыбора", ПараметрыПодбора, Элементы.ТаблицаДоговоров);

	ПодборДоговорНаСервере();
КонецПроцедуры

&НаСервере
Процедура ТаблицаДоговоровОбработкаВыбораНаСервере(ВыбранноеЗначение)  
		 Для Каждого вЗнч Из ВыбранноеЗначение Цикл
 Если ТаблицаДоговоров.НайтиСтроки(Новый Структура("Договор", вЗнч)).Количество() = 0 Тогда
 нСтр = ТаблицаДоговоров.Добавить();
 нСтр.Договор = вЗнч; 
 нСтр.Контрагент=вЗнч.Владелец;
 нСтр.СтатусРаботы=вЗнч.СтатусДействия;
 //нСтр.Предмет = вЗнч.ПроизводимыйПродукт;
 КонецЕсли;
 КонецЦикла;

	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаДоговоровОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка) 
	СтандартнаяОбработка = Ложь;
	ТаблицаДоговоровОбработкаВыбораНаСервере(ВыбранноеЗначение);
КонецПроцедуры

&НаСервере
Процедура ТЕст()
	//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	//Запрос.Текст = 
	//	"ВЫБРАТЬ
	//	|	ДолгиДолжников.Должник КАК Должник,
	//	|	ДолгиДолжников.Долг КАК Долг,
	//	|	СтатусыРаботыСДолгомСрезПоследних.СтатусРаботыСДолгом КАК СтатусРаботыСДолгом
	//	|ПОМЕСТИТЬ ТаблицаДолжники
	//	|ИЗ
	//	|	РегистрСведений.ДолгиДолжников КАК ДолгиДолжников
	//	|		ПРАВОЕ СОЕДИНЕНИЕ РегистрСведений.СтатусыРаботыСДолгом.СрезПоследних(&НаДату, ) КАК СтатусыРаботыСДолгомСрезПоследних
	//	|		ПО ДолгиДолжников.Долг = СтатусыРаботыСДолгомСрезПоследних.Долг
	//	|			И (СтатусыРаботыСДолгомСрезПоследних.СтатусРаботыСДолгом В (&СписокСтатусов))
	//	|ГДЕ
	//	|	ДолгиДолжников.Долг.ДоговорКонтрагента В(&СписокДоговоров)
	//	|;
	//	|
	//	|////////////////////////////////////////////////////////////////////////////////
	//	|ВЫБРАТЬ
	//	|	ДолжникиКонтактнаяИнформация.Ссылка КАК Ссылка,
	//	|	ТаблицаДолжники.Долг КАК Долг,
	//	|	ТаблицаДолжники.СтатусРаботыСДолгом КАК СтатусРаботыСДолгом,
	//	|	ДолжникиКонтактнаяИнформация.Представление КАК Представление,
	//	|	ДолжникиКонтактнаяИнформация.Вид КАК Вид
	//	|ИЗ
	//	|	Справочник.Должники.КонтактнаяИнформация КАК ДолжникиКонтактнаяИнформация
	//	|		ЛЕВОЕ СОЕДИНЕНИЕ ТаблицаДолжники КАК ТаблицаДолжники
	//	|		ПО ДолжникиКонтактнаяИнформация.Ссылка = ТаблицаДолжники.Должник
	//	|ГДЕ
	//	|	ДолжникиКонтактнаяИнформация.Адрес В ИЕРАРХИИ(&СписокАдресов)
	//	|	И ДолжникиКонтактнаяИнформация.Вид В(&СписокВидов)";
	//
	//Запрос.УстановитьПараметр("НаДату", НаДату);
	//Запрос.УстановитьПараметр("СписокАдресов", СписокАдресов);
	//Запрос.УстановитьПараметр("СписокВидов", СписокВидов);
	//Запрос.УстановитьПараметр("СписокДоговоров", СписокДоговоров);
	//Запрос.УстановитьПараметр("СписокСтатусов", СписокСтатусов);
	//
	//РезультатЗапроса = Запрос.Выполнить();
	//
	//ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	//
	//Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
	//	// Вставить обработку выборки ВыборкаДетальныеЗаписи
	//КонецЦикла;
	
	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА




КонецПроцедуры	

