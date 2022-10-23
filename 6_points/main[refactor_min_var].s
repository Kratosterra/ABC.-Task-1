	.file	"main_f.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"\320\222\320\262\320\265\320\264\320\270\321\202\320\265 \321\207\320\270\321\201\320\273\320\276 \320\276\320\261\321\214\320\265\320\272\321\202\320\276\320\262 \320\262 \320\274\320\260\321\201\321\201\320\270\320\262\320\265 (\320\276\321\202 1 \320\264\320\276 10000): "
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"%d"
	.text
	.p2align 4
	.globl	get_number_of_elements
	.type	get_number_of_elements, @function
# Возвращает n в регистре eax.	
get_number_of_elements:
	push	r12
	# В r12 строка с запросом
	lea	r12, .LC0[rip]
	push	rbp
	push	rbx
	# %d
	lea	rbx, .LC1[rip]
	sub	rsp, 16
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 8[rsp], rax
	xor	eax, eax
	# int n (4 на стеке) = 0
	mov	DWORD PTR 4[rsp], 0
	lea	rbp, 4[rsp]
	.p2align 4,,10
	.p2align 3
.L2:
    # Печатаем запрос на n
	mov	rsi, r12
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	# Получаем n
	# Готовим к передаче n
	mov	rsi, rbp
	# Готовим к предаче строку
	mov	rdi, rbx
	xor	eax, eax
	# Получаем данные.
	call	__isoc99_scanf@PLT
	# Сравниваем с ограничением, будем просить n до корректного результата.
	mov	eax, DWORD PTR 4[rsp]
	lea	edx, -1[rax]
	cmp	edx, 9998
	ja	.L2
	mov	rdx, QWORD PTR 8[rsp]
	sub	rdx, QWORD PTR fs:40
	# not OK
	jne	.L7
	# OK
	add	rsp, 16
	pop	rbx
	pop	rbp
	pop	r12
	ret
.L7:
	call	__stack_chk_fail@PLT
	.size	get_number_of_elements, .-get_number_of_elements
	.section	.rodata.str1.1
.LC2:
	.string	"\320\222\320\262\320\265\320\264\320\270\321\202\320\265 A[%d]: "
	.text
	.p2align 4
	.globl	get_elements_A
	.type	get_elements_A, @function
# Вводим элементы A, получив n (esi) и ссылку A (rdi)
get_elements_A:
	test	esi, esi
	jle	.L13
	push	r14
	# Размещаем строку
	lea	r14, .LC2[rip]
	push	r13
	# Размещаем строку
	lea	r13, .LC1[rip]
	push	r12
	# в r12d помещаем n
	mov	r12d, esi
	push	rbp
	# в rbp помещаем A
	mov	rbp, rdi
	push	rbx
	# int i = 0
	xor	ebx, ebx
	.p2align 4,,10
	.p2align 3
.L10:
    # Печатаем запрос на элемент A
	# Готовим i
	mov	edx, ebx
	# Готовим строку.
	mov	rsi, r14
	mov	edi, 1
	xor	eax, eax
	# Печать
	call	__printf_chk@PLT
	# i++
	add	ebx, 1
	# Готовим к передаче строку и A(rbp)
	mov	rsi, rbp
	mov	rdi, r13
	xor	eax, eax
	add	rbp, 4
	# Сканируем.
	call	__isoc99_scanf@PLT
	# n сравниваем с ebx
	cmp	r12d, ebx
	jne	.L10
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
	.p2align 4,,10
	.p2align 3
.L13:
	ret
	.size	get_elements_A, .-get_elements_A
	.p2align 4
	.globl	fill_elements_B
	.type	fill_elements_B, @function
# Заполняет элементы B, получив ссылку A (rdi), ссылку B (rsi) и n (edx)
fill_elements_B:
	cmp	edx, 1
	jle	.L16
	lea	ecx, -2[rdx]
	xor	eax, eax
	.p2align 4,,10
	.p2align 3
.L18:
	# A[i+1]
	mov	edx, DWORD PTR 4[rdi+rax*4]
	# A[i+1] + A[i]
	add	edx, DWORD PTR [rdi+rax*4]
	# B[i] = A[i] + A[i+1]
	mov	DWORD PTR [rsi+rax*4], edx
	mov	rdx, rax
	# i++
	add	rax, 1
	cmp	rdx, rcx
	jne	.L18
.L16:
	ret
	.size	fill_elements_B, .-fill_elements_B
	.section	.rodata.str1.1
.LC3:
	.string	"%d "
	.text
	.p2align 4
	.globl	print_elements
	.type	print_elements, @function
# Печатает эллементы массива, получив ссылку на массив (rdi) и n (esi)
print_elements:
	test	esi, esi
	jle	.L25
	# Готовим данные
	lea	eax, -1[rsi]
	push	r12
	lea	r12, 4[rdi+rax*4]
	push	rbp
	# rbp содержит строку %d
	lea	rbp, .LC3[rip]
	push	rbx
	# rbx будет представлять ссылку на массив
	mov	rbx, rdi
	.p2align 4,,10
	.p2align 3
.L22:
    # Готовимся к печати.
	mov	edx, DWORD PTR [rbx]
	mov	rsi, rbp
	mov	edi, 1
	xor	eax, eax
	# смещение
	add	rbx, 4
	# Печать
	call	__printf_chk@PLT
	# Проверяем размер
	cmp	rbx, r12
	jne	.L22
	# end
	pop	rbx
	pop	rbp
	pop	r12
	ret
	.p2align 4,,10
	.p2align 3
.L25:
	ret
	.size	print_elements, .-print_elements
	.section	.rodata.str1.1
.LC4:
	.string	"\320\236\321\202\320\262\320\265\321\202:"
.LC5:
	.string	"A[%d] = "
.LC6:
	.string	"\nB[%d] = "
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
    # main() подготовка.
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	r13
	push	r12
	sub	rsp, 16
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -40[rbp], rax
	xor	eax, eax
	# Получаем n от пользователя.
	call	get_number_of_elements
	mov	rsi, rsp
	# n помещаем из регистра eax в r12d
	mov	r12d, eax
	cdqe
	# Начинаем параллельное выделение массивов A[n] и B[n-1]
	sal	rax, 2
	lea	rdx, 15[rax]
	mov	rcx, rdx
	and	rdx, -4096
	sub	rsi, rdx
	and	rcx, -16
	cmp	rsp, rsi
	je	.L30
.L43:
	sub	rsp, 4096
	or	QWORD PTR 4088[rsp], 0
	cmp	rsp, rsi
	jne	.L43
.L30:
	and	ecx, 4095
	sub	rsp, rcx
	test	rcx, rcx
	jne	.L44
.L31:
	add	rax, 11
	mov	rcx, rsp
	# n-1
	lea	r14d, -1[r12]
	# Фиксируем ссылку на A.
	mov	r13, rsp
	mov	rdx, rax
	and	rax, -4096
	and	rdx, -16
	sub	rcx, rax
.L32:
	cmp	rsp, rcx
	je	.L33
	sub	rsp, 4096
	or	QWORD PTR 4088[rsp], 0
	jmp	.L32
.L44:
	or	QWORD PTR -8[rsp+rcx], 0
	jmp	.L31
.L33:
	and	edx, 4095
	sub	rsp, rdx
	test	rdx, rdx
	jne	.L45
.L34:
    # Готовим n и ссылку на массив A к передаче в get_elements_A
	mov	esi, r12d
	mov	rdi, r13
	# Ссылку на массив B из rsp помещаем в r15
	mov	r15, rsp
	# Получаем массив A от пользователя.
	call	get_elements_A
	# Печатаем слово "Ответ"
	lea	rdi, .LC4[rip]
	call	puts@PLT
	# Готовим к передаче аргументы n (r12d) A(r13) B(r15)
	mov	edx, r12d
	mov	rsi, r15
	mov	rdi, r13
	# Заполняем массив B
	call	fill_elements_B
	# Печатаем заготовку A[n] = 
	mov	edx, r12d
	mov	edi, 1
	xor	eax, eax
	lea	rsi, .LC5[rip]
	call	__printf_chk@PLT
	# Готовим к передаче аргументы n(r12d) A(r13)
	mov	esi, r12d
	mov	rdi, r13
	# Печатаем A
	call	print_elements
	# Печатаем заготовку B[n-1] =
	mov	edi, 1
	xor	eax, eax
	# n-1 (r14d)
	mov	edx, r14d
	lea	rsi, .LC6[rip]
	call	__printf_chk@PLT
    # Готовим к передаче аргументы n(r14d) B(r15)
	mov	esi, r14d
	mov	rdi, r15
	# Печатаем A
	call	print_elements
	# return 0;
	mov	rax, QWORD PTR -40[rbp]
	sub	rax, QWORD PTR fs:40
	jne	.L46
	lea	rsp, -32[rbp]
	xor	eax, eax
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret
.L45:
	or	QWORD PTR -8[rsp+rdx], 0
	jmp	.L34
.L46:
	call	__stack_chk_fail@PLT
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
