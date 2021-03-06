
&НаКлиенте
Процедура АдресНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
		СтандартнаяОбработка =Ложь;
	 // Вставить содержимое обработчика.  
	ПараметрыОткрытия=Новый Структура;
	ПараметрыОткрытия.Вставить("ОткрытаПоСценарию","");                                                            
	ПараметрыОткрытия.Вставить("Представление",Адрес); 
	ПараметрыОткрытия.Вставить("Значение",ЗначениеАдреса);
	ДопПараметры=Новый Структура;

	ДопПараметры.Вставить("Владелец",Элемент);
	Оповещение= НОвый ОписаниеОповещения("ОбработатьВыборАдреса",ЭтотОбъект,ДопПараметры); 
	
    ОткрытьФорму("Обработка.РасширенныйВводКонтактнойИнформации.Форма.ВводАдреса",ПараметрыОткрытия,Элемент,,,,Оповещение);

КонецПроцедуры

&НаКлиенте
Процедура ОбработатьВыборАдреса(Результат,ДопПарметры) Экспорт  
	Если Результат<>Неопределено тогда
		//если ДопПарметры.Владелец
		Адрес=Результат.Представление;    
	КонецЕсли;
КонецПроцедуры	  

&НаСервере
	Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
		//Вставить содержимое обработчика 
		Параметры.Свойство("Владелец",Владелец);

	Элементы.ВидАдреса.СписокВыбора.ЗагрузитьЗначения(Параметры.СписокВыбораАдреса); 
	Параметры.Свойство("ВидАдреса",ВидАдреса);
	Параметры.Свойство("Адрес",Адрес);
    Параметры.Свойство("Значение",ЗначениеАдреса);
	КонецПроцедуры

	&НаКлиенте
	Процедура АдресОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
		СтандартнаяОбработка=Ложь;
		Адрес=ВыбранноеЗначение.Представление; 
		ЗначениеАдреса =ВыбранноеЗначение.Значение; 
	КонецПроцедуры

&НаКлиенте
	Процедура Записать(Команда)
		// Вставить содержимое обработчика. 
		Если ПроверитьЗаполнение() тогда
		СтруктураЗакрытия=Новый Структура;
		СтруктураЗакрытия.Вставить("ВидАдреса",ВидАдреса);
		СтруктураЗакрытия.Вставить("ЗначениеАдреса",ЗначениеАдреса);
		СтруктураЗакрытия.Вставить("Адрес",Адрес);
		Закрыть(СтруктураЗакрытия);     
		КонецЕсли;
	КонецПроцедуры

&НаКлиенте
	Процедура ЗакрытьБезСохранения(Команда)
		// Вставить содержимое обработчика.
		Закрыть();
	КонецПроцедуры
