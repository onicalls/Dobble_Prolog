%PREDICADOS GENERALES DE LISTAS:
%-------------------------------------------------------------------------
%Predicado que retorna el largo de una lista.
%Lista = Lista de elementos. (list)
%Largo = Largo de la lista. (int)
%Dominio = Lista x Largo.
%largoLista(Lista,Largo).
%Ejemplo: largoLista([1,2,3,4,5],X).
largoLista([],X):- X is 0.
largoLista(L,X):-
    cdr(L,R),
    largoLista(R,Z),
    X is Z+1,!.

%Predicado que une dos listas.
%L1 = Lista 1. (list)
%L2 = Lista 2. (list)
%L3 = Lista unida (list)
%Dominio = L1 x L2 x L3.
%join(L1,L2,L3).
%Ejemplo: join([1],[2],L).
%Caso Base: L1 está vacío
join([], Lista, Lista).
join([CabezaL1|RestoL1], Lista2, [CabezaL1|ListaResultado]) :-
	join(RestoL1, Lista2, ListaResultado).

%Predicado que añade un elemento al principio de una lista.
%X = Elemento a insertar. (Cualquier tipo de dato)
%L = Lista a la que se inserta X. (list)
%F = Lista con X insertado. (list)
%Dominio = X x L x L3.
%addFinish(X,L,F).
%Ejemplo: addFinish(a,[],Lista).
% Caso base: insertar un elemento a una lista vacia.
addFinish(Elemento, [], [Elemento]).
addFinish(Elemento, [Cabeza|Resto], [Cabeza|Lista]):-
        addFinish(Elemento, Resto, Lista).


insertarVarios(0,_,F,F).
insertarVarios(Ne,D,L,F):-
    Ne>0,
    Ne2 is Ne - 1,
    addFinish(D,L,F2),
    insertarVarios(Ne2,D,F2,F),!.

%Función que retorna el primer elemento de una lista.
%L = Lista. (list)
%E = Elemento de la lista. (Cualquier tipo de dato)
%Dominio = L x E.
%car(L,E).
%Ejemplo: car([a,b],E).
% Caso base: entregar el primer valor de una lista.
car([], []).
car([E|_], E).

%Función que retorna el resto de una lista.
%L = Lista base. (list)
%R= Resto de la lista. (list)
%Dominio = L x R.
%cdr(L,R).
%Ejemplo: cdr([a,b,c],R).
% Caso base: entregar el resto de una lista.
cdr([], []).
cdr([_|R], R).

%Elimina un elemento en una determinada posición.
%P = Posición a borrar. (int)
%L = Lista inicial (list)
%F = Lista con la posición eliminado. (list)
%Dominio = P x L x F.
%borrarAt(P,L,F).
borrarAt(0, [_], []).
borrarAt(0, [_|Resto], Resto).
borrarAt(Posicion, [Cabeza|Resto], [Cabeza|NuevoResto]):- 
	PosicionAnterior is Posicion-1,
	borrarAt(PosicionAnterior, Resto, NuevoResto).


%Entrega un elemento de la lista en una cierta posición.
%L = Lista. (list)
%P = Posición del elemento (int)
%F = Elemento a retornar. (list)
%Dominio = L x P x F.
%getElmPos(L,P,F).
%Ejemplo: getElmPos([a,b,c],2, Elemento).
%Caso base: entregar el elemento cuando la posición llegue a 0.
getElmPos(Elements, 0, Elemento):-
    car(Elements,Elemento).
getElmPos(Elements, Posicion, Elemento):-
    NuevaPos is Posicion-1,
    cdr(Elements,Resto),
    getElmPos(Resto, NuevaPos, Elemento).

%getPosElement(2,[a,b,c],Pos,Pos).
getPosElement(Element,[Element|_],F,F).
getPosElement(Element,[_|Cdr],Pos,F):-
    Pos2 is Pos+1,
    getPosElement(Element,Cdr,Pos2,F),!.

insertarAt(Elemento, 0, [], [Elemento]).
insertarAt(Elemento, 0, [Cabeza|Resto], [Elemento, Cabeza|Resto]).
insertarAt(Elemento, Posicion, [Cabeza|Resto], [Cabeza|NuevoResto]):- 
	PosicionAnterior is Posicion - 1,
	insertarAt(Elemento, PosicionAnterior, Resto, NuevoResto).

%Predicado que elimina un elemento dentro de una lista.
%E = Elemento a eliminar. (Cualquier tipo de dato)
%L = Lista donde se busca el elemento a eliminar. (list)
%F = Lista con el elemento eliminado. (list)
%Dominio: E x L x F
%borrarElemento(E,L,F)
%Ejemplo: borrarElemento(1,[1,2,3,4],F).
% Caso base: El elemento a eliminar es la cabeza de la lista
borrarElemento(Elemento, [Elemento|Resto], Resto). 
borrarElemento(Elemento, [Cabeza|Resto], [Cabeza|Resultado]):-
	Elemento\=Cabeza, 
	borrarElemento(Elemento, Resto, Resultado),!.

%Predicado que elimina una lista de elemento dentro de otra lista.
%LE = Lista de elementos a eliminar. (list)
%L = Lista donde se buscan los elementos a eliminar. (list)
%F = Lista con los elementos eliminados. (list)
%Dominio: LE x L x F
%borrarElemento(LE,L,F)
%Ejemplo: eliminarRepetidos([1,2],[1,2,3,4],R).
eliminarRepetidos([],F,F).
eliminarRepetidos([Card1|Cards],L2,F):-
    borrarElemento(Card1,L2,R),
    eliminarRepetidos(Cards,R,F),!.
%-------------------------------------------------------------------------


%FUNCIONES DEL TDA CARDSSET
%-------------------------------------------------------------------------
%TDA Cards
%Elements = Elementos que tendrán las cartas. (list)
%Cards = Mazo de Cartas generado. (list)
%ListEC = Lista que contiene los elementos y cartas. (list)
%Dominio = Elements x Cards x ListEC
%tdaCards(Elements,Cards,ListEC).
tdaCards(Elements,Cards,[Elements,Cards]).
%gettersCards
getElements([Elements,_],Elements).
getCards([_,Cards],Cards).

%Predicado que entrega la primera carta.
%Elements = Elementos que tendrán las cartas. (list)
%NumE = Numero de elementos (int)
%Card = Carta (list)
%F = Nueva Carta (list)
%Dominio = Elements x NumE x Card x F
%for1(Elements,NumE,Card,F).
%Ejemplo: for1([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 3, [], Card).
for1(_, -1, NewCard, [NewCard]).
for1(Elements, NumE, Card, F):-
    car(Elements,PrimerElemento),
    addFinish(PrimerElemento,Card,NewCard),
    cdr(Elements,Resto),
    NumE2 is NumE-1,
    for1(Resto, NumE2, NewCard, F).

%Predicado auxiliar para for2
%Elements = Elementos que tendrán las cartas. (list)
%NumE = Numero de elementos (int)
%Cont = Contador (int)
%J = Contador J (int)
%K = Contador K (int)
%Card = Carta (list)
%F = Nueva Carta (list)
%Dominio = Elements x NumE x Cont x J x K x Card x F
%for21(Elements, NumE, Cont, J, K, Card, F).
%Ejemplo: for21([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 3, 3, 1, 1, [1], F).
for21(_,_,0,_,_,Card,Card).
for21(Elements, NumE, Cont, J, K, Card, F):-
    NumAux is (NumE * J + (K+1)),
    getElmPos(Elements, NumAux-1, Elemento),
    addFinish(Elemento, Card, NewCard),
    NewK is K+1,
    NewCont is Cont-1,
    for21(Elements, NumE, NewCont, J, NewK, NewCard, F).

%Predicado para generar las cartas de orden n.
%Elements = Elementos que tendrán las cartas. (list)
%NumE = Numero de elementos (int)
%Cont = Contador (int)
%J = Contador J (int)
%Card = Carta (list)
%F = Nueva Carta (list)
%Dominio = Elements x NumE x Cont x J x Card x F
%for2(Elements, NumE, Cont, J, Card, F).
%Ejemplo: for2([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 3, 3, 1, [], F).
for2(_,_,0,_,Cards,Cards).
for2(Elements, NumE, Cont, J, Cards, F):-
    car(Elements,Primer),
    for21(Elements, NumE, NumE, J, 1, [Primer], CardFor),
    addFinish(CardFor, Cards, NewCards),
    NewJ is J+1,
    NewCont is Cont-1,
    for2(Elements, NumE, NewCont, NewJ, NewCards, F),!.

%Predicado auxiliar para for31
%Elements = Elementos que tendrán las cartas. (list)
%NumE = Numero de elementos (int)
%Cont = Contador (int)
%I = Contador I (int)
%J = Contador J (int)
%K = Contador K (int)
%Card = Carta (list)
%F = Nueva Carta (list)
%Dominio = Elements x NumE x Cont x I x J x K x Card x F
%for32(Elements, NumE, Cont, I, J, K, Card, F).
%Ejemplo: for32([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 3, 3, 1, 1, 1, [2], F).
for32(_,_,0,_,_,_,Cards,Cards).
for32(Elements, NumE, Cont, I, J, K, Card, F):-
    NumAux is (NumE+2+NumE*(K-1)+(((I-1)*(K-1)+J-1) mod NumE)),
    getElmPos(Elements, NumAux-1, Elemento),
    addFinish(Elemento, Card, NewCard),
    NewK is K+1,
    NewCont is Cont-1,
    for32(Elements, NumE, NewCont, I, J, NewK, NewCard, F).

%Predicado auxiliar para for3
%Elements = Elementos que tendrán las cartas. (list)
%NumE = Numero de elementos (int)
%Cont = Contador (int)
%I = Contador I (int)
%J = Contador J (int)
%Card = Carta (list)
%F = Nueva Carta (list)
%Dominio = Elements x NumE x Cont x I x J x Card x F
%for31(Elements, NumE, Cont, I, J, Card, F).
%Ejemplo: for31([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 3, 3, 1, 1, [], F).
for31(_,_,0,_,_,Cards,Cards).
for31(Elements, NumE, Cont, I, J, Cards, F):-
    getElmPos(Elements, I, SiguenteElemento),
    for32(Elements, NumE, NumE, I, J, 1, [SiguenteElemento], CardFor),
    addFinish(CardFor, Cards, NewCards),
    NewJ is J+1,
    NewCont is Cont-1,
    for31(Elements, NumE, NewCont, I, NewJ, NewCards, F),!.

%Predicado para generar las cartas de orden n cuadrado.
%Elements = Elementos que tendrán las cartas. (list)
%NumE = Numero de elementos (int)
%Cont = Contador (int)
%I = Contador I (int)
%Card = Carta (list)
%F = Nueva Carta (list)
%Dominio = Elements x NumE x Cont x I x Card x F
%for3(Elements, NumE, Cont, I, Card, F).
%Ejemplo: for3([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 3, 3, 1, [], [], F).
for3(_,_,0,_,_,Cards,Cards).
for3(Elements, NumE, Cont, I, Cards, Cards2, F):-
    for31(Elements, NumE, NumE, I, 1, Cards, CardFor),
    addFinish(CardFor, Cards2, NewCards),
    NewI is I+1,
    NewCont is Cont-1,
    for3(Elements, NumE, NewCont, NewI, [], NewCards, F),!.

%Predicado que entrega un mazo limitado de cartas.
%C = Lista de Cartas originales. (list)
%MC = Número máximo de cartas a entregar. (int)
%I = Contador. (int)
%CA = Cartas acumuladas. (list)
%F = Cartas limitadas. (list)
%Dominio = C x MC x I x CA x F.
%limitadorDeCartas(C,MC,I,CA,F).
%Caso Base:
limitadorDeCartas(_,_,0,F,F).
limitadorDeCartas(Cards,MaxC,Cont,CardsAcum,F):-
    car(Cards,Card),
    cdr(Cards,CardsResto),
    addFinish(Card,CardsAcum,NewCardsAcum),
    Cont2 is Cont-1,
    limitadorDeCartas(CardsResto,MaxC,Cont2,NewCardsAcum,F),!.

%Predicado que verifica si se ha entregado un dato.
%MXi = Número máximo de cartas. (int)
%NC = Número de cartas máximas que se pueden generar. (int)
%MXf = Número de cartas que se pueden generar. (int)
%Dominio: MXi x NC x MXf
%verificarMaxC(MXi,NC,MXf)
verificarMaxC(_,NumCartas,NumCartas).
verificarMaxC(MaxC,NumCartas,MaxC):-
    MaxC > 0,
    MaxC < NumCartas,
    verificarMaxC(_,MaxC,MaxC),!.

%Predicado que permite saber si existe un elemento en la carta y retorna un valor numérico.
%E = Elemento a buscar en la lista. (Cualquier tipo de dato)
%L = Lista donde se buscará E. (list)
%F = Número, donde 0 es que no se ha encontrado y 1 que sí se ha encontrado. (int)
%Dominio: E x L x F
%pertenece(E,L,F).
%Ej: pertenece(a,[a,b,c],A).
pertenece(_,[],0).
pertenece(Elemento, [Elemento|_],1).
pertenece(Elemento, [_|Resto], Cont):-
	pertenece(Elemento, Resto, Cont),!.

%Predicado que valida que haya solo un elemento en la siguiente carta.
%C1 = Primera carta. (list)
%C2 = Segunda carta. (list)
%N = Contador que determina si un elemento se repite más de una vez. (int)
%F = Número que indica las veces que se repite una carta. (int)
%Dominio = C1 x C2 x N x F
%validador(C1,C2,N,F).
%Ejemplo: validador([1,2,3],[1,2,5],0,A).
validador(_,[],0,1).
validador([],_,Cont,Cont).
validador(C1,C2,I,Cont):-
    car(C1,E1),
	pertenece(E1, C2, Sum),
    Cont2 is I+Sum,
	cdr(C1,C11),
	validador(C11,C2,Cont2,Cont),!.

%Función random que entrega un número pseudoaleatorio.
%Xn = Número (int)
%Xn1 = Número pseudoaleatorio (int)
%Dominio = Xn x Xn1
%Ejemplo: myRandom(12,Xn).
myRandom(Xn, Xn1):-
    AX is 1103515245 * Xn,
	AXC is AX + 12345,
	Xn1 is (AXC mod 2147483647).

%Funcion lista random que entrega valores de la lista al azar.
%Seed = Número (int)
%Lista = Lista (list)
%ListaNueva = Lista con los datos cambiados de lugar (list)
%F = Lista nueva entregada.
%Dominio: Seed x Lista x ListaNueva x F
%randomList(Seed,Lista,ListaNueva,F)
%Ejemplo: randomList(12,[1,2,3,4,5,6],[],F).
randomList(_,[],F,F).
randomList(Seed,Lista,ListaNueva,F):-
    largoLista(Lista,Largo),
    myRandom(Seed,Seed2),
    Seed3 is Seed2 mod Largo,
    getElmPos(Lista,Seed3,Card),
    borrarAt(Seed3,Lista,NuevaLista),
    append([Card],ListaNueva,ListaNuevaCarta),
    randomList(Seed,NuevaLista,ListaNuevaCarta,F),!.

%Predicado que pasa una carta a string.
%Carta = Carta (list)
%Text= Carta en texto (str)
%Dominio = Carta x Text
%cartaString(Carta,Text).
%Ejemplo: cartaString([1,2,3,4],A).
cartaString(Carta,Text):-
    atomics_to_string(Carta, ', ', CartaSeparada),
    string_concat("Carta: ", CartaSeparada, TextoBonito),
    string_concat(TextoBonito,"\n ",Text).

%Predicado que pasa una lista de cartas a string.
%Cartas = Cartas (list)
%Acum= Acumulación de texto de cartas (str)
%F = Cartas pasadas a texto (str)
%Dominio = Carta x Acum x F
%cartasString(Cartas,Acum, F).
%cartasString([[1,2,3,4],[1,5,6,7]],"",A).
cartasString([],F,F).
cartasString([Carta|Resto],Acum,F):-
    cartaString(Carta,T),
    string_concat(T,Acum,Acum2),
    cartasString(Resto,Acum2,F).

%Predicado que verifica carta por carta si pertenecen a un conjunto válido de Dobble.
%CS = Conjunto de cartas.
%Dominio = CS. (list)
%verificarDobble(CS).
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
%-------------------------------------------------------------------------

%FUNCIONES DEL TDA GAME
%-------------------------------------------------------------------------
%TDA tdaGame
%NP = Número de jugadores (int)
%CS = TDA Cards (tdaCards)
%M = Modo de juego (str)
%R = Semilla random para funcion pseudoaleatoria (int)
%Pl = Lista de jugadores (list)
%T = Turno del jugador (str)
%Po = Puntuacion de los jugadores (list)
%S = Estado del juego (str)
%Me = Mesa con las cartas dadas vuelta (list)
%tdaCards(NP,CS,M,R,Pl,T,Po,S,[NP,CS,M,R,Pl,T,Po,S]
tdaGame(NP,CS,M,R,Pl,T,Po,S,Me,[NP,CS,M,R,Pl,T,Po,S,Me]).

%gettersTdaGame
getNumP([NP,_,_,_,_,_,_,_,_],NP).
getCS([_,CS,_,_,_,_,_,_,_],CS).
getMode([_,_,M,_,_,_,_,_,_],M).
getR([_,_,_,R,_,_,_,_,_],R).
getPlayers([_,_,_,_,Pl,_,_,_,_],Pl).
getTurno([_,_,_,_,_,T,_,_,_],T).
getPoints([_,_,_,_,_,_,Po,_,_],Po).
getStatus([_,_,_,_,_,_,_,S,_],S).
getMesa([_,_,_,_,_,_,_,_,Me],Me).

%Predicado que pasa una lista de jugadores a string.
%Players = Lista de jugadores (list)
%Text= Jugadores pasado a texto (str)
%Dominio = Players x Text
%playersString(Players,Text).
playersString(Players,Text):-
    atomics_to_string(Players, ', ', JugadoresSeparados),
    string_concat("Jugador: ", JugadoresSeparados, TextoBonito),
    string_concat(TextoBonito,"\n ",Text).

%Predicado que pasa una lista de puntos a string.
%Points = Lista de jugadores (list)
%Text= Puntos pasado a texto (str)
%Dominio = Points x Text
%pointsString(Points,Text).
pointsString(Points,Text):-
    atomics_to_string(Points, ', ', PointsSeparados),
    string_concat("Puntuación: ", PointsSeparados, TextoBonito),
    string_concat(TextoBonito,"\n ",Text).

%Predicado que pasa una mesa a string.
%Mesa = Lista de la mesa (list)
%Text= Mesa pasada a texto (str)
%Dominio = Mesa x Text
%pointsString(Points,Text).
mesaString([],T):-
    string_concat("No hay cartas", " en la mesa.\n",T),!.
mesaString(Mesa,Text):-
    atomics_to_string(Mesa, ', ', MesaSeparados),
    string_concat("Carta en Mesa: ", MesaSeparados, TextoBonito),
    string_concat(TextoBonito,"\n ",Text).

%Predicado que agrega un jugador a la lista de jugadores
%User = Usuario a agregar (str)
%PL = Lista de jugadores (list)
%C = Contador que indica si el jugador existe (int)
%PF = Lista de jugadores actualizado (list)
%Dominio = User x PL x C x PF
%agregarJugador(User,PL,C,PF).
agregarJugador(_,GO,1,GO).
agregarJugador(User,[NP,CS,M,R,Pl,T,Po,S,Me],0,GO):-
    addFinish(User,Pl,Pl2),
    tdaGame(NP,CS,M,R,Pl2,T,Po,S,Me,GO).

%Predicado que verifica un turno
%Ta = Turno actual (str)
%Lp = Lista de jugadores (list)
%Tf = Turno a entregar (str)
%Dominio: Ta x Lp x Tf
%verificarTurno(Ta,Lp,Tf).
verificarTurno("",[P|_],P).
verificarTurno(P,_,P).

%Predicado que agrega puntaje a un jugador
%Pl = Lista de jugadores (list)
%User = Nombre de usuario (str)
%Ver = Verificador de si el usuario merece los puntos (int)
%Po = Lista de puntajes (list)
%PF = Lista de puntajes actualizados (list)
%Dominio = Pl x User x Ver x Po x PF
%agregarPuntaje(Pl,User,Ver,Po,PF).
agregarPuntaje(_,_,0,Po,Po).
agregarPuntaje(_,_,1,Po,Po).
agregarPuntaje(Pl,Username,2,Po,PF):-
    getPosElement(Username,Pl,0,Pos),
    borrarAt(Pos,Po,Po2),
    insertarAt(2,Pos,Po2,PF),!.
%-------------------------------------------------------------------------


%PREDICADOS GENERALES OBLIGATORIOS
%-------------------------------------------------------------------------
%Predicado que crea un TDA Cards.
%Elements = Lista de elementos que puede contener una carta. (list)
%NumE = Número de elementos por carta (int). 
%MaxC = Número máximo de cartas como corte. Si no hay, entregará todo lo que puede generar. (int) 
%Seed = número para la función pseudoaleatoria. (int)
%CS = TDA Cards que contiene los elementos y las cartas generadas. (list)
%Dominio: Elements x NumE x MaxC x Seed
%Recorrido: CS
%cardsSet(Elements,NumE,MaxC,Seed,CS).
%cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 3,5,1239,CS).
%cardsSet([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z], 3,5,1239,CS).
%cardsSet([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z], 3,5,1503,CSA1).
%cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13,14],4,A,1705,CSB1).
%cardsSet(["Estrella","Corazón","Círculo","Cuadrado","Triángulo","Patata","Comodín","Serotonina"],2,A,1584,CSC1).
cardsSet(Elements,NumE,MaxC,Seed,CS):-
    NumE2 is NumE-1,
    for1(Elements,NumE2,[],Cards1),
    for2(Elements,NumE2,NumE2,1,[],Cards2),
    for3(Elements,NumE2,NumE2,1,[],[],Cards3),
    append(Cards3,CardsAppend3),
    join(Cards1,Cards2,CardsJoined1),
    join(CardsJoined1,CardsAppend3,F),
    largoLista(F,NumCartas),
    verificarMaxC(MaxC,NumCartas,MaxC),
    limitadorDeCartas(F,MaxC,MaxC,[],F2),
    randomList(Seed,F2,[],CR),
    tdaCards(Elements,CR,CS),!.

%Función que verifica si un mazo de cartas es un conjunto válido de Dobble.
%CS = TDA Cards. (tdaCards)
%Dominio: CS. (list)
%Recorrido: true or false. (bool)
%verificarDobble(CS).
%EJEMPLOS:
%cardsSet([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z], 3,5,1503,CSA1),cardsSetIsDobble(CSA1).
%cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13,14],4,A,1705,CSB1),cardsSetIsDobble(CSB1).
%cardsSet(["Estrella","Corazón","Círculo","Cuadrado","Triángulo","Patata","Comodín","Serotonina"],2,A,1584,CSC1),cardsSetIsDobble(CSC1).
cardsSetIsDobble(CS):-
    getCards(CS,Cards),
    verificarDobble(Cards).

%Función que entrega una carta de muestra en una cierta posición.
%CS = TDA Cards. (tdaCards)
%P = Posición de la carta que se desea obtener. (int)
%CS2 = Carta pedida. (list)
%Dominio: CS x P
%Recorrido: CS2
%cardsSetNthCard(CS,P,CS2).
%EJEMPLOS:
%cardsSet([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z], 3,5,1503,CSA1),cardsSetNthCard(CSA1,2,CA).
%cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13,14],4,A,1705,CSB1),cardsSetNthCard(CSB1,6,CB).
%cardsSet(["Estrella","Corazón","Círculo","Cuadrado","Triángulo","Patata","Comodín","Serotonina"],2,A,1584,CSC1),cardsSetNthCard(CSC1,0,CC).
cardsSetNthCard(CS,P,CS2):-
    getCards(CS,Cards),
    getElmPos(Cards,P,CS2),!.

%Predicado que con una carta de muestra determina la máxima cantidad de cartas que se pueden generar.
%C2 = Carta de muestra. (list)
%TC = Número máximo de cartas que se pueden generar. (int)
%Dominio: C2
%Recorrido: TC
%cardsSetFindTotalCards(C2,TC).
%EJEMPLOS:
%cardsSet([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z], 3,5,1503,CSA1),cardsSetNthCard(CSA1,2,CA1),cardsSetFindTotalCards(CA1,TCA).
%cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13,14],4,A,1705,CSB1),cardsSetNthCard(CSB1,0,CB1),cardsSetFindTotalCards(CB1,TCB).
%cardsSet(["Estrella","Corazón","Círculo","Cuadrado","Triángulo","Patata","Comodín","Serotonina"],2,A,1584,CSC1),cardsSetNthCard(CSC1,0,CC),cardsSetFindTotalCards(CC,TCC).
cardsSetFindTotalCards(C2,TC):-
    largoLista(C2,N),
    N2 is N-1,
    TC is N2*N2 + N2 + 1.

%Predicado que genera las cartas que le faltan a un conjunto inicial.
%CS = TDA Cards. (tdaCards)
%CS2 = Conjunto de cartas restantes. (list)
%Dominio: CS
%Recorrido CS2
%cardsSetMissingCards(CS,CS2).
%EJEMPLOS:
%cardsSet([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z], 3,3,1503,CSA1),cardsSetMissingCards(CSA1,CSA2).
%cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13,14],4,2,1705,CSB1),cardsSetMissingCards(CSB1,CSB2).
%cardsSet(["Estrella","Corazón","Círculo","Cuadrado","Triángulo","Patata","Comodín","Serotonina"],2,1,1584,CSC1),cardsSetMissingCards(CSC1,CSC2).
cardsSetMissingCards(CS,CS2):-
    cardsSetNthCard(CS,0,Card),
	cardsSetFindTotalCards(Card,TC),
    getCards(CS,CSi),
    cardsSetNthCard(CS,0,CA),
    largoLista(CA,Ne),
    getElements(CS,Elements),
    cardsSet(Elements, Ne, TC, TC, CSF),
    getCards(CSF, CSf),
    eliminarRepetidos(CSi,CSf,CS2).

%Predicado que transforma un conjunto de cartas es una cadena de texto para ser vista por display.
%CS = TDA Cards. (tdaCards)
%CS_STR = Conjunto de cartas en string. (str)
%cardsSetToString(CS,CS_STR).
%EJEMPLOS:
%cardsSet([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z], 3,5,1503,CSA1),cardsSetToString(CSA1,CSAString).
%cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13,14],4,A,1705,CSB1),cardsSetToString(CSB1,CSBString).
%cardsSet(["Estrella","Corazón","Círculo","Cuadrado","Triángulo","Patata","Comodín","Serotonina"],2,A,1584,CSC1),cardsSetToString(CSC1,CSCString).
cardsSetToString(CS,CS_STR):-
    getCards(CS,Cartas),
    cartasString(Cartas,"",CS_STR).

%Predicado que crea el TDA Game con los elementos del juego.
%NumPlayers = Número de jugadores (int)
%CardsSet = TDA Cards (tdaCards)
%Mode = Modo de juego (str)
%Seed = Semilla random para funcion pseudoaleatoria (int)
%Game = TDA Game 
%Dominio: NumPlayers x CardsSet x Mode x Seed x Game
%EJEMPLOS:
%cardsSet([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z], 3,5,1503,CSA1),dobbleGame(2,CSA1,"modoX",1234,GA).
%cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13,14],4,A,1705,CSB1),dobbleGame(3,CSB1,"modoY",2345,GB).
%cardsSet(["Estrella","Corazón","Círculo","Cuadrado","Triángulo","Patata","Comodín","Serotonina"],2,A,1584,CSC1),dobbleGame(4,CSC1,"modoZ",4567,GC).
dobbleGame(NumPlayers, CardsSet, Mode, Seed, Game):-
    getCards(CardsSet,Cards),
    insertarVarios(NumPlayers,0,[],Po),
    tdaGame(NumPlayers,Cards,Mode,Seed,[],"",Po,"En Partida",[],Game).

%Predicado que registra un nuevo jugador en la partida.
%User= Nombre del usuario a ingresar (str)
%GameIn = TDA Game inicial (tdaGame)
%GameOut = TDA Game final (tdaGame)
%Dominio: User x GameIn x GameOut
%Ejemplos:
%cardsSet([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z], 3,5,1503,CSA1),dobbleGame(2,CSA1,"modoX",1234,GA),dobbleGameRegister("Roberto Gonzalez",GA,GA2),dobbleGameRegister("Gonzalo Martinez",GA2,GA3).
%cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13,14],4,A,1705,CSB1),dobbleGame(3,CSB1,"modoY",2345,GB),dobbleGameRegister("Victor Flores",GB,GB2),dobbleGameRegister("Victor Truco",GB2,GB3),dobbleGameRegister("Comodín Paradigmas",GB3,GB4).
%cardsSet(["Estrella","Corazón","Círculo","Cuadrado","Triángulo","Patata","Comodín","Serotonina"],2,A,1584,CSC1),dobbleGame(4,CSC1,"modoZ",4567,GC),dobbleGameRegister("Scheme",GC,GC2),dobbleGameRegister("Prolog",GC2,GC3),dobbleGameRegister("Java",GC3,GC4),dobbleGameRegister("Pudín",GC4,GC5).
dobbleGameRegister(User,GameIn,GameOut):-
    getPlayers(GameOut,Players),
    pertenece(User,Players,I),
    agregarJugador(User,GameOut,I,GameIn),!.
dobbleGameRegister(User,GameIn,GameOut):-
    getPlayers(GameIn,Players),
    pertenece(User,Players,I),
    agregarJugador(User,GameIn,I,GameOut),!.

%Predicado que permite obtener el turno del usuario
%Game: TDA Game (tdaGame)
%Username: Usuario al cual le pertenece el turno (str)
%Dominio: Game x Username
%EJEMPLOS:
%cardsSet([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z], 3,5,1503,CSA1),dobbleGame(2,CSA1,"modoX",1234,GA),dobbleGameRegister("Roberto Gonzalez",GA,GA2),dobbleGameRegister("Gonzalo Martinez",GA2,GA3),dobbleGameWhoseTurnIsIt(GA3,UA1).
%cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13,14],4,A,1705,CSB1),dobbleGame(3,CSB1,"modoY",2345,GB),dobbleGameRegister("Victor Flores",GB,GB2),dobbleGameRegister("Victor Truco",GB2,GB3),dobbleGameRegister("Comodín Paradigmas",GB3,GB4),dobbleGameWhoseTurnIsIt(GB4,UB1).
%cardsSet(["Estrella","Corazón","Círculo","Cuadrado","Triángulo","Patata","Comodín","Serotonina"],2,A,1584,CSC1),dobbleGame(4,CSC1,"modoZ",4567,GC),dobbleGameRegister("Scheme",GC,GC2),dobbleGameRegister("Prolog",GC2,GC3),dobbleGameRegister("Java",GC3,GC4),dobbleGameRegister("Pudín",GC4,GC5),dobbleGameWhoseTurnIsIt(GC5,UC1).
dobbleGameWhoseTurnIsIt(Game,Username):-
    getPlayers(Game,PlayerList),
    getTurno(Game,Turno),
    verificarTurno(Turno,PlayerList,Username),!.

%Predicado que permite realizar una jugada a partir de la acción especificadas en el segundo argumento.
%Game = TDA Game inicial (tdaGame)
%Action = Lista de string que determina la acción a realizar en el juego (str list)
%Game2 = TDA Game final (tdaGame)
%EJEMPLOS:
%cardsSet([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z], 3,5,1503,CSA1),dobbleGame(2,CSA1,"modoX",1234,GA),dobbleGameRegister("Roberto Gonzalez",GA,GA2),dobbleGameRegister("Gonzalo Martinez",GA2,GA3),dobbleGamePlay(GA3,null,GA4),dobbleGamePlay(GA4,[spotit,"Roberto Gonzalez",b],GA5),dobbleGamePlay(GA5,[pass],GA6),dobbleGamePlay(GA6,null,GA7),dobbleGamePlay(GA7,[spotit,"Gonzalo Martinez",g],GA8),dobbleGamePlay(GA8,[finish],GA9).
%cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13,14],4,A,1705,CSB1),dobbleGame(3,CSB1,"modoY",2345,GB),dobbleGameRegister("Victor Flores",GB,GB2),dobbleGameRegister("Victor Truco",GB2,GB3),dobbleGameRegister("Comodín Paradigmas",GB3,GB4),dobbleGamePlay(GB4,null,GB5),dobbleGamePlay(GB5,[spotit,"Victor Flores",1],GB6),dobbleGamePlay(GB6,[pass],GB7),dobbleGamePlay(GB7,null,GB8),dobbleGamePlay(GB8,[spotit,"Victor Truco",13],GB9),dobbleGamePlay(GB9,[finish],GC10).
%cardsSet(["Estrella","Corazón","Círculo","Cuadrado","Triángulo","Patata","Comodín","Serotonina"],2,A,1584,CSC1),dobbleGame(4,CSC1,"modoZ",4567,GC),dobbleGameRegister("Scheme",GC,GC2),dobbleGameRegister("Prolog",GC2,GC3),dobbleGameRegister("Java",GC3,GC4),dobbleGameRegister("Pudín",GC4,GC5),dobbleGamePlay(GC5,null,GC6),dobbleGamePlay(GC6,[spotit,"Scheme","Estrella"],GC7),dobbleGamePlay(GC7,[pass],GC8),dobbleGamePlay(GC8,null,GC9),dobbleGamePlay(GC9,[spotit,"Prolog","Círculo"],GC10),dobbleGamePlay(GC10,[finish],GC11).
dobbleGamePlay([NP,CS,M,R,Pl,T,Po,_,_],[finish],Game2):-
    tdaGame(NP,CS,M,R,Pl,T,Po,"Terminado",[],Game2),!.
dobbleGamePlay([NP,CS,M,R,Pl,T,Po,S,_],[pass],Game2):-
    verificarTurno(T,Pl,User),
    getPosElement(User,Pl,0,Pos),
    Pos2 is Pos+1,
    Pos3 is Pos2 mod NP,
    getElmPos(Pl,Pos3,T2),
    tdaGame(NP,CS,M,R,Pl,T2,Po,S,[],Game2),!.
dobbleGamePlay([NP,CS,M,R,Pl,T,Po,S,Me],[spotit,Username,Element],Game2):-
    verificarTurno(T,Pl,Username),
    car(Me,C1),
    cdr(Me,[C2|_]),
    pertenece(Element,C1,S1),
    pertenece(Element,C2,S2),
    S3 is S1+S2,
    agregarPuntaje(Pl,Username,S3,Po,PF),
    tdaGame(NP,CS,M,R,Pl,T,PF,S,Me,Game2),!.
dobbleGamePlay([NP,CS,M,R,Pl,T,Po,S,_],null,Game2):-
    randomList(R,CS,[],CR),
    car(CR,C1),
    cdr(CR,[C2|_]),
    addFinish(C1,[],Me1),
    addFinish(C2,Me1,Me2),
    R2 is R-1 ,
    tdaGame(NP,CS,M,R2,Pl,T,Po,S,Me2,Game2),!.

%Predicado que relaciona un TDA de juego con su estado actual.
%Game = TDA Game inicial (tdaGame)
%Status = Estado del juego (str)
%EJEMPLOS:
%cardsSet([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z], 3,5,1503,CSA1),dobbleGame(2,CSA1,"modoX",1234,GA),dobbleGameRegister("Roberto Gonzalez",GA,GA2),dobbleGameRegister("Gonzalo Martinez",GA2,GA3),dobbleGamePlay(GA3,null,GA4),dobbleGamePlay(GA4,[spotit,"Roberto Gonzalez",b],GA5),dobbleGamePlay(GA5,[pass],GA6),dobbleGamePlay(GA6,null,GA7),dobbleGamePlay(GA7,[spotit,"Gonzalo Martinez",g],GA8),dobbleGamePlay(GA8,[finish],GA9),dobbleGameStatus(GA9,SA).
%cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13,14],4,A,1705,CSB1),dobbleGame(3,CSB1,"modoY",2345,GB),dobbleGameRegister("Victor Flores",GB,GB2),dobbleGameRegister("Victor Truco",GB2,GB3),dobbleGameRegister("Comodín Paradigmas",GB3,GB4),dobbleGamePlay(GB4,null,GB5),dobbleGamePlay(GB5,[spotit,"Victor Flores",1],GB6),dobbleGamePlay(GB6,[pass],GB7),dobbleGameStatus(GB7,SB).
%cardsSet(["Estrella","Corazón","Círculo","Cuadrado","Triángulo","Patata","Comodín","Serotonina"],2,A,1584,CSC1),dobbleGame(4,CSC1,"modoZ",4567,GC),dobbleGameRegister("Scheme",GC,GC2),dobbleGameRegister("Prolog",GC2,GC3),dobbleGameRegister("Java",GC3,GC4),dobbleGameRegister("Pudín",GC4,GC5),dobbleGamePlay(GC5,null,GC6),dobbleGamePlay(GC6,[spotit,"Scheme","Estrella"],GC7),dobbleGameStatus(GC7,SC).
dobbleGameStatus(Game,Status):-
    getStatus(Game,Status).

%Predicado que relaciona un TDA de juego con el puntaje de un jugador a partir de su nombre de usuario.
%Game = TDA Game inicial (tdaGame)
%Username = Nombre del jugador (str)
%Score = Puntaje del jugador (int)
%EJEMPLOS:
%cardsSet([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z], 3,5,1503,CSA1),dobbleGame(2,CSA1,"modoX",1234,GA),dobbleGameRegister("Roberto Gonzalez",GA,GA2),dobbleGameRegister("Gonzalo Martinez",GA2,GA3),dobbleGamePlay(GA3,null,GA4),dobbleGamePlay(GA4,[spotit,"Roberto Gonzalez",b],GA5),dobbleGamePlay(GA5,[pass],GA6),dobbleGamePlay(GA6,null,GA7),dobbleGamePlay(GA7,[spotit,"Gonzalo Martinez",g],GA8),dobbleGamePlay(GA8,[finish],GA9),dobbleGameScore(GA9,"Gonzalo Martinez",SA).
%cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13,14],4,A,1705,CSB1),dobbleGame(3,CSB1,"modoY",2345,GB),dobbleGameRegister("Victor Flores",GB,GB2),dobbleGameRegister("Victor Truco",GB2,GB3),dobbleGameRegister("Comodín Paradigmas",GB3,GB4),dobbleGamePlay(GB4,null,GB5),dobbleGamePlay(GB5,[spotit,"Victor Flores",1],GB6),dobbleGamePlay(GB6,[pass],GB7),dobbleGamePlay(GB7,null,GB8),dobbleGamePlay(GB8,[spotit,"Victor Truco",13],GB9),dobbleGamePlay(GB9,[finish],GC10),dobbleGameScore(GC10,"Victor Truco",SB).
%cardsSet(["Estrella","Corazón","Círculo","Cuadrado","Triángulo","Patata","Comodín","Serotonina"],2,A,1584,CSC1),dobbleGame(4,CSC1,"modoZ",4567,GC),dobbleGameRegister("Scheme",GC,GC2),dobbleGameRegister("Prolog",GC2,GC3),dobbleGameRegister("Java",GC3,GC4),dobbleGameRegister("Pudín",GC4,GC5),dobbleGamePlay(GC5,null,GC6),dobbleGamePlay(GC6,[spotit,"Scheme","Estrella"],GC7),dobbleGamePlay(GC7,[pass],GC8),dobbleGamePlay(GC8,null,GC9),dobbleGamePlay(GC9,[spotit,"Prolog","Círculo"],GC10),dobbleGamePlay(GC10,[finish],GC11),dobbleGameScore(GC11,"Scheme",SC).
dobbleGameScore(Game,Username,Score):-
      getPlayers(Game,Players),
      getPoints(Game,Points),
      getPosElement(Username,Players,0,Pos),
      getElmPos(Points,Pos,Score),!.

%Predicado que transforma un conjunto de cartas es una cadena de texto para ser vista por display.
%CS = TDA Cards. (tdaCards)
%CS_STR = Conjunto de cartas en string. (str)
%cardsSetToString(CS,CS_STR).
%EJEMPLOS:
%cardsSet([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z], 3,5,1503,CSA1),dobbleGame(2,CSA1,"modoX",1234,GA),dobbleGameRegister("Roberto Gonzalez",GA,GA2),dobbleGameRegister("Gonzalo Martinez",GA2,GA3),dobbleGamePlay(GA3,null,GA4),dobbleGamePlay(GA4,[spotit,"Roberto Gonzalez",b],GA5),dobbleGamePlay(GA5,[pass],GA6),dobbleGamePlay(GA6,null,GA7),dobbleGamePlay(GA7,[spotit,"Gonzalo Martinez",g],GA8),dobbleGamePlay(GA8,[finish],GA9),dobbleGameToString(GA9,StA).
%cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13,14],4,A,1705,CSB1),dobbleGame(3,CSB1,"modoY",2345,GB),dobbleGameRegister("Victor Flores",GB,GB2),dobbleGameRegister("Victor Truco",GB2,GB3),dobbleGameRegister("Comodín Paradigmas",GB3,GB4),dobbleGamePlay(GB4,null,GB5),dobbleGamePlay(GB5,[spotit,"Victor Flores",1],GB6),dobbleGamePlay(GB6,[pass],GB7),dobbleGamePlay(GB7,null,GB8),dobbleGamePlay(GB8,[spotit,"Victor Truco",13],GB9),dobbleGamePlay(GB9,[finish],GB10),dobbleGameToString(GB10,StB).
%cardsSet(["Estrella","Corazón","Círculo","Cuadrado","Triángulo","Patata","Comodín","Serotonina"],2,A,1584,CSC1),dobbleGame(4,CSC1,"modoZ",4567,GC),dobbleGameRegister("Scheme",GC,GC2),dobbleGameRegister("Prolog",GC2,GC3),dobbleGameRegister("Java",GC3,GC4),dobbleGameRegister("Pudín",GC4,GC5),dobbleGamePlay(GC5,null,GC6),dobbleGamePlay(GC6,[spotit,"Scheme","Estrella"],GC7),dobbleGamePlay(GC7,[pass],GC8),dobbleGameToString(GC8,StC).
dobbleGameToString(G,Str):-
    getNumP(G,NP),
	string_concat("Número de jugadores: ", NP, T11),
	string_concat(T11,"\n ",T12),
    getCS(G,CS),
    cartasString(CS,"",T21),
    getMode(G,M),
	string_concat("Modo de juego: ", M, T31),
	string_concat(T31,"\n ",T32),
    getPlayers(G,Pl),
	playersString(Pl,T41),
    dobbleGameWhoseTurnIsIt(G,T),
	string_concat("Turno de: ", T, T51),
	string_concat(T51,"\n ",T52),
    getPoints(G,Po),
	pointsString(Po,T61),
    getStatus(G,S),
	string_concat("Estado del juego: ", S, T71),
	string_concat(T71,"\n ",T72),
    getMesa(G,Me),
    mesaString(Me,T81),
    string_concat(T12,T21,TF1),
	string_concat(TF1,T32,TF2),
	string_concat(TF2,T41,TF3),
	string_concat(TF3,T52,TF4),
	string_concat(TF4,T61,TF5),
	string_concat(TF5,T72,TF6),
    string_concat(TF6,T81,Str).