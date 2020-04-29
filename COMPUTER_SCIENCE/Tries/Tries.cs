using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;

namespace Tries2
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

		// ternary search tree
		public class TST<T>
		{
			private Node<T> root;


			// Holds charater Value and mid left right pointers
			private class Node<T>
			{
				public T Val;
				public char C;
				public Node<T> Left, Mid, Right;

				public Node(T value, char c)
				{
					Val = value;
					C = c;
					Left = Mid = Right = null;
				}
				public Node()
				{
					Val = default(T);
					Left = Mid = Right = null;
				}

			}

			// public method to hide information
			public void Add(string key, T value)
			{
				root = Add(root, key, value, 0);
			}


			// add method for insertion into tree
			private Node<T> Add(Node<T> x, string key, T val, int d)
			{
				char c = Convert.ToChar(key.Substring(d, 1));
				if (x == null) // if no path to follow create new node
				{
					x = new Node<T>();
					x.C = c;
					if (key.Length - 1 == d) // if last character in key give it a value
					{
						x.Val = val;
					}
				}
				if (c < x.C) // move left 
				{
					x.Left = Add(x.Left, key, val, d);
				}
				else if (c > x.C) // move right
				{
					x.Right = Add(x.Right, key, val, d);
				}
				else if (d < key.Length - 1) // move down // only if not at last character
				{
					x.Mid = Add(x.Mid, key, val, d + 1);

				}
				else
					return x;

				return x; // return to caller
			}

			// public method with information hiding
			public Boolean Contains(string key)
			{
				return !Get(key).Equals(default(T)); // if not the defualt value then the word is in the tree
			}

			// retuns value of keys last char
			public T Get(string key)
			{
				Node<T> x = Get(root, key, 0);
				if (x == null) // if get terminates on null value is not in tree
					return default(T);
				return x.Val; // returns value will be default t if searching for a word not inserted but contained in a word or a value
			}

			// gets the node of the keys last char
			private Node<T> Get(Node<T> x, string key, int d)
			{
				if (x == null) return null; // if x is null returns null
				char c = Convert.ToChar(key.Substring(d, 1));
				if (c < x.C) return Get(x.Left, key, d); // move left
				else if (c > x.C) return Get(x.Right, key, d); // move right
				else if (d < key.Length - 1) return Get(x.Mid, key, d + 1); // move down if not on last char
				else return x; // only get here if on last char and c = x.C meaning found char
			}

			// information hiding on auto complete
			public List<string> Autocomplete(string pattern)
			{

				return Autocomplete(root, pattern, 0, "", new List<string>());

			}


			private List<string> Autocomplete(Node<T> x, string pattern, int d, string completed, List<string> words)
			{
				if (d < pattern.Length && x != null) // if within the initial pattern and that pattern is in the tree
				{
					char c = pattern[d];
					if (x.C == c) // if on correct node move down
					{

						Autocomplete(x.Mid, pattern, d + 1, completed + x.C, words);
					}
					else if (x.C < c) // move left or right one isnt nessacary goes straight to null, ill fix this if i have time
					{
						Autocomplete(x.Left, pattern, d, completed, words);
						Autocomplete(x.Right, pattern, d, completed, words);
					}
					else
					{
						Autocomplete(x.Right, pattern, d, completed, words);
					}
				}
				if (d >= pattern.Length && x != null) // finished initial pattern traverse subtree add all words
				{
					words = Autocomplete(x.Left, pattern, d, completed, words); // move left
					words = Autocomplete(x.Mid, pattern, d + 1, completed + x.C, words); // move down
					words = Autocomplete(x.Right, pattern, d, completed, words); // move right
					if (!x.Val.Equals(default(T))) // if value is not deafult(T) found word 
					{
						completed += x.C; // tac on last letter
						words.Add(completed); // add to list
					}
				}

				return words; // return the list
			}

			// public method to hide information
			public List<string> PartialMatch(string pattern)
			{
				return PartialMatch(root, pattern, 0, "", new List<string>());
			}

			// finds words where * is any letter for pattern
			private List<string> PartialMatch(Node<T> x, string pattern, int d, string completed, List<string> words)
			{

				if (d == pattern.Length || x == null) // if past last char or x = null return
				{
					return words;
				}

				char c = pattern[d];

				if (c == '*') // wildcard traverse in all directions
				{
					words = PartialMatch(x.Left, pattern, d, completed, words); // move left
					completed += x.C; // add to completed when moving down
					words = PartialMatch(x.Mid, pattern, d + 1, completed, words); // move down
					completed = completed.Remove(completed.Length - 1); // remove from completed because we are moving right
					words = PartialMatch(x.Right, pattern, d, completed, words); // move right
					if (!x.Val.Equals(default(T)) && d == pattern.Length - 1) // if not a default value and on last char 
					{
						completed += x.C; // add last char
						words.Add(completed); // add to list
					}
				}
				else // not on wildcard find char
				{
					if (c < x.C) // move left
					{
						PartialMatch(x.Left, pattern, d, completed, words);
					}
					else if (c > x.C) // move right
					{
						PartialMatch(x.Left, pattern, d, completed, words);
					}
					else // found char
					{
						completed += x.C; // add char to completed
						words = PartialMatch(x.Mid, pattern, d + 1, completed, words); // move down
					}
					if (!x.Val.Equals(default(T)) && d == pattern.Length - 1 && x.C == pattern[d]) // if not default val// on last char// char is the correct char
					{

						words.Add(completed); // add to completed words
					}
				}

				return words; // return words list
			}

		}

		static void Main(string[] args)
		{

			// TESTING search tree Insertion
			// 2643 adds
			Console.WriteLine(" Ternary Search Tree Add ");
			Stopwatch myStopWatch = new Stopwatch();
			myData data = new myData();
			TST<int> myTry = new TST<int>();
			myStopWatch.Start();
			for (int i = 0; i < 3; i++)
			{
				myTry.Add(data.words[i], i);
			}
			myStopWatch.Stop();
			Console.WriteLine("3 Insertions: " + myStopWatch.Elapsed);

			// 1000 adds

			myStopWatch = new Stopwatch();
			data = new myData();
			myTry = new TST<int>();
			myStopWatch.Start();
			for (int i = 0; i < 9; i++)
			{
				myTry.Add(data.words[i], i);
			}
			myStopWatch.Stop();
			Console.WriteLine("9 Insertions: " + myStopWatch.Elapsed);
			// 100 adds

			myStopWatch = new Stopwatch();
			data = new myData();
			myTry = new TST<int>();
			myStopWatch.Start();
			for (int i = 0; i < 27; i++)
			{
				myTry.Add(data.words[i], i);
			}
			myStopWatch.Stop();
			Console.WriteLine("27 Insertions: " + myStopWatch.Elapsed);

			myStopWatch = new Stopwatch();
			data = new myData();
			myTry = new TST<int>();
			myStopWatch.Start();
			for (int i = 0; i < 81; i++)
			{
				myTry.Add(data.words[i], i);
			}
			myStopWatch.Stop();
			Console.WriteLine("81 Insertions: " + myStopWatch.Elapsed);
			// 100 adds

			myStopWatch = new Stopwatch();
			data = new myData();
			myTry = new TST<int>();
			myStopWatch.Start();
			for (int i = 0; i < 243; i++)
			{
				myTry.Add(data.words[i], i);
			}
			myStopWatch.Stop();
			Console.WriteLine("243 Insertions: " + myStopWatch.Elapsed);
			// 10 adds
			myStopWatch = new Stopwatch();
			data = new myData();
			myTry = new TST<int>();
			myStopWatch.Start();
			for (int i = 0; i < 729; i++)
			{
				myTry.Add(data.words[i], i);
			}
			myStopWatch.Stop();
			Console.WriteLine("729 Insertions: " + myStopWatch.Elapsed);
			// Testing Dictionary search tree Insertions
			// 977 adds
			Console.WriteLine(" Testing the Dictionary");
			myStopWatch = new Stopwatch();
			data = new myData();
			Dictionary<string, int> myDictionary = new Dictionary<string, int>();
			myStopWatch.Start();
			for (int i = 0; i < 3; i++)
			{
				myDictionary.Add(data.words[i], i);
			}
			myStopWatch.Stop();
			Console.WriteLine("3 Insertions: " + myStopWatch.Elapsed);


			myStopWatch = new Stopwatch();
			data = new myData();
			myDictionary = new Dictionary<string, int>();
			myStopWatch.Start();
			for (int i = 0; i < 27; i++)
			{
				myDictionary.Add(data.words[i], i);
			}
			myStopWatch.Stop();
			Console.WriteLine("27 Insertions: " + myStopWatch.Elapsed);

			myStopWatch = new Stopwatch();
			data = new myData();
			myDictionary = new Dictionary<string, int>();
			myStopWatch.Start();
			for (int i = 0; i < 81; i++)
			{
				myDictionary.Add(data.words[i], i);
			}
			myStopWatch.Stop();
			Console.WriteLine("81 Insertions: " + myStopWatch.Elapsed);

			myStopWatch = new Stopwatch();
			data = new myData();
			myDictionary = new Dictionary<string, int>();
			myStopWatch.Start();
			for (int i = 0; i < 243; i++)
			{
				myDictionary.Add(data.words[i], i);
			}
			myStopWatch.Stop();
			Console.WriteLine("243 Insertions: " + myStopWatch.Elapsed);

			myStopWatch = new Stopwatch();
			data = new myData();
			myDictionary = new Dictionary<string, int>();
			myStopWatch.Start();
			for (int i = 0; i < 729; i++)
			{
				myDictionary.Add(data.words[i], i);
			}
			myStopWatch.Stop();
			Console.WriteLine("729 Insertions: " + myStopWatch.Elapsed);

			// TESTING // Contains// Partial Match // Autocomplete

			Console.WriteLine(" Ternary Search Tree Add ");

			data = new myData();
			myTry = new TST<int>();
			myStopWatch.Start();
			for (int i = 0; i < 1000; i++)
			{
				myTry.Add(data.words[i], i);
			}

			Boolean value = myTry.Contains("chaos");
			List<string> list = myTry.Autocomplete("ch");
			List<string> list2 = myTry.PartialMatch("ch***");
			List<string> list3 = myTry.PartialMatch("***b**");

			Console.WriteLine("List: AutoComplete ch ");
			foreach (string element in list)
			{
				Console.Write(element + " ");
			}
			Console.WriteLine();
			Console.WriteLine("List2: PartialMatch ch*** ");
			foreach (string element in list2)
			{
				Console.Write(element + " ");
			}
			Console.WriteLine();
			Console.WriteLine("List3: PartialMatch ***b** ");
			foreach (string element in list3)
			{
				Console.Write(element + " ");
			}


			Console.ReadLine();

		}
	}
}
