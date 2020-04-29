using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ropes
{
	class Rope
	{
		public class Node
		{
			public string S;
			public int Length;
			public Node Left, Right, Parent;
			/*
	private class node contains the string and its length for a leaf node
	for a internal node the string is null and the length is the total length of all nodes below
	the node also contains the parent pointer and left and right pointer for that node
*/
			public Node(string s)
			{
				S = s;
				Length = s.Length;
				Left = Right = Parent = null;
			}
			public Node()
			{
				S = null;
				Length = 0;
				Left = Right = Parent = null;
			}

		}

		public Node Root = null;
		/*
	public class Rope contains the node class and a private node called root(made public during testing)	
*/
		/*
			the constorctor class for rope returns a empty node if passed null 
			otherwise the constructor calls a private method called rope and sets the root to the root of the tree
			created in the ropes method (ropes is a builder)	
		*/
		public Rope(string s)
		{
			if (s == null)
			{
				Root = new Node();
				return;
			}
			Root = Ropes(s, Root, s.Length, s.Length);

		}
		/*
	the private method ropes takes a string starting at the end and recusively calls 
	adding to the rope before finaly returning the first node created
	
	generates:
         0
        / \
       0   0 
      / \
     0   0
    / \
   0   0
*/
		private Node Ropes(string s, Node N, int index, int L)
		{
			if (index > 1)
			{
				N = new Node();
				N.Right = new Node(s.Substring(index - 1, 1));
				N.Right.Parent = N;
				N.Left = Ropes(s, N.Left, index - 1, index);
				N.Left.Parent = N;

			}
			else
			{
				N = new Node(s.Substring(0, index));
			}
			if (N.Right != null && N.Left != null)
				N.Length = N.Right.Length + N.Left.Length;
			return N;
		}
		/* 
	concatinate takes two ropes and puts them together the first rope passed is put on the left
	of a new root and the second rope passed is put on the right of the new root
	parent pointers and lengths of nodes are updated
	
	generates:
	NewRoot
	  /\
	 A  B
*/
		public Rope Concatinate(Rope R1, Rope R2)
		{
			Rope R = new Rope(null);
			R.Root.Left = R1.Root;
			R.Root.Right = R2.Root;
			R1.Root.Parent = R.Root;
			R2.Root.Parent = R.Root;
			R.Root.Length = R1.Root.Length + R2.Root.Length;
			return R;
		}
		/*
	CharAt searches recursively for the node that contains the char then selects the char from that node
	due to indexing the search was split into a left and right side
	public CharAt calls the private char at the private char at also moves the parent node to the root
	this makes subsequent calls to CharAt at the same or near the same index faster
*/
		public char CharAt(int index)
		{
			if (Root.Left.Length > index)
			{
				return CharAtLeft(index, Root, Root.Length, false);
			}
			else
			{
				return CharAtRight(index, Root.Right, Root.Left.Length, false);
			}
		}

		private char CharAtRight(int index, Node N, int Pindex, Boolean isLeft)
		{
			if (N.Left != null && N.Right != null)
			{
				if (index >= Pindex && index < Pindex + N.Left.Length)
				{
					return CharAtRight(index, N.Left, Pindex, true);
				}
				else
				{
					return CharAtRight(index, N.Right, Pindex + N.Left.Length, false);
				}
			}


			this.Splay(N.Parent);
			return N.S[0];


		}

		private char CharAtLeft(int index, Node N, int Pindex, Boolean isLeft)
		{

			if (N.Left != null && N.Right != null)
			{
				if (index < N.Length - N.Right.Length)
				{

					return CharAtLeft(index, N.Left, Pindex - N.Right.Length, true);
				}
				else
				{

					return CharAtLeft(index, N.Right, Pindex, false);
				}
			}

			if (isLeft)
			{
				this.Splay(N.Parent);
				return N.S[0];
			}
			else
			{
				this.Splay(N.Parent);
				return N.S[0];
			}
		}

		

		public int Find(string s)
		{
			return Find(s, Root, 0, -1);
		}
		/*
	the Find method calls the private find method the private method searches --><--- and returns the first occurances it finds
	(i later realized that the assignment specifies first occurance and this may not do that but the search in a pdf is for all occurances
	and this may run faster if finding all occurances if multiple threads where used
	Find calls CharAt once the first or last character matches it searches to see if the next characters in proper sequence also match if
	so it returns the index of this occurance
*/
		public int Find2(string s)
		{
			double x = Math.Ceiling((double)Root.Length / 2);

			for (int i = 0; i < x; i++)
			{
				int j = i;
				int z = 0;
				while (CharAt(j) == s[z])
				{
					if (z == s.Length - 1)
						return i;
					j++;
					z++;
				}

				j = 0;
				while (CharAt(Root.Length - j - 1) == s[s.Length - 1 - j])
				{
					j++;
					if (j == s.Length)
						return Root.Length - j;
				}


			}
			return -1;
		}

		private int Find(string s, Node N, int Pindex, int index)
		{

			if (N.S != null)
			{
				if (N.S.Contains(s))
				{
					int subindex = N.S.IndexOf(s);
					index = Pindex + subindex;
					this.Splay(N.Parent);
					return index;
				}
			}

			if (N.Left != null)
			{
				if (index == -1)
					index = Find(s, N.Left, Pindex, index);

			}
			if (N.Right != null)
			{
				if (index == -1)
					index = Find(s, N.Right, Pindex + N.Left.Length, index);
			}

			return index;
		}

		/*
	the Print method traverses the tree in order from leftmost node to rightmost node
	each time it reaches a leaf node it adds the contents of that node to the string s
	then it returns and prints that string
*/
		public void Print()
		{
			Print(Root);
			Console.WriteLine();
		}

		private void Print(Node N)
		{
			if (N.Left != null)
			{
			   	Print(N.Left);
			}
			if (N.Right != null)
			{
			   Print(N.Right);
			}
			if (N.Right == null && N.Left == null)
			{
				Console.Write(N.S);
				
			}

			
		}
		/*
	The Split Node method takes a index and two ropes(these ropes are split versions of the Rope Passed to the Split Function)
	then based on the index takes either the leftmost node of the right split or the rightmost node of the left split and splits this node
	to split the node(it assigns one half back in its original spot and concatinates the other half to the proper side of the other rope)

	generate example

    1:	0    2:  0              1':    0        0
       / \      / \   ----->          / \      / \ 
      0  AB    0   0                 0   A    B   0
                                                 / \
                                                0   0

			in theory if the right node is splayed to the root the the leftmost or rightmost child should be the node that is spit 
			or no node would need to be split
*/ 
		private Tuple<Rope, Rope> SplitNode(int index, Rope N, Rope M)
		{

			if (N.Root.Length == index || M.Root.Length == index)
			{
				return new Tuple<Rope, Rope>(N, M);
			}
			else if (index > N.Root.Length)
			{
				Node X = M.Root;
				while (X.Left != null && X.Right != null)
				{
					if (X.Left != null)
					{
						X = X.Left;
					}
					else
					{
						X = X.Right;
					}
				}

				index = X.Length - (index - N.Root.Length);
				string temp = X.S;
				
				string left = temp.Substring(0, index);
				string right = temp.Substring(index, X.Length - index);
				Rope Left = new Rope(left);
				X.S = right;
				X.Length = right.Length;
				while (X.Parent != null)
				{
					X.Parent.Length -= left.Length;
					X = X.Parent;
				}

				N = Concatinate(N, Left);
				return new Tuple<Rope, Rope>(N, M);





			}
			return new Tuple<Rope, Rope>(N, M);
		}


		/*
	Split takes a rope and rotates the parent of the index to the root
	then splits this node into two new ropes and sets the proper pointers
	then calls split node to split the node.

	rebalance(index) ---->  split tree at root ----> split node
*/


		public Tuple<Rope, Rope> Split2(int index)
		{
			this.CharAt(index);
			return Split2(index, Root, Root.Length);
		}

		private Tuple<Rope, Rope> Split2(int index, Node N, int Pindex)
		{



			Rope R1 = new Rope(null);
			Rope R2 = new Rope(null);
			R1.Root = this.Root.Left;
			R2.Root = this.Root.Right;
			R1.Root.Parent = null;
			R2.Root.Parent = null;
			return new Tuple<Rope, Rope>(R1, R2);

		}
/*

	rebalance searches through the tree recursively to find the node where the index passed is stored
	then it uses the functionality of the splay tree to move this node to the root effectively 
	ballancing the treee about this point.
*/

		public void Rebalance(int index)
		{
			Rebalance(index, Root, Root.Length);
		}
		public void Rebalance(int index, Node N, int Pindex)
		{
			if (Root.Left != null)
			{
				if (index == Root.Left.Length)
					return;
			}
			if (N.Left != null && N.Right != null)
			{
				if (N.Length - N.Right.Length > index)
				{

					Rebalance(index, N.Left, Pindex - N.Right.Length);
				}

				else
				{

					Rebalance(index, N.Right, Pindex);
				}
			}
			else
			{
				Splay(N.Parent);
			}
		}

		public string Substring(int i, int j)
		{
			//Create empty String 
			string substring = "";

			//for each index from i to j
			for (int t = i; t <= j; t++)
			{
				//add the current letter to the substring
				substring += CharAt(t);
			}

			//return the substring
			return substring;
		}


		public int GetLength()
		{
			return Root.Length;
		}

		/* left and right pointers are swaped parent pointers are swaped and length is updated
		 * 
		 * 
		 */

		private void LeftRotate(Node X)
		{
			Node Y = X.Right;
			if (Y != null)
			{
				X.Right = Y.Left;
				if (Y.Left != null)
				{
					Y.Left.Parent = X;
				}
				Y.Parent = X.Parent;
			}

			if (X.Parent == null) Root = Y;
			else if (X == X.Parent.Left) X.Parent.Left = Y;
			else X.Parent.Right = Y;
			if (Y != null) Y.Left = X;
			X.Parent = Y;

			X.Length = X.Right.Length + X.Left.Length;
			Y.Length = Y.Right.Length + X.Right.Length;
		}

		private void RightRotate(Node X)
		{
			Node Y = X.Left;

			if (Y != null)
			{
				X.Left = Y.Right;
				if (Y.Right != null)
				{
					Y.Right.Parent = X;
				}
				Y.Parent = X.Parent;
			}

			if (X.Parent == null) Root = Y;
			else if (X == X.Parent.Left) X.Parent.Left = Y;
			else X.Parent.Right = Y;
			if (Y != null) Y.Right = X;
			X.Parent = Y;

			X.Length = X.Right.Length + X.Left.Length;
			Y.Length = Y.Right.Length + X.Right.Length;

		}

		private void Splay(Node X)
		{
			while (X.Parent != null)
			{

				if (X.Parent.Parent == null)
				{
					if (X.Parent.Left == X)
					{
						RightRotate(X.Parent); // one away from root
					}
					else
					{
						LeftRotate(X.Parent);
					}
				}
				else if (X.Parent.Left == X && X.Parent.Parent.Left == X.Parent) // Zigg left
				{
					RightRotate(X.Parent.Parent);
					RightRotate(X.Parent);
				}
				else if (X.Parent.Right == X && X.Parent.Parent.Right == X.Parent) // Zigg right
				{
					LeftRotate(X.Parent.Parent);
					LeftRotate(X.Parent);
				}
				else if (X.Parent.Left == X && X.Parent.Parent.Right == X.Parent) //Zig Zar right
				{
					RightRotate(X.Parent);
					LeftRotate(X.Parent);
				}
				else // Zig Zag left
				{
					LeftRotate(X.Parent);
					RightRotate(X.Parent);
				}


			}
			this.Root.Length = this.Root.Right.Length + this.Root.Left.Length; // update root node length
		}

		/* delete only works on a new rope because of a bug in either rebalance or splitnode that i couldnt fix
		 * if fixed the time complexity would be log(N) but because i couldnt fix it or find it delete
		 * runs in exponential time because Clone calls print and print traverses the entire tree
		 */



		public Rope Delete(int i, int j)
		{
			if (i == 0 && j == Root.Length)
			{
				return new Rope(null);
			}
			
			Tuple<Rope, Rope> Split1 = this.Split2(i);

			if (i == 0)
			{
				return Split1.Item2;
			}
			if (j == Root.Length)
			{
				return Split1.Item1;
			}
			else
			{
				Tuple<Rope, Rope> Split2 = Split1.Item2.Split2(j - i);
				return Concatinate(Split1.Item1, Split2.Item2);
			}

		}


		/* Same thing for insert would run in logrithmic time but instead runs in exponetial time
		 */
		public Rope Insert(Rope rope, string s, int i)
		{
			
			Tuple<Rope, Rope> Split1 = Split2(i);
			Rope R2 = new Rope(s);
			return Concatinate(Split1.Item1, Concatinate(R2, Split1.Item2));

		}


	}

}
 
 