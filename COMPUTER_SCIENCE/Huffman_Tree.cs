using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication2
{

    public interface IContainer<T>
    {
        void MakeEmpty();  // Reset an instance to empty
        bool Empty();      // Test if an instance is empty
        int Size();        // Return the number of items in an instance
    }

    //-----------------------------------------------------------------------------

    public interface IPriorityQueue<T> : IContainer<T> where T : IComparable
    {
        void Add(T item);  // Add an item to a priority queue
        void Remove();     // Remove the item with the highest priority
        T Front();         // Return the item with the highest priority
    }

    //-------------------------------------------------------------------------

    // Priority Queue
    // Implementation:  Binary heap

    public class PriorityQueue<T> : IPriorityQueue<T> where T : IComparable
    {
        private int capacity;  // Maximum number of items in a priority queue
        private T[] A;         // Array of items
        private int count;     // Number of items in a priority queue

        public PriorityQueue(int size)
        {
            capacity = size;
            A = new T[size + 1];  // Indexing begins at 1
            count = 0;
        }

        // Percolate up from position i in a priority queue

        private void PercolateUp(int i)
        // (Worst case) time complexity: O(log n)
        {
            int child = i, parent;

            while (child > 1)
            {
                parent = child / 2;
                if (A[child].CompareTo(A[parent]) > 0)
                // If child has a higher priority than parent
                {
                    // Swap parent and child
                    T item = A[child];
                    A[child] = A[parent];
                    A[parent] = item;
                    child = parent;  // Move up child index to parent index
                }
                else
                    // Item is in its proper position
                    return;
            }
        }

        public void Add(T item)
        // Time complexity: O(log n)
        {
            if (count < capacity)
            {
                A[++count] = item;  // Place item at the next available position
                PercolateUp(count);
            }
        }

        // Percolate down from position i in a priority queue

        private void PercolateDown(int i)
        // Time complexity: O(log n)
        {
            int parent = i, child;

            while (2 * parent <= count)
            // while parent has at least one child
            {
                // Select the child with the highest priority
                child = 2 * parent;    // Left child index
                if (child < count)  // Right child also exists
                    if (A[child + 1].CompareTo(A[child]) > 0)
                        // Right child has a higher priority than left child
                        child++;

                if (A[child].CompareTo(A[parent]) > 0)
                // If child has a higher priority than parent
                {
                    // Swap parent and child
                    T item = A[child];
                    A[child] = A[parent];
                    A[parent] = item;
                    parent = child;  // Move down parent index to child index
                }
                else
                    // Item is in its proper place
                    return;
            }
        }

        public void Remove()
        // Time complexity: O(log n)
        {
            if (!Empty())
            {
                // Remove item with highest priority (root) and
                // replace it with the last item
                A[1] = A[count--];

                // Percolate down the new root item
                PercolateDown(1);
            }
        }

        public T Front()
        // Time complexity: O(1)
        {
            if (!Empty())
            {
                return A[1];  // Return the root item (highest priority)
            }
            else
                return default(T);
        }

        // Create a binary heap
        // Percolate down from the last parent to the root (first parent)

        private void BuildHeap()
        // Time complexity: O(n)
        {
            int i;
            for (i = count / 2; i >= 1; i--)
            {
                PercolateDown(i);
            }
        }

        // Sorts and returns the InputArray

        public void HeapSort(T[] inputArray)
        // Time complexity: O(n log n)
        {
            int i;

            capacity = count = inputArray.Length;

            // Copy input array to A (indexed from 1)
            for (i = capacity - 1; i >= 0; i--)
            {
                A[i + 1] = inputArray[i];
            }

            // Create a binary heap
            BuildHeap();

            // Remove the next item and place it into the input (output) array
            for (i = 0; i < capacity; i++)
            {
                inputArray[i] = Front();
                Remove();
            }
        }

        public void MakeEmpty()
        // Time complexity: O(1)
        {
            count = 0;
        }

        public bool Empty()
        // Time complexity: O(1)
        {
            return count == 0;
        }

        public int Size()
        // Time complexity: O(1)
        {
            return count;
        }
    }

    //-------------------------------------------------------------------------

    // Used by class PriorityQueue<T>
    // Implements IComparable and overrides ToString (from Object)

    public class PriorityClass : IComparable
    {
        private int priorityValue;
        private String name;

        public PriorityClass(int priority, String name)
        {
            this.name = name;
            priorityValue = priority;
        }

        public int CompareTo(Object obj)
        {
            PriorityClass other = (PriorityClass)obj;   // Explicit cast
            return priorityValue - other.priorityValue;
        }

        public override string ToString()
        {
            return name + " with priority " + priorityValue;
        }
    }

    public interface ISearchable<T> : IContainer<T>
    {
        void Add(T item);
        void Remove(T item);
        bool Contains(T item);
    }

    //-------------------------------------------------------------------------

    // Common generic node class for a binary search tree

    public class Data : IComparable // data class holds frequency and letter for huffman tree to be stored inside a node
    {
        public int Frequency { get; set; }
        public char Letter { get; set; }

        public Data(int letter, int frequency) // constructor to use with numeric values
        {
            Letter = (char)letter;
            Frequency = frequency;
        }
        public Data(int frequency)
        {
            Frequency = frequency;
        }
        public int CompareTo(Object obj)
        {
            Data data = (Data)obj;
            return data.Frequency - this.Frequency;
        }
    }

    public class Node<T> where T : IComparable
    {
        // Read/write properties

        public T Item { get; set; }
        public Node<T> Left { get; set; }
        public Node<T> Right { get; set; }

        public Node(T item)
        {
            Item = item;
            Left = Right = null;
        }

        public Node(T item, Node<T> left, Node<T> right)
        {
            Item = item;
            Left = left;
            Right = right;
        }

        public int CompareTo(Object obj)
        {
            Node<T> node = (Node<T>)obj;
            return this.Item.CompareTo(node.Item);
        }
    }

    //-------------------------------------------------------------------------

    // Implementation:  Binary Search Tree (BST)

    public class BinaryTree<T> : IComparable where T : IComparable
    {
        public Node<T> Root { get; set; }  // Reference to the root of a BST

        public BinaryTree()
        {
            Root = null;    // Empty BST
        }

      
        public void Add(T item)
        {
            Node<T> curr = new Node<T>(item);
            Root = curr;  
        }

        public bool Contains(T item)
        {
            Node<T> curr = Root;

            while (curr != null)
            {
                if (item.CompareTo(curr.Item) == 0)          // Found
                    return true;
                else
                    if (item.CompareTo(curr.Item) < 0)
                    curr = curr.Left;                    // Move left
                else
                    curr = curr.Right;                   // Move right
            }
            return false;
        }

        public void MakeEmpty()
        {
            Root = null;
        }

        public bool Empty()
        {
            return Root == null;
        }

        public int Size()
        {
            return Size(Root);          // Call the private, recursive Size
        }

        // Size
        // Returns the number of items in a BST
        // Time complexity:  O(n)

        private int Size(Node<T> node)
        {
            if (node == null)
                return 0;
            else
                // Postorder processing
                return 1 + Size(node.Left) + Size(node.Right);
        }

        public void Print()
        {
            Print(Root);                // Call private, recursive Print
            Console.WriteLine();
        }

        // Print
        // Inorder traversal of the BST
        // Time complexity:  O(n)

        private void Print(Node<T> node)
        {
            if (node != null)
            {
                Print(node.Left);
                Console.Write(node.Item.ToString() + " ");
                Print(node.Right);
            }
        }

        public int CompareTo(Object obj)
        {
            BinaryTree<T> tree = (BinaryTree<T>)obj;

            return this.Root.CompareTo(tree.Root);
        }
    }

    public class HuffmanTree
    {
        private Node<Data> Root { set; get; }
        private Dictionary<char, String> HuffmanCode;
        public string CodeWord;
        public string Encoding;
        public HuffmanTree()
        {
            Root = null;
        }

        public HuffmanTree(String code)
        {
            CodeWord = code;
            char[] letters = code.ToCharArray();
            int[] frequency = new int[53];
            for (int i = 0; i < code.Length; i++) // adds once to the corresponding letters index each time it occurs in the codeword
            {
                if (letters[i] > 64 && letters[i] < 91) // capital letters numeric value
                {
                    frequency[letters[i] - 65]++; // indexs 0-25
                }
                if (letters[i] > 96 && letters[i] < 123) // lower case letters numeric value
                {
                    frequency[letters[i] + 26 - 97]++;  // index 0-25 used
                }
                if (letters[i] == 32) // space numeric value
                {
                    frequency[52]++; // last unused index;
                }
            }

            PriorityQueue<BinaryTree<Data>> pQueue = new PriorityQueue<BinaryTree<Data>>(53);
            Data data;
            BinaryTree<Data> BT;
            for (int i = 0; i < 53; i++) // for each possible char
            {
                if (frequency[i] != 0) // if the frequency is not null
                {
                    if (i < 26) // if capital letter create binary tree with its value and frequency inside the root node
                    {
                        data = new Data(i + 65, frequency[i]); //(i +65 gives numeric value of char)
                        BT = new BinaryTree<Data>();
                        BT.Add(data);
                        pQueue.Add(BT);
                    }
                    if (i > 25 && i < 52) // if lower case letter create ""
                    {
                        data = new Data(i + 97 - 26, frequency[i]); //(i+97-26) gives numeric value of char
                        BT = new BinaryTree<Data>();
                        BT.Add(data);
                        pQueue.Add(BT);
                    }
                    if (i == 52) // if space
                    {
                        data = new Data(32, frequency[i]); // 32 is numeric value of space
                        BT = new BinaryTree<Data>();
                        BT.Add(data);
                        pQueue.Add(BT);
                    }
                }
            }
            Build(pQueue); // build Huffman tree from pQueue of BT<Data>
        }

        private void Build(PriorityQueue<BinaryTree<Data>> pQueue)
        {
            
            BinaryTree<Data> BT = new BinaryTree<Data>(); ;
            BinaryTree<Data> BT1;
            BinaryTree<Data> BT2;
            Data data;
            while (pQueue.Size() > 1) // when only 1 value is in pQueue then it is the completed huffman tree
            {
                BT1 = pQueue.Front(); // get first element from pQueue
                pQueue.Remove();
                BT2 = pQueue.Front(); // get Second element from pQueue
                pQueue.Remove();
                BT = new BinaryTree<Data>(); // create a new binary tree
                data = new Data(BT1.Root.Item.Frequency + BT2.Root.Item.Frequency); 
                BT.Add(data); // set its root to be the value of BT1 and BT2 combined frequency

                if (BT1.Root.Item.Frequency == BT2.Root.Item.Frequency) // doesnt matter but place larger trees on left
                {
                    if (BT1.Size() < BT2.Size()) // compare size of trees with equal frequency
                    {
                        BT.Root.Left = BT2.Root; // large tree left
                        BT.Root.Right = BT1.Root; // smaller tree right
                    }
                    else
                    {
                        BT.Root.Left = BT1.Root; // larger tree right
                        BT.Root.Right = BT2.Root; // smalller tree left
                    }
                }
                else // not equal frequency
                {
                    BT.Root.Left = BT1.Root; // first tree removed has smaller frequency and is placed on left 
                    BT.Root.Right = BT2.Root; // second tree removed has larger frequency and is placed on right
                } 
                pQueue.Add(BT); // add the new Binary tree to the Priority Queue

            }
            this.Root = BT.Root; // set Huffman tree root the the new BT that now is a completed huffman tree
        }

        private void PreOrderLeft(Node<Data> current, string code)
        {

            if (current.Left == null) // if a lead node
            {
                if (code.Substring(0, 1) == "0") // if belongs to left branch/... ( avoiding duplicate entries)
                {
                    HuffmanCode.Add(current.Item.Letter, code); // add to dictonary
                }
                return; // stops recursion
            }
            code += "0"; // if not leaf node and 0 to code and process left node
            PreOrder(current.Left,code); 



        }

        private void PreOrderRight(Node<Data> current, String code)
        {

            if (current.Right == null) // if a leaf node
            {
                if (code.Substring(0, 1) == "1") // if belongs to the right branch .... (avoiding duplicate entries)
                {
                    HuffmanCode.Add(current.Item.Letter, code); // add to the dictionary
                }
                return; // stops recursion
            }
            code += "1"; // if not add a 1 to code and prossecs right node
            PreOrder(current.Right,code);

        }

        private void PreOrder(Node<Data> current, string code) // preorde calls preorder left and right  for the tracversal
        {

            PreOrderLeft(current, code);
            PreOrderRight(current, code);

        }

        public String Encode()
        {
            HuffmanCode = new Dictionary<char, string>();
            PreOrder(Root,""); // traverse the tree to set the Dictronary
            char[] code = CodeWord.ToCharArray(); 
            string encode = "";
            string value; 
            for (int i = 0; i < code.Length; i++) // travers the word
            {
                 HuffmanCode.TryGetValue(code[i], out value); 
                 encode += value; // append the code of the char
            }
            Encoding = encode;
            return encode; // return the coded word
        }

        public string Decode() // traverse tree using encoding to recover the word
        {
            string decode = "";
            char[] code = Encoding.ToCharArray();
            Node<Data> current = Root;
             
            for ( int i = 0; i < code.Length; i++)
            {
                if (code[i] == '0')
                {
                    current = current.Left; // move left on a 0
                    if (current.Left == null) // if a leaf node
                    {
                        decode += current.Item.Letter; // append letter to string and return to root
                        current = Root;
                    }

                }
                else
                {
                    current = current.Right; // move right on a 1
                    if (current.Right == null) // if a leaf node
                    {
                        decode += current.Item.Letter; // append letter to string and return to root
                        current = Root;
                    }
                }
            }
            return decode; // after incoding is travers return the decode string

        }
    }

   


    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("please enter a phrase containing only letters and spaces");
            HuffmanTree Htree = new HuffmanTree( Console.ReadLine() );
            Console.WriteLine(Htree.Encode());
            Console.WriteLine(Htree.Decode());

            
            Console.ReadLine();
        }
    }
}
