#include <stdio.h>

int get_number_of_elements() {
  int n = 0;
  while (n <= 0 || n >= 10000) {
    printf("Введите число обьектов в массиве (от 1 до 10000): ");
    scanf("%d", &n);
  }
  return n;
}

void get_elements_A(int A[], int n) {
  for(int i = 0; i < n; ++i) {
      printf("Введите A[%d]: ", i);
      scanf("%d", &A[i]);
  }
}

void fill_elements_B(int A[], int B[], int n) {
  for (int i = 0; i < n-1; ++i) {
    B[i] = A[i] + A[i+1];
  }
}

void print_elements(int A[], int n) {
  for(int i = 0; i < n; ++i) {
    printf("%d ", A[i]);
  }
}

void print_elements_file(int B[], int n, char **argv) {
  printf("Ответ в файле вывода!\n");
  FILE *f = fopen(argv[2],"w+");
  fprintf(f,"B[%d] = ", n-1);
  for(int i = 0; i < n-1; i++){
    fprintf(f,"%d, ", B[i]);
  }
  fclose(f);
}

void get_elements_file_A(int A[], char **argv) {
  int n = 0;
  FILE *f = fopen(argv[1], "r");
  int i = 0;
  int num = 0;
  fscanf(f, "%d: ", &n);
  while(fscanf(f, "%d, ", &num) > 0 && i < n)
  {
      A[i++] = num;
  }
  fclose(f);
}

int get_numbers_of_elements_file(char **argv) {
  int n = 0;
  FILE *f = fopen(argv[1], "r");
  fscanf(f, "%d: ", &n);
  fclose(f);
  return n;
}