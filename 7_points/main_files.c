#include <stdio.h>
#include "functions.h"

int main(int argc, char **argv) {
  int n = 0;
  if (argc != 3 && argc != 1) {
    puts("Неверное количество параметров, их всегда 2 - входной и выходной файл");
    return 1;
  } else if (argc == 3) {
    n = get_numbers_of_elements_file(argv);
  } else {
    n = get_number_of_elements();
  }
  int A[n];
  int B[n-1];
  if (argc == 3) {
    get_elements_file_A(A, argv);
  } else {
    get_elements_A(A, n);
  }
  printf("Ответ:\n");
  fill_elements_B(A, B, n);
  if (argc == 3) {
    print_elements_file(B, n, argv);
  } else {
    printf("A[%d] = ", n);
    print_elements(A, n);
    printf("\nB[%d] = ", n-1);
    print_elements(B, n-1);
  }
  return 0;
}
