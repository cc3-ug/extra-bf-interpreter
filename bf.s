  .global __start
  
  .data

memory:   .zero     80            # Reserva 80 bytes de espacio

  # test1, sin ciclos
  # imprime '2'
test1:     .asciiz  "++++++++++++++++++++++++++++++++++++++++++++++++++."

  # test2, sin ciclos
  # imprime '24'
test2:     .asciiz  "++++++++++++++++++++++++++++++++++++++++++++++++++>++++++++++++++++++++++++++++++++++++++++++++++++++++<.>."
  
  # looptest3, con ciclos
  # imprime '2' 
looptest3: .asciiz  ">++++++++++[>+++++<-]>."

  # looptest4, con ciclos
  # imprime '24'
looptest4: .asciiz  ">++++++++++[>+++++>+++++<<-]>.>++."

  # hellotest5, con ciclos
  # imprime 'hello'
hellotest5:  .asciiz  ">++++++++++[>++++++++++<-]>++++.---.+++++++..+++."

  # pueden agregar sus propios tests aqui
  
  # cuidado si sacan tests de internet!
  # muchos usan ciclos anidados
  # la solucion para ciclos "de un nivel" y anidados es muy diferente
  
  .text    

        ##### INICIO DEL PROGRAMA PRINCIPAL #####
  __start:

  # MODIFICAR ESTA LINEA PARA INDICARLE QUE TEST EJECUTAR
la s0 test1          # s0: Direccion del string con el programa a ejecutar

la s1 memory         # s1: Direccion con la memoria para el programa
addi s1 s1 10        #     ...con un pequeno desfase
                     # El desfase esta por seguridad, algunos programas asumen memoria infinita e inician con <


### Inicio del ciclo que recorre cada casilla del string indicado ###
  loop:
lb s2 0(s0)          # Accede a la direccion y obtiene el caracter
beqz s2 loop_end     # Si el caracter es cero, termina el ciclo

# >    Avanza el puntero a memoria
# <    Retrocede el puntero a memoria
# +    Aumenta el valor de la casilla senalada
# -    Disminuye el valor de la casilla senalada
# .    Imprime un caracter
# ,    Lee un caracter
# [    Inicio de un ciclo
# ]    Fin de un ciclo


mv a0 s2
jal printChar


  nextIter:
addi s0 s0 1         # step, avanza la direccion
j loop               # iterar

  loop_end:
nop
### Fin del ciclo que recorre cada casilla del string indicado ###

li a0 10
ecall
        ##### FINAL DEL PROGRAMA PRINCIPAL #####
        
        
        
        ##### ALGUNAS FUNCIONES DE AYUDA #####

printChar:
  # args:      a0    valor ascii del caracter a imprimir
  # return:    void
  mv a1 a0
  li a0 11
  ecall        # ecall 11: imprimir caracter
  jr ra

readChar:
  # args:      empty
  # return:    a0    valor ascii del caracter leido
  li a0 12
  ecall
  jr ra
  
        ##### FIN DE LAS FUNCIONES DE AYUDA #####
