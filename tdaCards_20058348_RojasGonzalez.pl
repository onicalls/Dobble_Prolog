%TDA Cards

% Dominios
% CardList: List
%
%predicates
%tdaCards(CardList).

% 3. Unir dos listas (join)
%	join(L1, L2, L3) es verdadero si L3 es el resultado de unir L1 y L2.
join([], Lista, Lista).
join([CabezaL1|RestoL1], Lista2, [CabezaL1|ListaResultado]) :-
	join(RestoL1, Lista2, ListaResultado).

% 7. Insertar un elemento al principio de la lista (insertar por cabeza)
%Ejemplo: insertarAlFinal(a,[],Lista).
% Caso base: insertar un elemento a una lista vacia
insertarAlFinal(Elemento, [], [Elemento]).
insertarAlFinal(Elemento, [Cabeza|Resto], [Cabeza|Lista]):-
        insertarAlFinal(Elemento, Resto, Lista).

%Ejemplo: primerElementoDeUnaLista([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z],Elemento).
% Caso base: entregar el primer valor de una lista.
primerElementoDeUnaLista([], []).
primerElementoDeUnaLista([Elemento|_], Elemento).

%Ejemplo: restoDeUnaLista([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z],Resto).
% Caso base: entregar el resto de una lista.
restoDeUnaLista([], []).
restoDeUnaLista([_|Resto], Resto).

%Elimina un elemento en una determinada posición.
borrarAt(0, [_], []).
borrarAt(0, [_|Resto], Resto).
borrarAt(Posicion, [Cabeza|Resto], [Cabeza|NuevoResto]):- 
	PosicionAnterior is Posicion-1,
	borrarAt(PosicionAnterior, Resto, NuevoResto).

%Ejemplo: obtenerElementoEnPosicion([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z],3, Elemento).
%Caso base: entregar el elemento cuando la posición llegue a 0.
obtenerElementoEnPosicion(Elements, 0, Elemento):-
    primerElementoDeUnaLista(Elements,Elemento).
obtenerElementoEnPosicion(Elements, Posicion, Elemento):-
    NuevaPos is Posicion-1,
    restoDeUnaLista(Elements,Resto),
    obtenerElementoEnPosicion(Resto, NuevaPos, Elemento).

%Ejemplo:
%Caso Base:
limitadorDeCartas(_,_,0,F,F).
limitadorDeCartas(Cards,MaxC,Cont,CardsAcum,F):-
    primerElementoDeUnaLista(Cards,Card),
    restoDeUnaLista(Cards,CardsResto),
    insertarAlFinal(Card,CardsAcum,NewCardsAcum),
    Cont2 is Cont-1,
    limitadorDeCartas(CardsResto,MaxC,Cont2,NewCardsAcum,F),!.

%Ejemplo: for1([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 3, [], Card).
%Elements = [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z]
for1(_, -1, NewCard, [NewCard]).
for1(Elements, NumE, Card, F):-
    primerElementoDeUnaLista(Elements,PrimerElemento),
    insertarAlFinal(PrimerElemento,Card,NewCard),
    restoDeUnaLista(Elements,Resto),
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
    primerElementoDeUnaLista(Elements,Primer),
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

randomList(_,[],F,F).
randomList(Seed,Lista,ListaNueva,F):-
    length(Lista,Largo),
    random(0,Seed,Seed2),
    Seed3 is Seed2 mod Largo,
    obtenerElementoEnPosicion(Lista,Seed3,Card),
    borrarAt(Seed3,Lista,NuevaLista),
    append([Card],ListaNueva,ListaNuevaCarta),
    randomList(Seed,NuevaLista,ListaNuevaCarta,F),!.

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
    primerElementoDeUnaLista(C1,E1),
	pertenece(E1, C2, Sum),
    Cont2 is I+Sum,
	restoDeUnaLista(C1,C11),
	validador(C11,C2,Cont2,Cont),!.


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
    length(F,NumCartas),
    verificarMaxC(MaxC,NumCartas,MaxC),
    limitadorDeCartas(F,MaxC,MaxC,[],F2),
    randomList(Seed,F2,[],CS),!.

%Ejemplo: cardsSetIsDobble([[1,2,3],[1,4,5], [1,6,7]]).
cardsSetIsDobble([]).
cardsSetIsDobble(CS):-
    primerElementoDeUnaLista(CS,Card1),
    restoDeUnaLista(CS,Resto),
    primerElementoDeUnaLista(Resto,Card2),
	validador(Card1,Card2,0,A),
    A<2,
    A>0,
    restoDeUnaLista(CS,Cards),
    cardsSetIsDobble(Cards),!.

%cardsSetNthCard(CS,3,CS2).
cardsSetNthCard(CS,N,CS2):-
    obtenerElementoEnPosicion(CS,N,CS2),!.

%cardsSetFindTotalCards(
cardsSetFindTotalCards(C2,TC):-
    length(C2,N),
    N2 is N-1,
    TC is N2*N2 + N2 + 1.