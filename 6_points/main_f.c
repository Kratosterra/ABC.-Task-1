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

int main() {
  int n = get_number_of_elements();
  int A[n];
  int B[n-1];
  get_elements_A(A, n);
  printf("Ответ:\n");
  fill_elements_B(A, B, n);
  printf("A[%d] = ", n);
  print_elements(A, n);
  printf("\nB[%d] = ", n-1);
  print_elements(B, n-1);
  return 0;
}
