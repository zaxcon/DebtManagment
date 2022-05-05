&НаКлиенте
Процедура ДобавитьФайл()
		РаботаСФайламиКлиент.ДобавитьФайлы(ВладелецФайла, УникальныйИдентификатор, , Файл);
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
			//Вставить содержимое обработчика  
	Если Не Параметры.Свойство("ВидЗагруженногоДокумента",ВидЗагруженногоДокумента) тогда
		
	КонецЕсли;	
	
	Если Не Параметры.Свойство("ВладелецФайла",ВладелецФайла) тогда   
		Отказ = Истина;
	КонецЕсли;	
	ТипЗагруженногоДокумента = Перечисления.ТипыЗагруженныхДокументов.Оригинал;
	
КонецПроцедуры



&НаКлиенте
Процедура СохранитьФайл(Команда)
	// Вставить содержимое обработчика. 
	#Если ВебКлиент Тогда 
		АдресВХранилище = АдресФайла;
	
	СтруктураИмениФайла = ПолучитьСтруктуруИмениФайла(Файл);
	
	СсылкаНаФайл = ПрикрепитьФайлКОбъектуНаСервере(АдресВХранилище, СтруктураИмениФайла, ВладелецФайла);
	Закрыть();  

	 #Иначе
	 ВыбФайл = Новый Файл(Файл);
		Если ВыбФайл.Существует() Тогда 
	ДвоичныеДанные = Новый ДвоичныеДанные(Файл);
	АдресВХранилище = ПоместитьВоВременноеХранилище(ДвоичныеДанные);
	
	СтруктураИмениФайла = ПолучитьСтруктуруИмениФайла(Файл);
	
	СсылкаНаФайл = ПрикрепитьФайлКОбъектуНаСервере(АдресВХранилище, СтруктураИмениФайла, ВладелецФайла);
	Закрыть();  
иначе
	Сообщить("Файл не выбран или не существует!!!",СтатусСообщения.Важное);
КонецЕсли; 

#КонецЕсли 	
	

КонецПроцедуры


&НаКлиенте
Процедура ФайлНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
    СтандартнаяОбработка = Ложь;
	#Если ВебКлиент Тогда  
	 ДиалогВыбора = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие); 
	ДиалогВыбора.Заголовок = "Собственный заголовок диалога загрузки файла";
	ОбработкаОкончанияЗагрузки = Новый ОписаниеОповещения("Обработчик_Завершения_Загрузки", ЭтотОбъект, ДиалогВыбора);
	ОбработкаНачалаЗагрузки = Новый ОписаниеОповещения("Обработчик_Начала_Загрузки", ЭтотОбъект);
	НачатьПомещениеФайла(ОбработкаОкончанияЗагрузки, , ДиалогВыбора, Истина, УникальныйИдентификатор,ОбработкаНачалаЗагрузки);
	 #Иначе
	 
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	Диалог.Заголовок = "Выбор файла";
	Диалог.ИндексФильтра = 0;
	Диалог.ПредварительныйПросмотр = Ложь;
	Диалог.ПроверятьСуществованиеФайла = Истина;
	Диалог.МножественныйВыбор = Ложь; 
	Диалог.ПолноеИмяФайла = Файл;
	
	Если Диалог.Выбрать() Тогда
		Файл = Диалог.ПолноеИмяФайла;
        ВыбФайл = Новый Файл(Файл);
		Если ВыбФайл.Существует() Тогда 
			Если ПустаяСтрока(ОписаниеДокумента) тогда 
				ОписаниеДокумента = ВыбФайл.Имя;
			КонецЕсли;	
			КонецЕсли;	
		КонецЕсли;
	#КонецЕсли 	
	
КонецПроцедуры



 &НаКлиенте
Функция ПолучитьСтруктуруИмениФайла(ИмяФайла)
	Сч = СтрДлина(ИмяФайла);
	ПозицияТочки = 0;
	Пока Сч > 0 Цикл
		ТекущийСимвол = Сред(ИмяФайла, Сч, 1);
		Если ТекущийСимвол = "\" или ТекущийСимвол = "/" Тогда
			Прервать
		ИначеЕсли ПозицияТочки = 0 И ТекущийСимвол = "." Тогда
			ПозицияТочки = Сч;
		КонецЕсли;
		Сч = Сч - 1;
	КонецЦикла;
	
	Путь = Лев(ИмяФайла, Сч);	
	ИмяСРасширением = Сред(ИмяФайла, Сч + 1);
	ИмяБезРасширения = ?(ПозицияТочки = 0, ИмяСРасширением, Лев(ИмяСРасширением, ПозицияТочки - Сч - 1));
	Расширение = ?(ПозицияТочки = 0, "", Сред(ИмяФайла, ПозицияТочки + 1));
	
	СтруктураИмениФайла = Новый Структура();
	СтруктураИмениФайла.Вставить("Путь", Путь);
	СтруктураИмениФайла.Вставить("ИмяСРасширением", ИмяСРасширением);
	СтруктураИмениФайла.Вставить("ИмяБезРасширения", ИмяБезРасширения);
	СтруктураИмениФайла.Вставить("Расширение", Расширение);
	
	Возврат СтруктураИмениФайла
	
КонецФункции

&НаСервере
Функция ПрикрепитьФайлКОбъектуНаСервере(АдресВХранилище, СтруктураИмениФайла, СсылкаНаОбъект)
	ПараметрыФайла = Новый Структура();
	ПараметрыФайла.Вставить("Автор", ПараметрыСеанса.ТекущийПользователь);
	ПараметрыФайла.Вставить("ВладелецФайлов", СсылкаНаОбъект);
	ПараметрыФайла.Вставить("ИмяБезРасширения", СтруктураИмениФайла.ИмяБезРасширения);
	ПараметрыФайла.Вставить("РасширениеБезТочки", СтруктураИмениФайла.Расширение);
	ПараметрыФайла.Вставить("ВремяИзмененияУниверсальное");
	ПараметрыФайла.Вставить("ГруппаФайлов");
	ПараметрыФайла.Вставить("ТипЗагруженногоДокумента",ТипЗагруженногоДокумента); 
	ПараметрыФайла.Вставить("ВидЗагруженногоДокумента",ВидЗагруженногоДокумента);
	Возврат РаботаСФайлами.ДобавитьФайл(ПараметрыФайла, АдресВХранилище);
КонецФункции

&НаКлиенте
Процедура Команда1(Команда)   
	
	ДиалогВыбора = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие); 
	ДиалогВыбора.Заголовок = "Собственный заголовок диалога загрузки файла";
	ОбработкаОкончанияЗагрузки = Новый ОписаниеОповещения("Обработчик_Завершения_Загрузки", ЭтотОбъект, ДиалогВыбора); 
	НачатьПомещениеФайла(ОбработкаОкончанияЗагрузки, , ДиалогВыбора, Истина, УникальныйИдентификатор);
КонецПроцедуры


&НаКлиенте
Процедура Обработчик_Завершения_Загрузки(Результат, ДополнительныеПараметры,Параметр3, Параметр4)Экспорт 
	Если Результат тогда  
		Файл = Параметр3; 
		АдресФайла =ДополнительныеПараметры; 
		//ВыбФайл = Новый Файл(Файл);
		//Если ВыбФайл.Существует() Тогда 
		//	Если ПустаяСтрока(ОписаниеДокумента) тогда 
				ОписаниеДокумента = Параметр3;
		//	КонецЕсли;	
		//КонецЕсли;
		//
	КонецЕсли;	
//	Сообщить(Результат);	
	
КонецПроцедуры 

  &НаКлиенте
 Процедура Обработчик_Начала_Загрузки(ПомещаемыйФайл, ОтказОтПомещенияФайла, ДополнительныеПараметры) Экспорт
	ОтказОтПомещенияФайла = Ложь;
	Если ПомещаемыйФайл.Размер() > 5 * 1024 * 1024 Тогда 
		//ПоказатьПредупреждение( , "Размер файла " + "(" + ПомещаемыйФайл.Размер() + ") " + ПомещаемыйФайл.Имя + " (" + ПомещаемыйФайл.ИдентификаторФайла + ") превышает 5MB. Загрузка остановлена.");
		ОтказОтПомещенияФайла = Истина;
	КонецЕсли;
КонецПроцедуры


//  &НаКлиенте 
//  Процедура ВалидацияПередОтправкойФайла(Команда) 
//  	ОбработкаОкончанияЗагрузки = Новый ОписаниеОповещения("Обработчик_Завершения_Загрузки", ЭтотОбъект); 
//    ОбработкаНачалаЗагрузки = Новый ОписаниеОповещения("Обработчик_Начала_Загрузки", ЭтотОбъект); 
//    НачатьПомещениеФайла(ОбработкаОкончанияЗагрузки, , , Истина, УникальныйИдентификатор, ОбработкаНачалаЗагрузки);
//КонецПроцедуры 
//&НаКлиенте 
//Процедура Обработчик_Начала_Загрузки(ПомещаемыйФайл, ОтказОтПомещенияФайла, ДополнительныеПараметры) Экспорт
//	ОтказОтПомещенияФайла = Ложь; Если ПомещаемыйФайл.Размер() > 5 * 1024 * 1024 Тогда ПоказатьПредупреждение( , "Размер файла " + "(" + ПомещаемыйФайл.Размер() + ") " + ПомещаемыйФайл.Имя + " (" + ПомещаемыйФайл.ИдентификаторФайла + ") превышает 5MB. Загрузка остановлена."); ОтказОтПомещенияФайла = Истина;
//	КонецЕсли;
//КонецПроцедуры