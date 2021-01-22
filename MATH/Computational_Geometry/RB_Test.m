% RB - tree test;

clear
clc

A = Node(50);
B = Node(23);
C = Node(78);
D = Node(45);
E = Node(12);
F = Node(56);
G = Node(19);
H = Node(7);
I = Node(64);
J = Node(41);
K = Node(46);
L = Node(73);
M = Node(4);


Tree = Red_Black_Tree(A);
Tree = Tree.insert(B);
Tree = Tree.insert(C);
Tree = Tree.insert(D);
Tree = Tree.insert(E);
Tree = Tree.insert(F);
Tree = Tree.insert(G);
Tree = Tree.insert(H);
Tree = Tree.insert(I);
Tree = Tree.insert(J);
Tree = Tree.insert(K);
Tree = Tree.insert(L);
Tree = Tree.insert(M);


preorder(Tree,Tree.Root);

Tree = Tree.Delete(G);
Tree = Tree.Delete(D);
Tree = Tree.Delete(C);
Tree = Tree.Delete(A);
Tree = Tree.Delete(M);

preorder(Tree,Tree.Root);