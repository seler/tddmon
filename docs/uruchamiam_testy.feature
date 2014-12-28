# language: pl

Właściwość: Monitorowanie testów
    Jako
        użytkownik
    Chcę
        widzieć aktualny stan wykonania testów
    Aby
        kontrolować pracę zgodnie z TDD


    Scenariusz: błędny test
        Zakładając, że monitorowane są pliki "file1.py,file2.py,test_file.py"
        I plik "test_file.py" zawiera <tests_num> testów
        I <failures_num> testów skutkuje niepowodzeniem
        I <errors_num> testów skutkuje błędem
        I <coverage> procent kodu pokryte jest testami
        Jeżeli zmienię plik "file1.py"
        Wtedy wykona się test
        I zobaczę na czerwono informację o wykonaniu <tests_num> testów
        I zobaczę na czerwono informację o <failures_num> testach zakończonych niepowodzeniem
        I zobaczę na czerwono informację o <errors_num> testach zakończonych błędem
        I zobaczę na czerwono informację o pokryciu kodu na poziomie <coverage>
            | tests_num | failures_num | errors_num | coverage |
            | 1         | 1            | 0          | 100      |
            | 1         | 0            | 1          | 100      |
            | 2         | 1            | 1          | 100      |
            | 2         | 1            | 0          | 80       |

    Scenariusz: pierwszy poprawny test z pełnym pokryciem kodu
        Zakładając, że monitorowane są pliki "file1.py,file2.py,test_file.py"
        I plik "test_file.py" zawiera <tests_num> testów
        I wszystkie testy przechodzą
        I <coverage> procent kodu pokryte jest testami
        Jeżeli zmienię plik "file1.py"
        Wtedy wykona się test
        I zobaczę na zielono informację o wykonaniu <tests_num> testów
        I zobaczę na zielono informację o pokryciu kodu na poziomie <coverage>
            | tests_num | failures_num | errors_num | coverage |
            | 0         | 0            | 0          | 100      |
            | 1         | 0            | 0          | 100      |
            | 2         | 0            | 0          | 100      |

    Scenariusz: pierwszy poprawny test ze niepełnym pokryciem kodu
        Zakładając, że monitorowane są pliki "file1.py,file2.py,test_file.py"
        I plik "test_file.py" zawiera <tests_num> testów
        I wszystkie testy przechodzą
        I <coverage> procent kodu pokryte jest testami
        Jeżeli zmienię plik "file1.py"
        Wtedy wykona się test
        I zobaczę na zielono informację o wykonaniu <tests_num> testów
        I zobaczę w kolorze morskim informację o pokryciu kodu na poziomie <coverage>
            | tests_num | failures_num | errors_num | coverage |
            | 0         | 0            | 0          | 80       |
            | 1         | 0            | 0          | 80       |
            | 2         | 0            | 0          | 80       |

    Scenariusz: kolejny poprawny test z pełnym pokryciem kodu
        Zakładając, że monitorowane są pliki "file1.py,file2.py,test_file.py"
        I plik "test_file.py" zawiera <tests_num> testów
        I wszystkie testy przechodzą
        I <coverage> procent kodu pokryte jest testami
        I poprzedni test zakończył się sukcesem
        Jeżeli zmienię plik "file1.py"
        Wtedy wykona się test
        I zobaczę na niebiesko informację o wykonaniu <tests_num> testów
        I zobaczę na niebiesko informację o pokryciu kodu na poziomie <coverage>
            | tests_num | failures_num | errors_num | coverage |
            | 0         | 0            | 0          | 100      |
            | 1         | 0            | 0          | 100      |
            | 2         | 0            | 0          | 100      |

    Scenariusz: kolejny poprawny test ze niepełnym pokryciem kodu
        Zakładając, że monitorowane są pliki "file1.py,file2.py,test_file.py"
        I plik "test_file.py" zawiera <tests_num> testów
        I wszystkie testy przechodzą
        I <coverage> procent kodu pokryte jest testami
        I poprzedni test zakończył się sukcesem
        Jeżeli zmienię plik "file1.py"
        Wtedy wykona się test
        I zobaczę na niebiesko informację o wykonaniu <tests_num> testów
        I zobaczę w kolorze morskim informację o pokryciu kodu na poziomie <coverage>
            | tests_num | failures_num | errors_num | coverage |
            | 0         | 0            | 0          | 80       |
            | 1         | 0            | 0          | 80       |
            | 2         | 0            | 0          | 80       |
