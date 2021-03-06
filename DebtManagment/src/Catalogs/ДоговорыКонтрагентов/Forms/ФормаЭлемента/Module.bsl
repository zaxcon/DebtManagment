
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	//Вставить содержимое обработчика   

     ПеречитатьСписокНаСервере();


КонецПроцедуры  

// <Описание процедуры>
//
// Параметры:
//  <Параметр1>  - <Тип.Вид> - <описание параметра>
//                 <продолжение описания параметра>
//  <Параметр2>  - <Тип.Вид> - <описание параметра>
//                 <продолжение описания параметра>
// 
&НаСервере

Процедура ПеречитатьСписокНаСервере()  
	
	Если ЗначениеЗаполнено(Объект.Ссылка) тогда
		Список.Параметры.УстановитьЗначениеПараметра("ВладелецФайлов", Объект.Ссылка);
	иначе
		Список.Параметры.УстановитьЗначениеПараметра("ВладелецФайлов",Неопределено);
	КонецЕсли;
	
	ДатаУниверсальная = ТекущаяДатаСеанса();
	Список.Параметры.УстановитьЗначениеПараметра("СекундДоМестногоВремени",
	МестноеВремя(ДатаУниверсальная, ЧасовойПоясСеанса()) - ДатаУниверсальная);
	
	ПустыеПользователи = Новый Массив;
	ПустыеПользователи.Добавить(Неопределено);
	ПустыеПользователи.Добавить(Справочники.Пользователи.ПустаяСсылка());
	ПустыеПользователи.Добавить(Справочники.ВнешниеПользователи.ПустаяСсылка());
	ПустыеПользователи.Добавить(Справочники.УчетныеЗаписиСинхронизацииФайлов.ПустаяСсылка());
	
	
	Список.Параметры.УстановитьЗначениеПараметра("ТекущийПользователь", Пользователи.АвторизованныйПользователь());
	Список.Параметры.УстановитьЗначениеПараметра("ПустыеПользователи",  ПустыеПользователи);
	
	Список.Параметры.УстановитьЗначениеПараметра("СписокВидыЗагружаемыхДокументов",  СписокТекущиеВидыЗагружаемыхДокументов());   
	

КонецПроцедуры // ПеречитатьСписокНаСервере()


&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
		Если Элементы.Список.РежимВыбора Тогда
		Возврат;
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	
	Если Элементы.Список.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ТекущиеДанные.ЭтоГруппа Тогда
		ПоказатьЗначение(, ВыбраннаяСтрока);
		Возврат;
	КонецЕсли;
	
	КакОткрывать = РаботаСФайламиСлужебныйКлиент.ПерсональныеНастройкиРаботыСФайлами().ДействиеПоДвойномуЩелчкуМыши;
	
	Если КакОткрывать = "ОткрыватьКарточку" Тогда
		ПоказатьЗначение(, ВыбраннаяСтрока);
		Возврат;
	КонецЕсли;
	
	ДанныеФайла = РаботаСФайламиСлужебныйВызовСервера.ДанныеФайлаДляОткрытия(ВыбраннаяСтрока,
		Неопределено, УникальныйИдентификатор, Неопределено, ПредыдущийАдресФайла);
	
	ПараметрыОбработчика = Новый Структура;
	ПараметрыОбработчика.Вставить("ДанныеФайла", ДанныеФайла);
	Обработчик = Новый ОписаниеОповещения("СписокВыборПослеВыбораРежимаРедактирования", ЭтотОбъект, ПараметрыОбработчика);
	
	РаботаСФайламиСлужебныйКлиент.ВыбратьРежимИРедактироватьФайл(Обработчик, ДанныеФайла, Не ДанныеФайла.Служебный);
	

КонецПроцедуры
&НаКлиенте
Процедура ОткрытьФайлПослеПодтверждения(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат <> Неопределено И Результат = "Продолжить" Тогда
		
		ТекущиеДанные = ДополнительныеПараметры.ТекущиеДанные; // см. ОбработкаОбъект.ПоискИУдалениеДублей.ГруппыДублей
		
		ФайлРедактируется = ТекущиеДанные.ФайлРедактируется И ТекущиеДанные.ФайлРедактируетТекущийПользователь;
		
		ДанныеФайла = РаботаСФайламиСлужебныйВызовСервера.ДанныеФайлаДляОткрытия(ТекущиеДанные.Ссылка, Неопределено, УникальныйИдентификатор);
		Если ДанныеФайла.Зашифрован Тогда
			// Файл может быть изменен в другом сеансе.
			ОповеститьОбИзменении(ТекущиеДанные.Ссылка);
			Возврат;
		КонецЕсли;
		
		РаботаСФайламиКлиент.ОткрытьФайл(ДанныеФайла, ФайлРедактируется);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокВыборПослеВыбораРежимаРедактирования(Результат, ПараметрыВыполнения) Экспорт
	
	Если Результат = "Редактировать" Тогда
		Обработчик = Новый ОписаниеОповещения("СписокВыборПослеРедактированияФайла", ЭтотОбъект, ПараметрыВыполнения);
		РаботаСФайламиСлужебныйКлиент.РедактироватьФайл(Обработчик, ПараметрыВыполнения.ДанныеФайла);
	ИначеЕсли Результат = "Открыть" Тогда
		РаботаСФайламиКлиент.ОткрытьФайл(ПараметрыВыполнения.ДанныеФайла, Ложь);
	КонецЕсли;
	
КонецПроцедуры

// Параметры:
//   Результат - Неопределено
//   ПараметрыВыполнения - Структура:
//     * ДанныеФайла - см. РаботаСФайлами.ДанныеФайла
//
&НаКлиенте
Процедура СписокВыборПослеРедактированияФайла(Результат, ПараметрыВыполнения) Экспорт
	
	ОповеститьОбИзменении(ПараметрыВыполнения.ДанныеФайла.Ссылка);
	
	УстановитьДоступностьФайловыхКоманд();
	
КонецПроцедуры    

&НаКлиенте
Процедура УстановитьДоступностьФайловыхКоманд(Результат = Неопределено, ПараметрыВыполнения = Неопределено) Экспорт
	
	//ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	//
	//ИменаКоманд = Новый Массив;
	//Если ТекущиеДанные = Неопределено
	//	И Не ФайлыРедактируютсяВОблачномСервисе Тогда
	//	
	//	ИменаКоманд.Добавить("Добавить");
	//	ИменаКоманд.Добавить("ДобавитьФайлСоСканера");
	//	ИменаКоманд.Добавить("ДобавитьФайлПоШаблону");
	//	
	//ИначеЕсли ТипЗнч(Элементы.Список.ТекущаяСтрока) = ТипСправочникаСФайлами Тогда
	//	
	//	ВозможностьОсвободитьФайл = РаботаСФайламиСлужебныйКлиент.ВозможностьОсвободитьФайл(
	//		ТекущиеДанные.Ссылка,
	//		ТекущиеДанные.ФайлРедактируетТекущийПользователь,
	//		ТекущиеДанные.РедактируетПользователь);
	//		
	//	ИменаКоманд = ПолучитьДоступныеКоманды(ТекущиеДанные, ФайлыРедактируютсяВОблачномСервисе,
	//		ВозможностьОсвободитьФайл, ПользователиКлиент.АвторизованныйПользователь());
	//		
	//КонецЕсли;
	//
	//Если ТекущиеДанные <> Неопределено Тогда
	//	Элементы.ПечатьСоШтампом.Видимость = ЕстьЭлектроннаяПодпись
	//		И (ТекущиеДанные.Расширение = "mxl")
	//		И ТекущиеДанные.ПодписанЭП;
	//КонецЕсли;
	//
	//Для каждого ИмяЭлементаФормы Из ИменаЭлементовКнопокФормы Цикл
	//	
	//	ЭлементФормы = Элементы.Найти(ИмяЭлементаФормы);
	//	
	//	Если ИменаКоманд.Найти(ЭлементФормы.ИмяКоманды) <> Неопределено
	//		Или ИменаКоманд.Найти(ЭлементФормы.Имя) <> Неопределено Тогда
	//		
	//		Если НЕ ЭлементФормы.Доступность Тогда
	//			ЭлементФормы.Доступность = Истина;
	//		КонецЕсли;
	//		
	//	ИначеЕсли ЭлементФормы.Доступность Тогда
	//		ЭлементФормы.Доступность = Ложь;
	//	КонецЕсли;
	//КонецЦикла;
	//
	//ПодключитьОбработчикОжидания("ОбновитьПредпросмотр", 0.1, Истина);

КонецПроцедуры

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
		ОбновитьДоступностьФайловыхКоманд();
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	//Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПодключаемыеКоманды") Тогда
	//	МодульПодключаемыеКомандыКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ПодключаемыеКомандыКлиент");
	//	МодульПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	//КонецЕсли;
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды


КонецПроцедуры
 &НаКлиенте
Процедура ОбновитьДоступностьФайловыхКоманд()
	
	УстановитьДоступностьФайловыхКоманд();
	
КонецПроцедуры


&НаКлиенте
Процедура СписокПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
		Отказ = Истина;
	Если Копирование Тогда
		
		Если НЕ ФайловыеКомандыДоступны() Тогда
			Возврат;
		КонецЕсли;
		
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы = Новый Структура("ЗначениеКопирования", Элемент.ТекущиеДанные.Ссылка);
		
		Если Элемент.ТекущиеДанные.ЭтоГруппа Тогда
			ОткрытьФорму("Обработка.РаботаСФайлами.Форма.ГруппаФайлов", ПараметрыФормы);
		Иначе
			РаботаСФайламиКлиент.СкопироватьФайл(Объект.Ссылка, Элемент.ТекущиеДанные.Ссылка, ПараметрыФормы);
		КонецЕсли;
		
	Иначе
		
		ДобавитьФайл();
		
	КонецЕсли;

КонецПроцедуры 

&НаКлиенте
Процедура ВопросОНеобходимостиЗаписиПослеЗавершения(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.ОК Тогда
		Возврат;
	КонецЕсли;
	
КонецПроцедуры


&НаКлиенте
Функция ФайловыеКомандыДоступны()
	
	Возврат РаботаСФайламиСлужебныйКлиент.ФайловыеКомандыДоступны(Элементы);
	
КонецФункции
&НаКлиенте
Процедура ДобавитьФайл()
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	ГруппаФайлов = Неопределено;
	Если ТекущиеДанные <> Неопределено И ТекущиеДанные.ЭтоГруппа И ТекущиеДанные.ВладелецФайла = Объект.Ссылка Тогда
		ГруппаФайлов = ТекущиеДанные.Ссылка;
	КонецЕсли;
	Если ЭтоВладелецЭлементовСправочникаФайлы Тогда
		РаботаСФайламиСлужебныйКлиент.ДобавитьФайлИзФайловойСистемы(Объект.Ссылка, ЭтотОбъект);
	Иначе
		РаботаСФайламиКлиент.ДобавитьФайлы(Объект.Ссылка, УникальныйИдентификатор, , ГруппаФайлов);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура Добавить(Команда)
	// Вставить содержимое обработчика.  
	// Вставить содержимое обработчика.     

	Если Не ЗначениеЗаполнено(Объект.Ссылка) тогда
		ОбработчикОповещенияОЗакрытии = Новый ОписаниеОповещения("ВопросОНеобходимостиЗаписиПослеЗавершения", ЭтотОбъект);
		ПоказатьВопрос(ОбработчикОповещенияОЗакрытии,
		НСтр("ru = 'Данные еще не записаны. 
		|Переход к ""Присоединенные файлы"" возможен только после записи данных.'"),
		РежимДиалогаВопрос.ОК);
		
	иначе	
		
		Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
			Шаблон = НСтр("ru = 'Не задано значение параметра %1 в %2.'");
			ВызватьИсключение СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Шаблон, "ВладелецФайла", 
			"РаботаСФайламиКлиент.ДобавитьФайлы");
		КонецЕсли;
		
		ПараметрыПередачи = Новый Структура;
		ПараметрыПередачи.Вставить("ВладелецФайла",        Объект.Ссылка);
		ПараметрыПередачи.Вставить("ИдентификаторФормы",   УникальныйИдентификатор);
		ПараметрыПередачи.Вставить("Фильтр",               Неопределено);
		ПараметрыПередачи.Вставить("ГруппаФайлов",         Неопределено);
		ПараметрыПередачи.Вставить("ОбработчикРезультата", Неопределено);
		
		Если (Элементы.ГруппаСтраницы.ТекущаяСтраница.Имя = "ГруппаСписокДоговор") тогда
			ВидЗагруженногоДокумента = ПредопределенноеЗначение("Перечисление.ВидыЗагруженныхДокументов.Договор");	
		иначе
			ВидЗагруженногоДокумента = ПредопределенноеЗначение("Перечисление.ВидыЗагруженныхДокументов.ДополнительноеСоглашение");
		КонецЕсли;	
		ПараметрыПередачи.Вставить("ВидЗагруженногоДокумента", ВидЗагруженногоДокумента);
	
		Оповещение = Новый ОписаниеОповещения("ПослеЗагрузкиДоговоров", ЭтотОбъект);
		ОткрытьФорму("Обработка.РаботаСФайлами.Форма.ФормаЗагрузкиФайловДоговоров",ПараметрыПередачи,ЭтотОбъект,,,,Оповещение,РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	КонецЕсли;

КонецПроцедуры 


&НаСервере
Функция СписокТекущиеВидыЗагружаемыхДокументов()
         СписокВидыЗагруженныхДокументов = Новый СписокЗначений;
		 
	 	Если (Элементы.ГруппаСтраницы.ТекущаяСтраница.Имя = "ГруппаСписокДоговор") тогда
			ВидЗагруженногоДокумента = ПредопределенноеЗначение("Перечисление.ВидыЗагруженныхДокументов.Договор");	
			СписокВидыЗагруженныхДокументов.Добавить( ПредопределенноеЗначение("Перечисление.ВидыЗагруженныхДокументов.ПустаяСсылка"));	
		иначе
			ВидЗагруженногоДокумента = ПредопределенноеЗначение("Перечисление.ВидыЗагруженныхДокументов.ДополнительноеСоглашение");
		КонецЕсли;
        СписокВидыЗагруженныхДокументов.Добавить(ВидЗагруженногоДокумента);
        Возврат СписокВидыЗагруженныхДокументов;
КонецФункции // СписокТекущиеВидыЗагружаемыхДокументов()


&НаКлиенте

 Процедура ПослеЗагрузкиДоговоров(Результат, ДополнительныеПараметры)Экспорт  
	 Элементы.Список.Обновить();
	 Элементы.СписокДС.Обновить();
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	ПеречитатьСписокНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ГруппаСтраницыПриСменеСтраницы(Элемент, ТекущаяСтраница)
	// Вставить содержимое обработчика.  
	ПеречитатьСписокНаСервере() ;
КонецПроцедуры

&НаКлиенте
Процедура СтатусДействияПриИзменении(Элемент)
	// Вставить содержимое обработчика.  
	Если Объект.СтатусДействия<>СтарыйСтатус тогда
	//Сообщить(Объект.СтатусДействия);              
	ОповещениеВопрос = Новый ОписаниеОповещения("ПослеОтветаСменаСтатуса",ЭтотОбъект);
	ПоказатьВопрос(ОповещениеВопрос,"Сменить статус подчиненных объектов",РежимДиалогаВопрос.ДаНет);
	
	КонецЕсли;
КонецПроцедуры 

&НаКлиенте
Процедура ПослеОтветаСменаСтатуса(Результат, Параметры) Экспорт // здесь, думаю, комментировать нечего
	
	Если Результат = КодВозвратаДиалога.Да Тогда
		//Сообщить("Открываем смену статуса");
		СоздатьДокументСменыСтатуса();
	Иначе
		Объект.СтатусДействия = СтарыйСтатус;
	КонецЕсли;
КонецПроцедуры
	
&НаКлиенте
Процедура СтатусДействияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
	СтарыйСтатус=Объект.СтатусДействия;
КонецПроцедуры

&НаКлиенте
Процедура	СоздатьДокументСменыСтатуса()
	ПараметрыЗаполнения=Новый Структура;
	ПараметрыЗаполнения.Вставить("Дата",ТекущаяДата());
	ПараметрыЗаполнения.Вставить("ДоговорКонтрагента",Объект.Ссылка);
	ПараметрыЗаполнения.Вставить("НовыйСтатусРаботыСДолгом",Объект.СтатусДействия);
	ПараметрыЗаполнения.Вставить("ЗаполнитьПриОткрытии",Истина);
	ОткрытьФорму("Документ.СменаСтатусаРаботыСДолгами.Форма.ФормаДокумента",ПараметрыЗаполнения,ЭтаФорма,,,,,РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
КонецПроцедуры	
