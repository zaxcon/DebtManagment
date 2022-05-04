
Процедура ОбработкаПроведения(Отказ, Режим)
	//{{__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!

	// регистр ОстаткиДолгов Расход
	Движения.ОстаткиДолгов.Записывать = Истина;
	Для Каждого ТекСтрокаДолги Из Долги Цикл
		Движение = Движения.ОстаткиДолгов.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
		Движение.Период = Дата;
		Движение.Долг = ТекСтрокаДолги.Долг;
		Движение.Сумма = ТекСтрокаДолги.СуммаПлатежа;
		Движение.ДатаПлатежа = ТекСтрокаДолги.ДатаПлатежа;
		Движение.Плательщик = ТекСтрокаДолги.Плательщик;
	КонецЦикла;

	//}}__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
КонецПроцедуры
