using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assingment1PartB
{

    public class Node<T>
    {
        public T Item { get; set; }           // Read/write property
        public Node<T> Next { get; set; }           // Read/write property

        public Node()                            // Parameterless constructor
        {
            Next = null;
        }

        public Node(T item, Node<T> next)         // Constructor
        {
            Item = item;
            Next = next;
        }
    }

    public class MyString
    {
        private Node<char> front {get;set; }
        private Node<char> back { get; set; }
        private int length { get; set; }

        public MyString(char[] value) // constructor of mystring
        {
            front = new Node<char>();
            back = front;
            Node<char> p = front;
            length = 0;

            for(int i = 0; i < value.Length; i++)
            {
                p.Next = new Node<char>(value[i], null); //insertring each character into a new node and setting its references;
                p = p.Next;
                length++;
            }
            back = p; // setting back to the end of the MyString
        }

        public MyString() // empty mystring
        {
            front = new Node<char>();
            back = front;
            Node<char> p = front;
            length = 0;
   
        }

        static public char[] Convert(string s) // time saving method in main program
        {
            char[] a;
            a = s.ToCharArray();
            return a;   
        }

        static public MyString Concat(MyString s1, MyString s2)
        {
            MyString c = new MyString(); // create empty mystring .. need mystring return type 
            Node<char> p = c.front; // set references to the front of the new string and the two given
            Node<char> p1 = s1.front;
            Node<char> p2 = s2.front;

            for (int i = 0; i<s1.length; i++) // for each element of s1 copy the item to the new mystring 
            {
                p.Next = new Node<char>(p1.Next.Item, null); // new node
                p = p.Next; // shifting refrence 
                p1 = p1.Next;
                c.length++;
            }
            for(int i = 0; i < s2.length; i++) // for each element of s2 copy the item to the new mystring
            {
                p.Next = new Node<char>(p2.Next.Item, null); // new node
                p = p.Next; // shifting reference
                p2 = p2.Next;
                c.length++;
            }
            c.back = p; // setting back of mystring
            return c;
        }

        public bool Contains(MyString value)
        {
            if (value.length == 0) // if the mystring is empty return true first thing to check
            {
                return true;
            }
            Node<char> p = this.front; // setting refences to the front of the strings
            Node<char> q = value.front;
            int count = 0;

            for (int i = 0; i <= this.length - value.length; i++) // i like to use this so i know i mean the object the method was invoked on
            {// length - value. legth because after this point not enough charaters left for thier to be a match
                
                if (p.Next.Item == q.Next.Item) // if first characters match
                {
                    if (value.length == 1) // if searching to contian 1 letter return true;
                    {
                        return true;
                    }
                    Node<char> t = p.Next; // set new reference ... so we dont move p if not a match
                    q = q.Next; // move seaching reference

                    

                    for (int j = 0; j < value.length-1; j++)
                    {
                        if (t.Next.Item == q.Next.Item) 
                        {
                            t = t.Next;
                            q = q.Next;
                            count++;
                            if (count == value.length - 1)
                            {
                                return true; // if every letter of the string in question has matched we arrive here and return true
                            }

                        }

                    }
                    count = 0;
                    q = value.front;
                }
                p = p.Next;


            }
            return false; // since the true condition didnt happen
        }

        public int IndexOf(char value)
        {
            if (this.length == 0)
            {
                return -1; // no charters return -1
            }
            Node<char> p = this.front;
            for(int i = 0; i < this.length; i++)
            {
                if (p.Next.Item == value) 
                    return i; // for first occurance of the letter i will be its index

                p = p.Next;
            }

            return -1; // if here letter was not in mystring

        }

        public void Remove(char value)
        {
            Node<char> p = this.front;
            for (int i = 0; i < this.length; i++)
            {
                while (p.Next.Item == value ) /// in case of  hello two l's in a row need while loop
                {
                    p.Next = p.Next.Next; // effectively removes a node.
                    this.length --;     
                    if (p.Next == null) // to avoid going off the end just return when p.Next is null
                    {
                        back = p;  // last letter removed we would loose back otherwise
                        return;
                    }
                }
                   

                p = p.Next; 
            }


        }

        public override bool Equals(object obj)
        {
            if(obj == null || this.GetType() != obj.GetType() ) // first check not null and type
            {
                return false;
            }

            MyString value = (MyString)obj; // cast object to Mystring cuz we know it is

            if (this.length != value.length) // if they dont have the same length not equal
                return false;

            Node<char> p = this.front;
            Node<char> q = this.front;

            while(p.Next != null) // check every index
            {
                if (p.Next != q.Next)// 
                {
                    return false; // one index was not equal return false
                }
                q = q.Next;
                p = p.Next;

            }

            return true; // all conditions past return true

        }

        public override string ToString()
        {
            string s = "";
            Node<char> p = this.front;

            while (p.Next != null) 
            {
                s += p.Next.Item.ToString(); // concatinating each char together
                p = p.Next;
            }
            return s;
        }

        public void Print()
        {
            Node<char> p = front;
            p = p.Next;
            for (int i = 0; i< length; i++)
            {
                Console.Write(p.Item);
                p = p.Next;
            }
        }
    }

    class Program
    {
        static void Main(string[] args)
        {


            // its kinda anoying to have to select your index every time but its
            // like minor to change that to like an option called change index prefrence thing idk

            MyString[] c = new MyString[10];

            for (int i = 0; i < 10; i++)
            {
                c[i] = new MyString("".ToCharArray());
            }

            while (true)
            {

                Console.Clear();
                Console.WriteLine("Welcome to MyString Library");
                Console.WriteLine("We currently have space for 10 MyString Instances");
                for (int i = 0; i < 10; i++)
                {
                    Console.WriteLine(" " + (i+1) + " " + c[i].ToString());
                }
                Console.WriteLine();
                Console.WriteLine("Please Select the Idex your would Like to work with");
                int index = Convert.ToInt32(Console.ReadLine()) -1;

                if (index < 10 && index >= 0)
                {
                    Console.Clear();
                    Console.WriteLine("        Your current MyString is " + c[index].ToString());
                    Console.WriteLine();
                    Console.WriteLine("Please enter an number to select an option:");
                    Console.WriteLine(" 1 --Concatenate Your MyString ");
                    Console.WriteLine(" 2 --Check for the contents of your Mystring");
                    Console.WriteLine(" 3 --Check the Index of a value");
                    Console.WriteLine(" 4 --Remove a value From your Mystring");
                    Console.WriteLine(" 5 --Check its equality to another Object");
                    Console.WriteLine(" 6 --Convert from Type MyString to String");
                    Console.WriteLine(" 7 --OverWrite your Current MyString");
                    Console.WriteLine(" 8 --Exit the Program");
                    int option = Convert.ToInt32(Console.ReadLine());
                    Console.Clear();
                    MyString d;

                    switch (option)
                    {
                        case 1:
                            Console.WriteLine("Please enter a MyString to Concatanate With");
                            d = new MyString(MyString.Convert(Console.ReadLine()));
                            c[index] = MyString.Concat(c[index], d);

                            break;
                        case 2:
                            Console.WriteLine("Please Enter a MyString Value To See if it's Contained within " + c[index].ToString());
                            d = new MyString(MyString.Convert(Console.ReadLine()));
                            Console.WriteLine("Result : " + c[index].Contains(d));
                            Console.WriteLine("Press any key to Continue");
                            Console.ReadLine();
                            break;
                        case 3:
                            Console.WriteLine("Enter a letter to find the position of its first Occurance");
                            Console.WriteLine("If it is not in the MyString position is -1");
                            Console.WriteLine("If input is more that one letter first letter will be selected");
                            Console.WriteLine("Index begins at 0");
                            Console.WriteLine();
                            string s = Console.ReadLine();
                            char[] a = s.ToCharArray();
                            char b = a[0];
                            Console.WriteLine("The position is " + c[index].IndexOf(b));
                            Console.WriteLine("Press any Key to continue");
                            Console.ReadLine();
                            break;
                        case 4:
                            Console.WriteLine("Enter a letter to be Removed from your MyString");
                            string s1 = Console.ReadLine();
                            char[] a1 = s1.ToCharArray();
                            char b1 = a1[0];
                            c[index].Remove(b1);
                            Console.WriteLine("The updated MyString is " + c[index].ToString());
                            Console.WriteLine("Press any Key to continue");
                            Console.ReadLine();
                            break;
                        case 5:
                            Console.WriteLine("Equality Check");
                            Console.WriteLine("Please select input Type");
                            Console.WriteLine("1 --MyString");
                            Console.WriteLine("2 --String");
                            Console.WriteLine("3 --Integer");
                            int dataType = Convert.ToInt32(Console.ReadLine());
                            Console.Clear();
                            switch (dataType)
                            {
                                case 1:
                                    Console.WriteLine("please enter your Object");
                                    MyString c1 = new MyString(MyString.Convert(Console.ReadLine()));
                                    Console.WriteLine("Equality check result: " + c[index].Equals(c1));
                                    Console.WriteLine("Press any key to continue");
                                    Console.ReadLine();
                                    break;
                                case 2:
                                    Console.WriteLine("please enter your Object");
                                    string s3 = Console.ReadLine();
                                    Console.WriteLine("Equality check Result: " + c[index].Equals(s3));
                                    Console.WriteLine("Press any key to continue");
                                    Console.ReadLine();
                                    break;
                                case 3:
                                    Console.WriteLine("please enter your Object");
                                    int x = Convert.ToInt32(Console.ReadLine());
                                    Console.WriteLine("Equality check Result: " + c[index].Equals(x));
                                    Console.WriteLine("Press any key to continue");
                                    Console.ReadLine();
                                    break;
                                default:
                                    Console.WriteLine(" Invalid Input Press any Key to continue");
                                    break;
                            }

                            break;
                        case 6:
                            bool toStringVer = c[index].GetType() == typeof(string);
                            Console.WriteLine("ToString verification before conversion");
                            Console.WriteLine("MyString.GetType() == typeof(string) Result: " + toStringVer);
                            toStringVer = c[index].ToString().GetType() == typeof(string);
                            Console.WriteLine("MyString.ToString().GetType() == typeof(string) Result: " + toStringVer);
                            Console.WriteLine("Press any key to continue");
                            Console.ReadLine();
                            break;
                        case 7:
                            c[index] = new MyString(MyString.Convert(Console.ReadLine()));
                            Console.WriteLine("Your new MyString is " + c[index].ToString());
                            Console.WriteLine("Press any key to continue");
                            Console.ReadLine();
                            break;
                        case 8:
                            Environment.Exit(0);
                            break;
                        default:
                            Console.WriteLine("Invalid input Press any key to continue");
                            Console.ReadLine();
                            break;

                    }
                }


            }
        }
    }
}
