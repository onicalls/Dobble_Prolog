%TDA Cards

% Dominios
% CardList: List
%
%predicates
%tdaCards(CardList).

joinRecursivo(_, [], Lista, Lista).
joinRecursivo([Cabeza|Cola], Cola, Lista, F):-
    join(Cabeza, Lista, NuevaLista),
    joinRecursivo([Cola|OtraCosa], OtraCosa, NuevaLista, F),!.

% 3. Unir dos listas (join)
%	join(L1, L2, L3) es verdadero si L3 es el resultado de unir L1 y L2.
join( [], Lista, Lista ).
join( [CabezaL1|RestoL1], Lista2, [CabezaL1|ListaResultado] ) :-
	join( RestoL1, Lista2, ListaResultado ).

% 7. Insertar un elemento al principio de la lista (insertar por cabeza)
%Ejemplo: insertarAlFinal(a,[],Lista).
% Caso base: insertar un elemento a una lista vacia
insertarAlFinal(Elemento, [], [Elemento]).
insertarAlFinal(Elemento, [Cabeza|Resto], [Cabeza|Lista]):-
        insertarAlFinal(Elemento, Resto, Lista).

%Ejemplo: primerElementoDeUnaLista([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z],Elemento).
% Caso base: entregar el primer valor de una lista.
primerElementoDeUnaLista([Elemento|_], Elemento).

%Ejemplo: restoDeUnaLista([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z],Resto).
% Caso base: entregar el resto de una lista.
restoDeUnaLista([_|Resto], Resto).

%Ejemplo: obtenerElementoEnPosicion([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z],3, Elemento).
%Caso base: entregar el elemento cuando la posición llegue a 0.
obtenerElementoEnPosicion(Elements, 0, Elemento):-
    primerElementoDeUnaLista(Elements,Elemento).
obtenerElementoEnPosicion(Elements, Posicion, Elemento):-
    NuevaPos is Posicion-1,
    restoDeUnaLista(Elements,Resto),
    obtenerElementoEnPosicion(Resto, NuevaPos, Elemento).

%Ejemplo: for1([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z], 3, Card).
%Elements = [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z]
for1(_, 0, NewCard, NewCard).
for1(Elements, NumE, Card, F):-
    NumE >= 0, 
    restoDeUnaLista(Elements,Resto),
    NumE2 is NumE-1,
    primerElementoDeUnaLista(Elements,PrimerElemento),
    insertarAlFinal(PrimerElemento,Card,NewCard),
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
    for21(Elements, NumE, NumE, J, 1, [1], CardFor),
    insertarAlFinal(CardFor, Cards, NewCards),
    NewJ is J+1,
    NewCont is Cont-1,
    for2(Elements, NumE, NewCont, NewJ, NewCards, F).
    
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

%cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 3,_,_,CS).
cardsSet(Elements,NumE,_,_,CS):-
    for3(Elements,NumE,NumE,1,[],[],[Cabeza,Cola]),
    joinRecursivo([Cabeza|Cola],Cola,[],CS).
    