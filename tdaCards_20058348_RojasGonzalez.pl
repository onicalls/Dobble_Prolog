%TDA Cards

% Dominios
% CardList: List
%
%predicates
%tdaCards(CardList).

% 7. Insertar un elemento al principio de la lista (insertar por cabeza)

%Ejemplo: insertarAlFinal(a,[],Lista).
% Caso base: insertar un elemento a una lista vacia
insertarAlFinal( Elemento, [], [Elemento] ).
insertarAlFinal( Elemento, [Cabeza|Resto], [Cabeza|Lista] ) :-
        insertarAlFinal( Elemento, Resto, Lista ).

%Ejemplo: primerElementoDeUnaLista([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z],Elemento).
% Caso base: entregar el primer valor de una lista.
primerElementoDeUnaLista([Elemento|_], Elemento).

%Ejemplo: restoDeUnaLista([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z],Resto).
% Caso base: entregar el resto de una lista.
restoDeUnaLista([_|Resto], Resto).

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

%cardsSet(Elements,NumE,MaxC,Seed,CS):-
    