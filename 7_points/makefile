#makefile для main_files.s
main_files: main_files.o functions.o 
	gcc -o main_files main_files.o functions.o
main_files.o: main_files.s
	as --gstabs -o main_files.o main_files.s
functions.o: functions.s
	as --gstabs -o functions.o functions.s