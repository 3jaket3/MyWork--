clear
clc

numlines = 6;
maxlength = 20;
PQ1 = PriorityQueueLines(100);
PQ2 =PriorityQueueLines(100);
RB = Red_Black_Tree_Lines(10);
X = zeros(numlines,2);
Y = zeros(numlines,2);
Lines = Line.empty(numlines,0);
L1 = Line(maxlength);
L2 = Line(maxlength);
L3 = Line(maxlength);
L4 = Line(maxlength);
L5 = Line(maxlength);
L6 = Line(maxlength);

N1 = Node(L1);
N2 = Node(L2);
N3 = Node(L3);
N4 = Node(L4);
N5 = Node(L5);
N6 = Node(L6);

RB = RB.Insert(N1);
RB = RB.Insert(N2);
RB = RB.Insert(N3);
RB = RB.Insert(N4);
RB = RB.Insert(N5);
RB = RB.Insert(N6);

RB = RB.Delete(RB.Find(N1));
RB = RB.Delete(RB.Find(N2));
RB = RB.Delete(RB.Find(N3));
RB = RB.Delete(RB.Find(N4));
RB = RB.Delete(RB.Find(N5));
RB = RB.Delete(RB.Find(N6));

