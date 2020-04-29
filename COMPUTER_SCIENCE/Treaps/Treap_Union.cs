using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assignment2
{
	class Program
	{

		class myData
		{

			public string[] words = new string[1000];
			public myData()
			{
				
		        string filePath = @"C:mywords.txt";
				string line;
				


				System.IO.StreamReader lines = new System.IO.StreamReader(filePath);

				for (int i = 0; i < 1000; i++)
				{
					line = lines.ReadLine();
					if (i < 9)
					{
						line = line.Remove(0, 3);
					}
					else if (i < 99)
					{
						line = line.Remove(0, 4);
					}
					else if (i < 999)
					{
						line = line.Remove(0, 5);
					}
					else
					{
						line = line.Remove(0, 6);
					}
					words[i] = line;

				}
			}
		}

		public interface IContainer<T>
		{
			void MakeEmpty();
			bool Empty();
			int Size();
		}

		//-------------------------------------------------------------------------

		public interface ISearchable<T> : IContainer<T>
		{
			void Add(T item);
			void Remove(T item);
			bool Contains(T item);
		}

		//-------------------------------------------------------------------------

		// Generic node class for a Treap

		public class Node<T> where T : IComparable
		{
			private static Random R = new Random();

			// Read/write properties

			public T Item { get; set; }
			public int Priority { get; set; }
			public Node<T> Left { get; set; }
			public Node<T> Right { get; set; }

			public Node(T item)
			{
				Item = item;
				Priority = R.Next(10, 1300);
				Left = Right = null;
			}
		}

		//-------------------------------------------------------------------------

		// Implementation:  Treap

		class Treap<T> : ISearchable<T> where T : IComparable
		{
			private Node<T> Root;  // Reference to the root of the Treap

			// Constructor Treap
			// Creates an empty Treap
			// Time complexity:  O(1)

			public Treap()
			{
				MakeEmpty();
			}

			// LeftRotate
			// Performs a left rotation around the given root
			// Time complexity:  O(1)

			private Node<T> LeftRotate(Node<T> root)
			{
				Node<T> temp = root.Right;
				root.Right = temp.Left;
				temp.Left = root;
				return temp;
			}

			// RightRotate
			// Performs a right rotation around the given root
			// Time complexity:  O(1)

			private Node<T> RightRotate(Node<T> root)
			{
				Node<T> temp = root.Left;
				root.Left = temp.Right;
				temp.Right = root;
				return temp;
			}

			// Public Add
			// Inserts the given item into the Treap
			// Calls Private Add to carry out the actual insertion
			// Expected time complexity:  O(log n)

			public void Add(T item)
			{
				Root = Add(item, Root);
			}

			// Add 
			// Inserts item into the Treap and returns a reference to the root
			// Duplicate items are not inserted
			// Expected time complexity:  O(log n)
			private void AddMax(T item)
			{
				Root = AddMax(item, Root);
			}
			private Node<T> AddMax(T item, Node<T> root)
			{
				int cmp;  // Result of a comparison
				Node<T> max;
				if (root == null)
				{
					max = new Node<T>(item);
					max.Priority = 1400;
					return max;
				}
				else
				{
					cmp = item.CompareTo(root.Item);
					if (cmp > 0)
					{
						root.Right = AddMax(item, root.Right);       // Move right
						if (root.Right.Priority > root.Priority)  // Rotate left
							root = LeftRotate(root);              // (if necessary)
					}
					else if (cmp < 0)
					{
						root.Left = AddMax(item, root.Left);         // Move left
						if (root.Left.Priority > root.Priority)   // Rotate right
							root = RightRotate(root);             // (if necessary)
					}
					// else if (cmp == 0) ... do nothing
					return root;
				}
			}
			private Node<T> Add(T item, Node<T> root)
			{
				int cmp;  // Result of a comparison

				if (root == null)
					return new Node<T>(item);
				else
				{
					cmp = item.CompareTo(root.Item);
					if (cmp > 0)
					{
						root.Right = Add(item, root.Right);       // Move right
						if (root.Right.Priority > root.Priority)  // Rotate left
							root = LeftRotate(root);              // (if necessary)
					}
					else if (cmp < 0)
					{
						root.Left = Add(item, root.Left);         // Move left
						if (root.Left.Priority > root.Priority)   // Rotate right
							root = RightRotate(root);             // (if necessary)
					}
					// else if (cmp == 0) ... do nothing
					return root;
				}
			}
			// Public Remove
			// Removes the given item from the Treap
			// Calls Private Remove to carry out the actual removal
			// Expected time complexity:  O(log n)

			// Union operator takes two treaps and returns the union as a treap
			// expected time complexity O(m log(n/m))
			public Treap<T> Union(Treap<T> t1, Treap<T> t2)
			{
				if (t1.Root == null)
					return t2;
				if (t2.Root == null)
					return t1;
				if (t1.Root.Priority < t2.Root.Priority)
				{
					Node<T> temp;
					temp = t2.Root;
					t2.Root = t1.Root;
					t1.Root = temp;
				}

				
			    t2.Remove(t1.Root.Item);
				
				Tuple<Treap<T>, Treap<T>> myTreaps = t2.Split(t1.Root.Item);
				Treap<T> temp1 = new Treap<T>();
				Treap<T> temp2 = new Treap<T>();
				temp1.Root = t1.Root.Left;
				temp2.Root = t1.Root.Right;

				t1.Root.Left = Union(temp1, myTreaps.Item2).Root;
				t1.Root.Right = Union(temp2, myTreaps.Item1).Root;

				return t1;
			}
			

			public void Remove(T item)
			{
				Root = Remove(item, Root);
			}

			// Remove 
			// Removes the given item from the Treap
			// Nothing is performed if the item is not found
			// Time complexity:  O(log n)

			private Node<T> Remove(T item, Node<T> root)
			{
				int cmp;  // Result of a comparison

				if (root == null)   // Item not found
					return null;
				else
				{
					cmp = item.CompareTo(root.Item);
					if (cmp < 0)
						root.Left = Remove(item, root.Left);      // Move left
					else if (cmp > 0)
						root.Right = Remove(item, root.Right);    // Move right
					else if (cmp == 0)                            // Item found
					{
						// Case: Two children
						// Rotate the child with the higher priority to the given root
						if (root.Left != null && root.Right != null)
						{
							if (root.Left.Priority > root.Right.Priority)
								root = RightRotate(root);
							else
								root = LeftRotate(root);
						}
						// Case: One child
						// Rotate the left child to the given root
						else if (root.Left != null)
							root = RightRotate(root);
						// Rotate the right child to the given root
						else if (root.Right != null)
							root = LeftRotate(root);

						// Case: No children (i.e. a leaf node)
						// Snip off the leaf node containing item
						else
							return null;

						// Recursively move item down the Treap
						root = Remove(item, root);
					}
					return root;
				}
			}

			// Contains
			// Returns true if the given item is found in the Treap; false otherwise
			// Expected Time complexity:  O(log n)

			public bool Contains(T item)
			{
				Node<T> curr = Root;

				while (curr != null)
				{
					if (item.CompareTo(curr.Item) == 0)     // Found
						return true;
					else
						if (item.CompareTo(curr.Item) < 0)
						curr = curr.Left;               // Move left
					else
						curr = curr.Right;              // Move right
				}
				return false;
			}

			// MakeEmpty
			// Creates an empty Treap


			// Split returns a tuple where item 1 is all values greater than x
			// and item 2 is all values less than x
			// expected time complexity is O(log(n))
			public Tuple<Treap<T>, Treap<T>> Split(T x)
			{

				this.AddMax(x);
				Treap<T> t1 = new Treap<T>();
				Treap<T> t2 = new Treap<T>();
				t1.Root = this.Root.Right;
				t2.Root = this.Root.Left;

				return new Tuple<Treap<T>, Treap<T>>(t1, t2);
			}

			public void MakeEmpty()
			{
				Root = null;
			}

			// Empty
			// Returns true if the Treap is empty; false otherwise

			public bool Empty()
			{
				return Root == null;
			}

			// Public Size
			// Returns the number of items in the Treap
			// Calls Private Size to carry out the actual calculation
			// Time complexity:  O(n)

			public int Size()
			{
				return Size(Root);
			}

			// Size
			// Returns the number of items in the given Treap
			// Time complexity:  O(n)

			private int Size(Node<T> root)
			{
				if (root == null)
					return 0;
				else
					return 1 + Size(root.Left) + Size(root.Right);
			}

			// Public Height
			// Returns the height of the Treap
			// Calls Private Height to carry out the actual calculation
			// Time complexity:  O(n)

			public int Height()
			{
				return Height(Root);
			}

			// Private Height
			// Returns the height of the given Treap
			// Time complexity:  O(n)

			private int Height(Node<T> root)
			{
				if (root == null)
					return -1;    // By default for an empty Treap
				else
					return 1 + Math.Max(Height(root.Left), Height(root.Right));
			}

			// Public Print
			// Prints out the items of the Treap inorder
			// Calls Private Print to 

			public void Print()
			{
				Print(Root, 0);
			}

			// Print
			// Inorder traversal of the BST
			// Time complexity:  O(n)

			private void Print(Node<T> root, int index)
			{
				if (root != null)
				{
					Print(root.Left, index + 5);
					Console.WriteLine(new String(' ', index) + root.Item.ToString() + " " + root.Priority.ToString());
					Print(root.Right, index + 5);
				}
			}
		}



		static void Main(string[] args)
		{

			myData data = new myData();
			Treap<string> Treap1 = new Treap<string>();
			Treap<string> Treap2 = new Treap<string>();

			
			for (int i = 0; i < 20; i++)
			{
				if (i < 13)
					Treap1.Add(data.words[i]);
				if (i > 10)
					Treap2.Add(data.words[i]);

			}

			Treap1.Print();
			Console.WriteLine();
			Console.WriteLine();
			Console.WriteLine();
			Console.WriteLine();

			Treap2.Print();

			Console.WriteLine();
			Console.WriteLine();
			Console.WriteLine();
			Console.WriteLine();

			Treap<string> Treap12 = Treap1.Union(Treap1, Treap2);
			Treap12.Print();
			

			System.Console.ReadLine();
		}
	}
}
