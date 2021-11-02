#!/bin/bash
 E='echo -e';e='echo -en';trap "R;exit" 2
 ESC=$( $e "\e")
 TPUT(){ $e "\e[${1};${2}H" ;}
 CLEAR(){ $e "\ec";}
# 25 возможно это 
 CIVIS(){ $e "\e[?25l";}
# это цвет текста списка перед курсором при значении 0 в переменной  UNMARK(){ $e "\e[0m";}
 MARK(){ $e "\e[1;35m";}
# 0 это цвет заднего фона списка
 UNMARK(){ $e "\e[0m";}
# ~~~~~~~~ Эти строки задают цвет фона ~~~~~~~~
 R(){ CLEAR ;stty sane;CLEAR;};
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 HEAD(){ for (( a=2; a<=28; a++ ))
  do
   TPUT $a 1
 $E "\033[34m\xE2\x94\x82                                                                                                                      \xE2\x94\x82\033[0m";
  done
 TPUT 1 1
 $E "\033[34m+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+\033[0m"
 TPUT 2 4
 $E "\033[1;36m *** ne консольный редактор ***\033[0m                                               \033[34m|\033[0m";
 TPUT 11 4
 $E "\033[36mОпции                                                                         \033[34m| \033[32mOPTIONS\033[0m";
 TPUT 27 4
 $E "\033[32mUp \xE2\x86\x91 \xE2\x86\x93 Down Select Enter                                                      \033[34m| \033[32m";
 MARK;TPUT 3 1
 $E "\033[34m+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+\033[0m" ;UNMARK;}
  i=0; CLEAR; CIVIS;NULL=/dev/null
 FOOT(){ MARK;TPUT 29 1
 $E "\033[34m+~~~| Grannik | 2021.11.02 |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+\033[0m";UNMARK;}
# это управляет кнопками ввер/хвниз
 i=0; CLEAR; CIVIS;NULL=/dev/null
#
 ARROW(){ IFS= read -s -n1 key 2>/dev/null >&2
           if [[ $key = $ESC ]];then 
              read -s -n1 key 2>/dev/null >&2;
              if [[ $key = \[ ]]; then
                 read -s -n1 key 2>/dev/null >&2;
                 if [[ $key = A ]]; then echo up;fi
                 if [[ $key = B ]];then echo dn;fi
              fi
           fi
           if [[ "$key" == "$($e \\x0A)" ]];then echo enter;fi;}
 M0(){ TPUT  4 3; $e "Обзор                                                                          \033[32m SYNOPSIS                           \033[0m";}
 M1(){ TPUT  5 3; $e "Описание                                                                       \033[32m DESCRIPTION                        \033[0m";}
 M2(){ TPUT  6 3; $e "Использование                                                                  \033[32m USAGE                              \033[0m";}
 M3(){ TPUT  7 3; $e "Ошибки                                                                         \033[32m BUGS                               \033[0m";}
 M4(){ TPUT  8 3; $e "Автор                                                                          \033[32m AUTHORS                            \033[0m";}
 M5(){ TPUT  9 3; $e "Горячие клавиши                                                                \033[32m Hotkeys                            \033[0m";}
 M6(){ TPUT 10 3; $e "Интернер ссылки                                                                \033[32m Internet links                     \033[0m";}
#
 M7(){ TPUT 12 3; $e "Печатает справочное сообщение                                                  \033[32m --help                             \033[0m";}
 M8(){ TPUT 13 3; $e "Следующий токен - это имя файла                                                \033[32m --                                 \033[0m";}
 M9(){ TPUT 14 3; $e "Переход к последней или N-й строке, первому или M-му столбцу открываемого файла\033[32m +[N[,M]]                           \033[0m";}
M10(){ TPUT 15 3; $e "Загрузите следующий именованный файл в двоичном режиме                         \033[32m --binary                           \033[0m";}
M11(){ TPUT 16 3; $e "Загрузите следующий файл в режиме только для чтения                            \033[32m --read-only                        \033[0m";}
M12(){ TPUT 17 3; $e "Используйте ввод-вывод UTF-8                                                   \033[32m --utf8                             \033[0m";}
M13(){ TPUT 18 3; $e "Не используйте ввод-вывод UTF-8                                                \033[32m --no-utf8                          \033[0m";}
M14(){ TPUT 19 3; $e "Используйте встроенные последовательности ANSI                                 \033[32m --ansi                             \033[0m";}
M15(){ TPUT 20 3; $e "Никогда не используйте встроенные последовательности ANSI                      \033[32m --no-ansi                          \033[0m";}
M16(){ TPUT 21 3; $e "Пропустите чтение файлов конфигурации меню и клавиатуры                        \033[32m --no-config                        \033[0m";}
M17(){ TPUT 22 3; $e "Отключить поддержку подсветки синтаксиса                                       \033[32m --no-syntax                        \033[0m";}
M18(){ TPUT 23 3; $e "Перед загрузкой первого файла установите автопреференции                       \033[32m --prefs ext                        \033[0m";}
M19(){ TPUT 24 3; $e "Используйте указанный файл конфигурации клавиатуры                             \033[32m --keys      key-configuration-file \033[0m";}
M20(){ TPUT 25 3; $e "Используйте указанный файл конфигурации меню                                   \033[32m --menus     menu-configuration-file\033[0m";}
M21(){ TPUT 26 3; $e "Выполнить указанный макрос после запуска                                       \033[32m --macro     macro-file             \033[0m";}
#
M22(){ TPUT 28 3; $e "EXIT                                                                                                               ";}
LM=22
   MENU(){ for each in $(seq 0 $LM);do M${each};done;}
    POS(){ if [[ $cur == up ]];then ((i--));fi
           if [[ $cur == dn ]];then ((i++));fi
           if [[ $i -lt 0   ]];then i=$LM;fi
           if [[ $i -gt $LM ]];then i=0;fi;}
REFRESH(){ after=$((i+1)); before=$((i-1))
           if [[ $before -lt 0  ]];then before=$LM;fi
           if [[ $after -gt $LM ]];then after=0;fi
           if [[ $j -lt $i      ]];then UNMARK;M$before;else UNMARK;M$after;fi
           if [[ $after -eq 0 ]] || [ $before -eq $LM ];then
           UNMARK; M$before; M$after;fi;j=$i;UNMARK;M$before;M$after;}
   INIT(){ R;HEAD;FOOT;MENU;}
     SC(){ REFRESH;MARK;$S;$b;cur=`ARROW`;}
# Функция возвращения в меню
     ES(){ MARK;$e " ENTER = main menu ";$b;read;INIT;};INIT
  while [[ "$O" != " " ]]; do case $i in
  0) S=M0;SC;if [[ $cur == enter ]];then R;echo "          ne [options] files
 Options:
 --help -- +[N[,M]] --binary --read-only --utf8 --no-utf8 --ansi --no-ansi --no-config --no-syn‐tax --prefs ext --keys key-configuration-file
 --menus menu-configuration-file --macro macro-file";ES;fi;;
  1) S=M1;SC;if [[ $cur == enter ]];then R;echo "   ne - это бесплатный текстовый редактор, который работает (надеюсь, почти) на любой машине UN * X. ne прост в использовании для новичка, но мощный полный и полностью
 настраиваемый для мастера и максимально экономный в использовании ресурсов.
   Эта документация неполная. Документация Texinfo/info/HTML/PDF является авторитетным источником (попробуйте info ne или info -f ne).";ES;fi;;
  2) S=M2;SC;if [[ $cur == enter ]];then R;echo "   Начните ne, затем используйте escape, escape-escape или F1 для доступа к меню.";ES;fi;;
  3) S=M3;SC;if [[ $cur == enter ]];then R;echo "   Отправляйте отчеты об ошибках Себастьяно Винья: vigna@di.unimi.it
   или Тодду Льюису                              : utoddl@email.unc.edu";ES;fi;;
  4) S=M4;SC;if [[ $cur == enter ]];then R;echo "   ne был первоначально написан Себастьяно Винья. Тодд М. Льюис добавил несколько новых функций. Даниэле Филаретти помог с синхронизацией налоговая подсветка.";ES;fi;;
  5) S=M5;SC;if [[ $cur == enter ]];then R;echo " F1               | открыть меню
 Esc               открыть меню
 Ctrl + s          сохранить запись
 Ctrl + q          закрыть блокнот
 Ctrl + x          сохранить и закрыть
 Ctrl + y          удалить строку
 Ctrl + u          восстановить строку
 Ctrl + Shift + c  выделить
 Ctrl + Shift + v  сохранить";ES;fi;;
  6) S=M6;SC;if [[ $cur == enter ]];then R;echo " ne home page: http://ne.di.unimi.it/
 GitHub repo: https://github.com/vigna/ne/
 Discuss ne at http://groups.google.com/group/niceeditor/";ES;fi;;
#
  7) S=M7;SC;if [[ $cur == enter ]];then R;echo " Печатает справочное сообщение:
 ne --help";ES;fi;;
  8) S=M8;SC;if [[ $cur == enter ]];then R;echo " Следующий токен - это имя файла. Может появиться не раз:
 ne --";ES;fi;;
  9) S=M9;SC;if [[ $cur == enter ]];then R;echo " Переход к последней или N-й строке, первому или M-му столбцу следующего названного файла. Может появиться не раз:
 ne +3 file.txt";ES;fi;;
 10) S=M10;SC;if [[ $cur == enter ]];then R;echo " Загрузите следующий именованный файл в двоичном режиме. Может появиться не раз:
 ne --binary file.txt";ES;fi;;
 11) S=M11;SC;if [[ $cur == enter ]];then R;echo " Загрузите следующий файл в режиме только для чтения. Может появиться не раз:
 ne --read-only file.txt";ES;fi;;
 12) S=M12;SC;if [[ $cur == enter ]];then R;echo " Используйте ввод-вывод UTF-8:
 ne --utf8 file.txt";ES;fi;;
 13) S=M13;SC;if [[ $cur == enter ]];then R;echo " Не используйте ввод-вывод UTF-8:
 ne --no-utf8 file.txt";ES;fi;;
 14) S=M14;SC;if [[ $cur == enter ]];then R;echo " Используйте встроенные последовательности ANSI:
 ne --ansi file.txt";ES;fi;;
 15) S=M15;SC;if [[ $cur == enter ]];then R;echo " Никогда не используйте встроенные последовательности ANSI:
 ne --no-ansi file.txt";ES;fi;;
 16) S=M16;SC;if [[ $cur == enter ]];then R;echo " Пропустите чтение файлов конфигурации меню и клавиатуры:
 ne --no-config file.txt";ES;fi;;
 17) S=M17;SC;if [[ $cur == enter ]];then R;echo " Отключить поддержку подсветки синтаксиса:
 ne --no-syntax file.txt";ES;fi;;
 18) S=M18;SC;if [[ $cur == enter ]];then R;echo " Перед загрузкой первого файла установите автопреференции для предоставленного расширения:
 ne --prefs ext file.txt";ES;fi;;
 19) S=M19;SC;if [[ $cur == enter ]];then R;echo " Используйте указанный файл конфигурации клавиатуры:
 ne --keys file.txt";ES;fi;;
 20) S=M20;SC;if [[ $cur == enter ]];then R;echo " Используйте указанный файл конфигурации меню:
 ne --menus file.txt";ES;fi;;
 21) S=M21;SC;if [[ $cur == enter ]];then R;echo " Выполнить указанный макрос после запуска:
 ne --macro file.txt";ES;fi;;
#
 22) S=M22;SC;if [[ $cur == enter ]];then R;clear;ls -l;exit 0;fi;;
 esac;POS;done
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Маленькая программка туториал (пошаговое объяснение, инструкция по выполнению) для консольного редактора ne.
