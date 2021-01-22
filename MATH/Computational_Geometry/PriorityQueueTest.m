clear
clc

PQ = PriorityQueue(15);

PQ = PQ.Add(45);
PQ = PQ.Add(64);
PQ = PQ.Add(8);
PQ = PQ.Add(34);
PQ = PQ.Add(89);
PQ = PQ.Add(37);
PQ = PQ.Add(96);
PQ = PQ.Add(15);
PQ = PQ.Add(24);
PQ = PQ.Add(54);
PQ = PQ.Add(78);
PQ = PQ.Add(95);
PQ = PQ.Add(27);
PQ = PQ.Add(72);
PQ = PQ.Add(67);

while ( PQ.count > 1)
   fprintf(' %d',PQ.Front);
   PQ = Remove(PQ);
    
end

