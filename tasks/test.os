#Использовать ".."

Функция ПрогнатьТесты()

	Тестер = Новый Тестер;

	ПутьКТестам = "tests";
	ПутьКОтчетуJUnit = ".";

	ПутьКОтчетуJUnit = Новый Файл(ПутьКОтчетуJUnit).ПолноеИмя;

	РезультатТестирования = Тестер.ТестироватьКаталог(
		Новый Файл(ПутьКТестам),
		Новый Файл(ПутьКОтчетуJUnit)
	);

	Успешно = РезультатТестирования = 0;

	Возврат Успешно;
КонецФункции // ПрогнатьТесты()

Функция ПрогнатьФичи(Знач ПутьФич = "features", Знач ПутьОтчетаJUnit = "./bdd-log.xml")

	КаталогФич = ОбъединитьПути(".", ПутьФич);

	Файл_КаталогФич = Новый Файл(КаталогФич);

	ИсполнительБДД = Новый ИсполнительБДД;
	РезультатыВыполнения = ИсполнительБДД.ВыполнитьФичу(Файл_КаталогФич, Файл_КаталогФич);
	ИтоговыйРезультатВыполнения = ИсполнительБДД.ПолучитьИтоговыйСтатусВыполнения(РезультатыВыполнения);

	СтатусВыполнения = ИсполнительБДД.ВозможныеСтатусыВыполнения().НеВыполнялся;
	Если РезультатыВыполнения.Строки.Количество() > 0 Тогда

		СтатусВыполнения = ИсполнительБДД.ПолучитьИтоговыйСтатусВыполнения(РезультатыВыполнения);

		ИсполнительБДД.ВывестиИтоговыеРезультатыВыполнения(РезультатыВыполнения, Файл_КаталогФич.ЭтоКаталог());
	КонецЕсли;

	ГенераторОтчетаJUnit = Новый ГенераторОтчетаJUnit;
	ГенераторОтчетаJUnit.Сформировать(РезультатыВыполнения, СтатусВыполнения, ПутьОтчетаJUnit);

	Сообщить(СтрШаблон("Результат прогона фич <%1>. Путь %2
	|", ИтоговыйРезультатВыполнения, ПутьФич));

	Возврат ИтоговыйРезультатВыполнения <> ИсполнительБДД.ВозможныеСтатусыВыполнения().Сломался;
КонецФункции // ПрогнатьФичи()

// основной код

ТекКаталог = ТекущийКаталог();

Попытка
	ТестыПрошли = ПрогнатьТесты();
Исключение
	ТестыПрошли = Ложь;
	Сообщить(СтрШаблон("Тесты через 1testrunner выполнены неудачно
	|%1
	|%2", ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()), ОписаниеОшибки()));
КонецПопытки;

УстановитьТекущийКаталог(ТекКаталог);

// Попытка
// 	ФичиПрошли = ПрогнатьФичи("features/core");
// Исключение
// 	ФичиПрошли = Ложь;
// 	Сообщить(СтрШаблон("Тесты поведения через 1bdd выполнены неудачно
// 	|%1", ПодробноеПредставлениеОшибки(ИнформацияОбОшибке())));
// КонецПопытки;

// Попытка
// 	БиблиотечныеФичиПрошли = ПрогнатьФичи("features/lib", "bdd-lib.xml");
// Исключение
// 	БиблиотечныеФичиПрошли = Ложь;
// 	Сообщить(СтрШаблон("Тесты поведения через 1bdd выполнены неудачно
// 	|%1", ПодробноеПредставлениеОшибки(ИнформацияОбОшибке())));
// КонецПопытки;

Сообщить(СтрШаблон("Результат прогона тестов <%1>
|", ТестыПрошли));
// Сообщить(СтрШаблон("Результат прогона основных фич <%1>
// |", ФичиПрошли));
// Сообщить(СтрШаблон("Результат прогона библиотечных фич <%1>
// |", БиблиотечныеФичиПрошли));

// Если НЕ ТестыПрошли Или НЕ ФичиПрошли Или НЕ БиблиотечныеФичиПрошли Тогда
Если НЕ ТестыПрошли Тогда
	ВызватьИсключение "Тестирование завершилось неудачно!";
КонецЕсли;
