# Specyfikacja realizowanej aplikacji

## Tytuł aplikacji

Symulator planowania wydatków i budżetu

## Autor/Autorzy

- Jan Godlewski

## Wizja aplikacji

Do aplikacji wprowadzamy planowane przychody i wydatki w różnych walutach. Są one zapisywane w bazie SQLite z użyciem Core Data i dzięki temu dane nie przepadają po zamknięciu aplikacji. Z wykorzystaniem bibliotek tworzone są wykresy ze statystykami. Aplikacja pobiera z darmowego API aktualne kursy walut i umożliwia ich konwertowanie.

## Wymagania

### Wymagania funkcjonalne

1. Wprowadzanie za pomocą GUI przychodów i wydatków
2. Zapisywanie i wczytywanie danych z użyciem bazy danych.
3. Wizualizowanie danych za pomocą wykresów.

### Wymagania pozafunkcjonalne

1. Aplikacja uruchamia się na iPhone’ach.
2. Prawidłowe przetwarzanie danych. Dane są poprawnie zapisywane, wczytywane i wizualizowane bez zniekształceń.
3. Akceptowalny czas pracy aplikacji. Poszczególne kroki nie powinny się wykonywać dłużej niż 3 sekundy.
4. Niezawodność. Aplikacja nie ulega awarii w trakcie pracy, a przyciski działają.
5. Bezpłatne API.

## Wykorzystane narzędzia

### Framework(i) iOS SDK

<Wykaz wykorzystanych frameworków wchodzących w skład iOS SDK, takich jak np. Core ML – co najmniej 1 szt.>
1. Core Data do obsługi bazy danych
2. User Notifications do wysyłania powiadomień

### Frameworki/biblioteki zewnętrzne

1. SwiftUICharts, https://github.com/AppPear/ChartView, tworzenie wykresów (Uwaga: Istnieje kilka bibliotek o tej samej nazwie modułu)
2. Alamofire, https://github.com/Alamofire/Alamofire, Pobieranie kursów walut

## Dane

Core Data zapisuje w bazie danych wprowadzone wcześniej o wydatkach i przychodach, żeby nie przepadały po zamknięciu aplikacji.

## Repozytorium

https://github.com/januszgo/swift-budget-planner

# Projekt i architektura aplikacji

## Tytuł aplikacji

Symulator planowania wydatków i budżetu

## Autor/Autorzy

- Jan Godlewski


## Wykaz i kompetencje modułów

- Views - zawiera widoki i towarzyszące im funkcje
- DataModel - zawiera model danych obsługujących CoreData 

## Projekt interfejsu użytkownika

### Widok 1 – ContentView

#### Zawiera główne menu programu

#### Lista z zawartością bazy danych oraz przyciski służące do jej modyfikowania (dodawanie, edycja i usuwanie). Wyświetla sumaryczny bilans wydatków. Automatycznie pokazywane są wartości po przekonwertowaniu na euro. Wysyła zapytania o zgodę na wysłanie powiadomień. Po uzyskaniu jej rozsyła powiadomienia o aktualnych kursach walut.

#### Zawiera linki do wszystkch pozostałych widoków

### Widok 2 – AddIncomeView

#### Służy do tworzenia nowych rekordów na liście

#### Pole z nazwą i wartością transakcji finansowej. Jeśli zostawimy pola puste, to automatycznie przypisywane są wartości domyślne.

#### Zapisanie rekordu powoduje powrót do ekranu ContentView

### Widok 3 – AddOutcomeView

#### To samo co wyżej z tym, że zamiast przychodów tworzone są wydatki. Wprowadzona wartość liczbowa jest na końcu mnożona razy -1, ponieważ saldo jest wypadkową przychodów i wydatków

### Widok 4 – EditIncomeView

#### To samo co wyżej z tym, że służy do edycji rekordów z bazy. Jako domyślne wartości do formularza wprowadzane są wartości rekordu z bazy.

### Widok 5 – PlotView

#### Zawiera wykres wizualizują

#### Wykres kołowy generowany przez zewnętrzny moduł SwiftUICharts

#### Zawiera link umożliwiający powrót do ekranu Content View

### Widok 6 – PlotView1

#### To samo co wyżej z tym, że pokazuje strukturę wydatków.


## Scenariusze użycia

### Scenariusz 1

1. Sprawdzenie zawartości tabeli z bazy danych oraz bilansu
2. Sprawdzenie aktualnego kursu euro
3. Dodanie nowego rekordu
4. Modyfikacja istniejącego rekordu
5. Usunięcie rekordu z tabeli
6. Przeglądanie wykresów stworzonych w oparciu o bazę danych

### Scenariusz 2
1. Wyrażenie zgody na otrzymywanie powiadomień
2. Otrzymywanie cyklicznych powiadomień o akualnych kursach walut

# Projekt i architektura aplikacji

## Tytuł aplikacji

Symulator planowania wydatków i budżetu

## Autor/Autorzy

- Jan Godlewski


## Wybrane rozwiązanie

 - CoreData obsługa bazy danych
 - Alamofire pobieranie danych z API z kursami walut

## Sposób połączenia i wykonywania zapytań

 - UserNotifications - pytanie o zgodę i wysyłanie powiadomień o aktualnych kursach walut
 - SwiftUICharts - wizualizowanie danych na wykresach

## Model danych

 - id UUID
 - name String
 - value Double
