
Процедура ОбработкаПроведения(Отказ, Режим)
	//{{__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!

	// регистр ОбещанныеПлатежи
	Движения.ОбещанныеПлатежи.Записывать = Истина;
	Движение = Движения.ОбещанныеПлатежи.Добавить();
	Движение.Период = Дата;
	Движение.Плательщик = Плательщик;
	Движение.Долг = Долг;
	Движение.ДатаОбещанногоПлатежа = ДатаОбещанногоПлатежа;
	Движение.СтатусОбещанногоПлатежа = СтатусОбещанногоПлатежа;
	Движение.СуммаПлатежа = СуммаПлатежа;
	Движение.Комментарий = Комментарий;

	//}}__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
КонецПроцедуры
