%TDA Cards

%Elements = Elementos que tendrán las cartas. (list)
%Cards = Mazo de Cartas generado. (list)
%ListEC = Lista que contiene los elementos y cartas. (list)
%tdaCards(Elements,Cards,ListEC).
tdaCards(Elements,Cards,[Elements,Cards]).


%Funciones Generales:
%
%Función que retorna el largo de una lista.
%Lista = Lista de elementos. (list)
%Largo = Largo de la lista. (int)
%Dominio = Lista.
%Recorrido = Largo.
%largoLista(Lista,Largo).
%Ejemplo: largoLista([1,2,3,4,5],X).
largoLista([],X):- X is 0.
largoLista(L,X):-
    cdr(L,R),
    largoLista(R,Z),
    X is Z+1,!.

%Función que une dos listas.
%L1 = Lista 1. (list)
%L2 = Lista 2. (list)
%L3 = Lista unida (list)
%Dominio = L1 x L2.
%Recorrido = L3.
%join(L1,L2,L3).
%Ejemplo: join([1],[2],L).
%Caso Base: L1 está vacío
join([], Lista, Lista).
join([CabezaL1|RestoL1], Lista2, [CabezaL1|ListaResultado]) :-
	join(RestoL1, Lista2, ListaResultado).

%Función que añade un elemento al principio de una lista.
%X = Elemento a insertar. (Cualquier tipo de dato)
%L = Lista a la que se inserta X. (list)
%F = Lista con X insertado. (list)
%Dominio = X x L.
%Recorrido = L3.
%insertarAlFinal(X,L,F).
%Ejemplo: insertarAlFinal(a,[],Lista).
% Caso base: insertar un elemento a una lista vacia.
insertarAlFinal(Elemento, [], [Elemento]).
insertarAlFinal(Elemento, [Cabeza|Resto], [Cabeza|Lista]):-
        insertarAlFinal(Elemento, Resto, Lista).

%Función que retorna el primer elemento de una lista.
%L = Lista. (list)
%E = Elemento de la lista. (Cualquier tipo de dato)
%Dominio = L.
%Recorrido = E.
%car(L,E).
%Ejemplo: car([a,b],E).
% Caso base: entregar el primer valor de una lista.
car([], []).
car([E|_], E).

%Función que retorna el resto de una lista.
%L = Lista base. (list)
%R= Resto de la lista. (list)
%Dominio = L.
%Recorrido = R.
%cdr(L,R).
%Ejemplo: cdr([a,b,c],R).
% Caso base: entregar el resto de una lista.
cdr([], []).
cdr([_|R], R).

%Elimina un elemento en una determinada posición.
%P = Posición a borrar. (int)
%L = Lista inicial (list)
%F = Lista con la posición eliminado. (list)
%Dominio = P x L.
%Recorrido = F.
%borrarAt(P,L,F).
borrarAt(0, [_], []).
borrarAt(0, [_|Resto], Resto).
borrarAt(Posicion, [Cabeza|Resto], [Cabeza|NuevoResto]):- 
	PosicionAnterior is Posicion-1,
	borrarAt(PosicionAnterior, Resto, NuevoResto).

%Ejemplo: obtenerElementoEnPosicion([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z],3, Elemento).
%Caso base: entregar el elemento cuando la posición llegue a 0.
obtenerElementoEnPosicion(Elements, 0, Elemento):-
    car(Elements,Elemento).
obtenerElementoEnPosicion(Elements, Posicion, Elemento):-
    NuevaPos is Posicion-1,
    cdr(Elements,Resto),
    obtenerElementoEnPosicion(Resto, NuevaPos, Elemento).

%Ejemplo:
%Caso Base:
limitadorDeCartas(_,_,0,F,F).
limitadorDeCartas(Cards,MaxC,Cont,CardsAcum,F):-
    car(Cards,Card),
    cdr(Cards,CardsResto),
    insertarAlFinal(Card,CardsAcum,NewCardsAcum),
    Cont2 is Cont-1,
    limitadorDeCartas(CardsResto,MaxC,Cont2,NewCardsAcum,F),!.

%Ejemplo: for1([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 3, [], Card).
%Elements = [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z]
for1(_, -1, NewCard, [NewCard]).
for1(Elements, NumE, Card, F):-
    car(Elements,PrimerElemento),
    insertarAlFinal(PrimerElemento,Card,NewCard),
    cdr(Elements,Resto),
    NumE2 is NumE-1,
    for1(Resto, NumE2, NewCard, F).

%Ejemplo: for21([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 3, 3, 1, 1, [1], F).
%Elements = [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z]
for21(_,_,0,_,_,Card,Card).
for21(Elements, NumE, Cont, J, K, Card, F):-
    NumAux is (NumE * J + (K+1)),
    obtenerElementoEnPosicion(Elements, NumAux-1, Elemento),
    insertarAlFinal(Elemento, Card, NewCard),
    NewK is K+1,
    NewCont is Cont-1,
    for21(Elements, NumE, NewCont, J, NewK, NewCard, F).

%Ejemplo: for2([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 3, 3, 1, [], F).
%Elements = [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z]
for2(_,_,0,_,Cards,Cards).
for2(Elements, NumE, Cont, J, Cards, F):-
    car(Elements,Primer),
    for21(Elements, NumE, NumE, J, 1, [Primer], CardFor),
    insertarAlFinal(CardFor, Cards, NewCards),
    NewJ is J+1,
    NewCont is Cont-1,
    for2(Elements, NumE, NewCont, NewJ, NewCards, F),!.
    
%Ejemplo: for32([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 3, 3, 1, 1, 1, [2], F).
%Elements = [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z]
for32(_,_,0,_,_,_,Cards,Cards).
for32(Elements, NumE, Cont, I, J, K, Card, F):-
    NumAux is (NumE+2+NumE*(K-1)+(((I-1)*(K-1)+J-1) mod NumE)),
    obtenerElementoEnPosicion(Elements, NumAux-1, Elemento),
    insertarAlFinal(Elemento, Card, NewCard),
    NewK is K+1,
    NewCont is Cont-1,
    for32(Elements, NumE, NewCont, I, J, NewK, NewCard, F).

%Ejemplo: for31([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 3, 3, 1, 1, [], F).
%Elements = [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z]
for31(_,_,0,_,_,Cards,Cards).
for31(Elements, NumE, Cont, I, J, Cards, F):-
    obtenerElementoEnPosicion(Elements, I, SiguenteElemento),
    for32(Elements, NumE, NumE, I, J, 1, [SiguenteElemento], CardFor),
    insertarAlFinal(CardFor, Cards, NewCards),
    NewJ is J+1,
    NewCont is Cont-1,
    for31(Elements, NumE, NewCont, I, NewJ, NewCards, F),!.

%Ejemplo: for3([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 3, 3, 1, [], [], F).
%Elements = [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z]
for3(_,_,0,_,_,Cards,Cards).
for3(Elements, NumE, Cont, I, Cards, Cards2, F):-
    for31(Elements, NumE, NumE, I, 1, Cards, CardFor),
    insertarAlFinal(CardFor, Cards2, NewCards),
    NewI is I+1,
    NewCont is Cont-1,
    for3(Elements, NumE, NewCont, NewI, [], NewCards, F),!.

verificarMaxC(_,NumCartas,NumCartas).
verificarMaxC(MaxC,NumCartas,MaxC):-
    MaxC > 0,
    MaxC < NumCartas,
    verificarMaxC(_,MaxC,MaxC),!.

%Permite saber si existe un elemento en la lista
%Ej: pertenece(a,[a,b,c],A).
pertenece(_,[],0).
pertenece(Elemento, [Elemento|_],1).
pertenece(Elemento, [_|Resto], Cont):-
	pertenece(Elemento, Resto, Cont),!.

%Ejemplo: validador([1,2,3],[1,4,5],0).
%Ejemplo: trace, (validador([1,2,3],[1,2,5],0,A)).
validador(_,[],0,1).
validador([],_,Cont,Cont).
validador(C1,C2,I,Cont):-
    car(C1,E1),
	pertenece(E1, C2, Sum),
    Cont2 is I+Sum,
	cdr(C1,C11),
	validador(C11,C2,Cont2,Cont),!.

%Función random que entrega un número al azar.
%Ejemplo: myRandom(12,Xn).
myRandom(Xn, Xn1):-
    AX is 1103515245 * Xn,
	AXC is AX + 12345,
	Xn1 is (AXC mod 2147483647).

randomList(_,[],F,F).
randomList(Seed,Lista,ListaNueva,F):-
    largoLista(Lista,Largo),
    myRandom(Seed,Seed2),
    Seed3 is Seed2 mod Largo,
    obtenerElementoEnPosicion(Lista,Seed3,Card),
    borrarAt(Seed3,Lista,NuevaLista),
    append([Card],ListaNueva,ListaNuevaCarta),
    randomList(Seed,NuevaLista,ListaNuevaCarta,F),!.

getElements([Elements,_],Elements).
getCards([_,Cards],Cards).

%cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 3, MaxC,Seed,CS).
%cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 3,5,1239,CS).
%cardsSet([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z], 3,5,1239,CS).
cardsSet(Elements,NumE,MaxC,Seed,CS):-
    for1(Elements,NumE,[],Cards1),
    for2(Elements,NumE,NumE,1,[],Cards2),
    for3(Elements,NumE,NumE,1,[],[],Cards3),
    append(Cards3,CardsAppend3),
    join(Cards1,Cards2,CardsJoined1),
    join(CardsJoined1,CardsAppend3,F),
    largoLista(F,NumCartas),
    verificarMaxC(MaxC,NumCartas,MaxC),
    limitadorDeCartas(F,MaxC,MaxC,[],F2),
    randomList(Seed,F2,[],CR),
    tdaCards(Elements,CR,CS),!.

%Función que verifica si un mazo de un conjunto válido para Dobble.
verificarDobble([]).
verificarDobble(CS):-
    car(CS,Card1),
    cdr(CS,Resto),
    car(Resto,Card2),
	validador(Card1,Card2,0,A),
    A<2,
    A>0,
    cdr(CS,Cards),
    verificarDobble(Cards),!.


%cardsSet([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z], 3,5,1239,CS),
%cardsSetIsDobble(CS).
cardsSetIsDobble(CS):-
    getCards(CS,Cards),
    verificarDobble(Cards).

%cardsSetNthCard(CS,3,CS2).
cardsSetNthCard(CS,N,CS2):-
    getCards(CS,Cards),
    obtenerElementoEnPosicion(Cards,N,CS2),!.

%Ejemplo:
%cardsSet([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z], 3,3,1239,CS),
%cardsSetIsDobble(CS),
%cardsSetNthCard(CS,0,CS2),
%cardsSetFindTotalCards(CS2,TC).
cardsSetFindTotalCards(C2,TC):-
    largoLista(C2,N),
    N2 is N-1,
    TC is N2*N2 + N2 + 1.

%Ejemplo: borrarElemento(1,[1,2,3,4],R).
% Caso base: El elemento a eliminar es la cabeza de la lista
borrarElemento(Elemento, [Elemento|Resto], Resto). 
borrarElemento(Elemento, [Cabeza|Resto], [Cabeza|Resultado]):-
	Elemento\=Cabeza, 
	borrarElemento(Elemento, Resto, Resultado),!.

%Ejemplo: eliminarRepetidos([1,2],[1,2,3,4],R).
eliminarRepetidos([],F,F).
eliminarRepetidos([Card1|Cards],L2,F):-
    borrarElemento(Card1,L2,R),
    eliminarRepetidos(Cards,R,F),!.

%cardsSet([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z], 3,3,1239,CS),
%cardsSetMissingCards(CS,CS2).
cardsSetMissingCards(CS,CS2):-
    cardsSetNthCard(CS,0,Card),
	cardsSetFindTotalCards(Card,TC),
    getCards(CS, CSi),
    largoLista(CSi,Ne),
    getElements(CS,Elements),
    cardsSet(Elements, Ne, TC, TC, CSF),
    getCards(CSF, CSf),
    eliminarRepetidos(CSi,CSf,CS2).

%cartaString([1,2,3,4],A).
cartaString(Carta,Text):-
    atomics_to_string(Carta, ', ', CartaSeparada),
    string_concat("Carta: ", CartaSeparada, TextoBonito),
    string_concat(TextoBonito,"\n ",Text).

%cartasString([[1,2,3,4],[1,5,6,7]],"",A).
cartasString([],F,F).
cartasString([Carta|Resto],Acum,F):-
    cartaString(Carta,T),
    string_concat(T,Acum,Acum2),
    cartasString(Resto,Acum2,F).

%Ejemplo: 
%cardsSet([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z], 3,3,1239,CS),
%cardsSetToString(CS,CS_STR).
cardsSetToString(CS,CS_STR):-
    getCards(CS,Cartas),
    cartasString(Cartas,"",CS_STR).
	    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    