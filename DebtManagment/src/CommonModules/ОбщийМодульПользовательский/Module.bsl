Функция СтрокаТаблицыЗначенийВСтруктуру(СтрокаТаблицыЗначений) Экспорт
	
	Структура = Новый Структура;
	Для каждого Колонка Из СтрокаТаблицыЗначений.Владелец().Колонки Цикл
		Структура.Вставить(Колонка.Имя, СтрокаТаблицыЗначений[Колонка.Имя]);
	КонецЦикла;
	      	Возврат Структура;
	
		КонецФункции  
		
	Функция ЕстьРеквизитИлиСвойствоОбъекта(Объект, ИмяРеквизита) Экспорт
    
    КлючУникальности   = Новый УникальныйИдентификатор;
    СтруктураРеквизита = Новый Структура(ИмяРеквизита, КлючУникальности);
    ЗаполнитьЗначенияСвойств(СтруктураРеквизита, Объект);
    
    Возврат СтруктураРеквизита[ИмяРеквизита] <> КлючУникальности;
    
КонецФункции