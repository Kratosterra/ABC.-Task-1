	.file	"main.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"\320\222\320\262\320\265\320\264\320\270\321\202\320\265 \321\207\320\270\321\201\320\273\320\276 \320\276\320\261\321\214\320\265\320\272\321\202\320\276\320\262 \320\262 \320\274\320\260\321\201\321\201\320\270\320\262\320\265 (\320\276\321\202 1 \320\264\320\276 10000): "
.LC1:
	.string	"%d"
.LC2:
	.string	"\320\222\320\262\320\265\320\264\320\270\321\202\320\265 A[%d]: "
.LC3:
	.string	"\320\236\321\202\320\262\320\265\321\202:"
.LC4:
	.string	"A[%d] = "
.LC5:
	.string	"%d "
.LC6:
	.string	"\nB[%d] = "
	.text
	.globl	main
	.type	main, @function
main:
    mov %rbp, %rsp #for correct debugging
.LFB0:
	# Оформляем подготовку.
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 104
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -56[rbp], rax
	xor	eax, eax
	mov	rax, rsp
	mov	rbx, rax
	# Кладем 0 на стек, выделяем память n так сказать.
	mov	DWORD PTR -108[rbp], 0
    # Переходим к получению длины массива A (активируем while)
	jmp	.L2
# Получаем длину Массива A в регистр eax (с сохранением в -108 по стеку)- это n в С представлении.
# А массивы мы будем хранить регистров для смещения rax для ссылки rdx (с сохранением на стеке).
.L3:
    # Печатаем запрос на ввод n.
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	# Оформляем получение n.
	lea	rax, -108[rbp]
	mov	rsi, rax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
    # Получаем n.
	call	__isoc99_scanf@PLT
.L2:
    # Если n не подходит под требования (0 < n < 10000) снова получаем n.
	mov	eax, DWORD PTR -108[rbp]
	test	eax, eax
	jle	.L3
	mov	eax, DWORD PTR -108[rbp]
 	cmp	eax, 9999
	jg	.L3
	# Идем дальше, если все в порядке.
	# Выделяем в памяти массивы A и B.
	# n-1
	mov	eax, DWORD PTR -108[rbp]
	movsx	rdx, eax
	sub	rdx, 1
	# n-1 в -88 по стеку
	mov	QWORD PTR -88[rbp], rdx
	movsx	rdx, eax
	mov	QWORD PTR -128[rbp], rdx
	mov	QWORD PTR -120[rbp], 0
	movsx	rdx, eax
	mov	QWORD PTR -144[rbp], rdx
	mov	QWORD PTR -136[rbp], 0
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	eax, 16
	sub	rax, 1
	add	rax, rdx
	mov	esi, 16
	mov	edx, 0
	div	rsi
	imul	rax, rax, 16
	mov	rcx, rax
	and	rcx, -4096
	mov	rdx, rsp
	sub	rdx, rcx
.L4:
	cmp	rsp, rdx
	je	.L5
	sub	rsp, 4096
	or	QWORD PTR 4088[rsp], 0
	jmp	.L4
.L5:
	mov	rdx, rax
	and	edx, 4095
	sub	rsp, rdx
	mov	rdx, rax
	and	edx, 4095
	test	rdx, rdx
	je	.L6
	and	eax, 4095
	sub	rax, 8
	add	rax, rsp
	or	QWORD PTR [rax], 0
.L6:
	mov	rax, rsp
	add	rax, 3
	shr	rax, 2
	sal	rax, 2
	mov	QWORD PTR -80[rbp], rax
	# n-1
	mov	eax, DWORD PTR -108[rbp]
	sub	eax, 1
	movsx	rdx, eax
	sub	rdx, 1
	mov	QWORD PTR -72[rbp], rdx
	movsx	rdx, eax
	mov	r14, rdx
	mov	r15d, 0
	movsx	rdx, eax
	mov	r12, rdx
	mov	r13d, 0
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	eax, 16
	sub	rax, 1
	add	rax, rdx
	mov	esi, 16
	mov	edx, 0
	div	rsi
	imul	rax, rax, 16
	mov	rcx, rax
	and	rcx, -4096
	mov	rdx, rsp
	sub	rdx, rcx
.L7:
	cmp	rsp, rdx
	je	.L8
	sub	rsp, 4096
	or	QWORD PTR 4088[rsp], 0
	jmp	.L7
.L8:
	mov	rdx, rax
	and	edx, 4095
	sub	rsp, rdx
	mov	rdx, rax
	and	edx, 4095
	test	rdx, rdx
	je	.L9
	and	eax, 4095
	sub	rax, 8
	add	rax, rsp
	or	QWORD PTR [rax], 0
.L9:
	mov	rax, rsp
	add	rax, 3
	shr	rax, 2
	sal	rax, 2
	mov	QWORD PTR -64[rbp], rax
	mov	DWORD PTR -104[rbp], 0
	jmp	.L10
# Получаем элемент массива A в регистр eax (rdx - будет содержать ссылку на массив)
# Размер обработанной области (фактически i) будем хранить в -104 по стеку
.L11:
    # Получаемм в регистр eax нашу i
	mov	eax, DWORD PTR -104[rbp]
	# Готовим аргументы к вызову printf
	mov	esi, eax
	lea	rax, .LC2[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	# Получаемм в регистр eax нашу i
	mov	eax, DWORD PTR -104[rbp]
	cdqe
	# &A[i]
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -80[rbp]
	add	rax, rdx
    # Готовимся к вызову scanf
	mov	rsi, rax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	# Получаем элемент
	call	__isoc99_scanf@PLT
	# i++
	add	DWORD PTR -104[rbp], 1
# Печатаем слово "Ответ" и идем к печати массива A и B.
.L10:
	# Получаем в регистр eax нашу n
	mov	eax, DWORD PTR -108[rbp]
	# Сравниваем ее с текущим i
	cmp	DWORD PTR -104[rbp], eax
    # Работаем с корректностью.
	jl	.L11
	# Готовимся к печати слова Ответ
	lea	rax, .LC3[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	DWORD PTR -100[rbp], 0
	jmp	.L12
# Заполняем массив B[n-1] по правилу B_i = A_i + A_(i+1)
# Где i (-100 по стеку)
.L13:
	mov	rax, QWORD PTR -80[rbp]
	mov	edx, DWORD PTR -100[rbp]
	# rdx теперь i
	movsx	rdx, edx
	mov	ecx, DWORD PTR [rax+rdx*4]
	mov	eax, DWORD PTR -100[rbp]
	lea	edx, 1[rax]
	mov	rax, QWORD PTR -80[rbp]
	movsx	rdx, edx
	mov	eax, DWORD PTR [rax+rdx*4]
	add	ecx, eax
	mov	rax, QWORD PTR -64[rbp]
	mov	edx, DWORD PTR -100[rbp]
	movsx	rdx, edx
	mov	DWORD PTR [rax+rdx*4], ecx
	# i++
	add	DWORD PTR -100[rbp], 1
# Начинаем печать массива A.
.L12:
    # Получаем n
	mov	eax, DWORD PTR -108[rbp]
	# n-1
	sub	eax, 1
    # Сравниваем i и n-1
	cmp	DWORD PTR -100[rbp], eax
	# Переходим к заполнению массива B.
	jl	.L13
	# Получаем заготовку для печати каждого элемента A.
	# Заполняем аргументы
	mov	eax, DWORD PTR -108[rbp]
	mov	esi, eax
	lea	rax, .LC4[rip]
	mov	rdi, rax
	mov	eax, 0
	# Печатаем
	call	printf@PLT
	mov	DWORD PTR -96[rbp], 0
    # Переходим к общей печати.
	jmp	.L14
# Печать элемента массива A по %d, i будем хранить в -96 по стеку.
.L15:
	mov	rax, QWORD PTR -80[rbp]
	mov	edx, DWORD PTR -96[rbp]
	movsx	rdx, edx
	mov	eax, DWORD PTR [rax+rdx*4]
	mov	esi, eax
	# Получаем аргумент для печати в виде строки.
	lea	rax, .LC5[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	# i++
	add	DWORD PTR -96[rbp], 1
#  Общая печать.
.L14:
	# n
	mov	eax, DWORD PTR -108[rbp]
	# размер напечатанной области i сравниваем с n
	cmp	DWORD PTR -96[rbp], eax
    # Печатаем массив A, пока он не кончится.
	jl	.L15
    # Приступаем к печтати элементов массива A.
	mov	eax, DWORD PTR -108[rbp]
	sub	eax, 1
	mov	esi, eax
    # Получаем заготовку для вывода каждого элемета A.
	lea	rax, .LC6[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	DWORD PTR -92[rbp], 0
	jmp	.L16
# Печать элемента массива B по %d, i будем хранить в -92 по стеку.
.L17:
	mov	rax, QWORD PTR -64[rbp]
	mov	edx, DWORD PTR -92[rbp]
	movsx	rdx, edx
	mov	eax, DWORD PTR [rax+rdx*4]
	# Заполняем аргументы для вызова printf
	mov	esi, eax
	lea	rax, .LC5[rip]
	mov	rdi, rax
	mov	eax, 0
	# Печатаем
	call	printf@PLT
	# i++
	add	DWORD PTR -92[rbp], 1
.L16:
	# n-1 
	mov	eax, DWORD PTR -108[rbp]
	sub	eax, 1
	# размер напечатанной области i сравниваем с n-1
	cmp	DWORD PTR -92[rbp], eax
    # Печатаем до конца массива B.
	jl	.L17
	mov	eax, 0
	mov	rsp, rbx
	mov	rdx, QWORD PTR -56[rbp]
	sub	rdx, QWORD PTR fs:40
    # Переходим к окончанию вывода и программы.
	je	.L19
	call	__stack_chk_fail@PLT
# OK
.L19:
	lea	rsp, -40[rbp]
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:

