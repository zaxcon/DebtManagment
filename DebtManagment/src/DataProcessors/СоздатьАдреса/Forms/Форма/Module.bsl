
&НаСервере
Процедура СоздатьРегионыНаСервере()
	// Вставить содержимое обработчика.
	//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	АдресныеОбъекты.Идентификатор КАК Идентификатор,
		|	АдресныеОбъекты.КодСубъектаРФ КАК КодСубъектаРФ,
		|	АдресныеОбъекты.РодительскийИдентификатор КАК РодительскийИдентификатор,
		|	АдресныеОбъекты.МуниципальныйРодительскийИдентификатор КАК МуниципальныйРодительскийИдентификатор,
		|	АдресныеОбъекты.Наименование КАК Наименование,
		|	АдресныеОбъекты.Сокращение КАК Сокращение,
		|	АдресныеОбъекты.КодКЛАДР КАК КодКЛАДР,
		|	АдресныеОбъекты.ДополнительныеАдресныеСведения КАК ДополнительныеАдресныеСведения,
		|	АдресныеОбъекты.Уровень КАК Уровень
		|ИЗ
		|	РегистрСведений.АдресныеОбъекты КАК АдресныеОбъекты
		|ГДЕ
		|	АдресныеОбъекты.Уровень = 1";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		// Вставить обработку выборки ВыборкаДетальныеЗаписи 
		СпрАдреса =Справочники.Адреса.СоздатьЭлемент();
		ЗаполнитьЗначенияСвойств(СпрАдреса,ВыборкаДетальныеЗаписи);
		СпрАдреса.Записать();
	КонецЦикла;
	
	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьРегионы(Команда)
	СоздатьРегионыНаСервере();
КонецПроцедуры

&НаСервере
Процедура СоздатьПодчиненныеОбъектыНаСервере()
	// Вставить содержимое обработчика. 
	   	//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	Адреса.Ссылка КАК Ссылка,
		|	Адреса.Идентификатор КАК Идентификатор
		|ИЗ
		|	Справочник.Адреса КАК Адреса";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		// Вставить обработку выборки ВыборкаДетальныеЗаписи
		СоздатьАдреса(ВыборкаДетальныеЗаписи.Ссылка,ВыборкаДетальныеЗаписи.Идентификатор);
		
	КонецЦикла;
	
	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА

КонецПроцедуры                                            

&НаСервере
Функция СоздатьАдреса(Родитель,РодительскийИдентификатор)
		//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	АдресныеОбъекты.Идентификатор КАК Идентификатор,
		|	АдресныеОбъекты.КодСубъектаРФ КАК КодСубъектаРФ,
		|	АдресныеОбъекты.РодительскийИдентификатор КАК РодительскийИдентификатор,
		|	АдресныеОбъекты.МуниципальныйРодительскийИдентификатор КАК МуниципальныйРодительскийИдентификатор,
		|	АдресныеОбъекты.Наименование КАК Наименование,
		|	АдресныеОбъекты.Сокращение КАК Сокращение,
		|	АдресныеОбъекты.КодКЛАДР КАК КодКЛАДР,
		|	АдресныеОбъекты.ДополнительныеАдресныеСведения КАК ДополнительныеАдресныеСведения,
		|	АдресныеОбъекты.Уровень КАК Уровень
		|ИЗ
		|	РегистрСведений.АдресныеОбъекты КАК АдресныеОбъекты
		|ГДЕ
		|	АдресныеОбъекты.РодительскийИдентификатор = &РодительскийИдентификатор";
	
	Запрос.УстановитьПараметр("РодительскийИдентификатор", РодительскийИдентификатор);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		// Вставить обработку выборки ВыборкаДетальныеЗаписи
		НОвыйАдрес = Справочники.Адреса.СоздатьЭлемент();
		НОвыйАдрес.Родитель=Родитель;
		ЗаполнитьЗначенияСвойств(НОвыйАдрес,ВыборкаДетальныеЗаписи);
		НОвыйАдрес.Записать(); 
		СоздатьАдреса(НОвыйАдрес.Ссылка,НОвыйАдрес.Идентификатор);
	КонецЦикла;
	Возврат Истина;
	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА

КонецФункции	

&НаКлиенте
Процедура СоздатьПодчиненныеОбъекты(Команда)
	СоздатьПодчиненныеОбъектыНаСервере();
КонецПроцедуры

&НаСервере
Процедура СоздатьДомаЗданияСтроенияНаСервере()
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура СоздатьДомаЗданияСтроения(Команда)
	СоздатьДомаЗданияСтроенияНаСервере();
КонецПроцедуры
