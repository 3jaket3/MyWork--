using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Collections;
namespace minifloat
{
	class Program
	{

		class MiniFloat
		{
			private Boolean Sign;
			private BitArray Exponent; // exponent 4 bits
			private BitArray Mantissa; // fraction 3 bits
			private int exp;
			
			public MiniFloat(Boolean sign, int exponent, int mantissa)
			{
				Sign = sign;
				exp = exponent;
				if (exponent > 15)
				{
					Console.WriteLine("Overflow exponent");
					return;
				}
				if (mantissa > 7)
				{
					Console.WriteLine("Overflow mantissa");
				}



				int x = exponent + 7;
				int rem; // remainder
				int count = 3;
				Exponent = new BitArray(4); // initially all flase
				while (x > 0)
				{
					rem = x % 2;
					x = x / 2;
					if (rem == 1)
					{
						Exponent.Set(count,true);
					}
					count--;
				}
				
				x = mantissa;
			    rem =0; // remainder
			    count = 3;
				Mantissa = new BitArray(4); // initially all flase
				
				while (x > 0)
				{
					rem = x % 2;
					x = x / 2;
					if (rem == 1)
					{
						Mantissa.Set(count, true);
					}
					count--;
				}
				if (Sign)
				{
					
					for (int i = 0; i < Mantissa.Count; i++)
					{
						if (Mantissa.Get(i))
						{
							Mantissa.Set(i, false);
						}
						else if (!Mantissa.Get(i))
						{
							Mantissa.Set(i, true);
						}
					}
					BitArray A = Mantissa;
					BitArray B = new BitArray(4);
					BitArray Sum = new BitArray(4);
					B.Set(3, true);
					Boolean carry = false;
					for (int i = A.Count - 1; i >= 0; i--)
					{ // a(!b!c + bc) + !a(b!c + !bc)
						if ((A.Get(i) && ((!B.Get(i) && !carry) || (B.Get(i) && carry)))
							|| (!A.Get(i) && ((B.Get(i) && !carry) || (!B.Get(i) && carry))))
							Sum.Set(i, true);

						if ((A.Get(i) && (B.Get(i) || carry)) || (B.Get(i) && carry))
						{
							carry = true;
						}

						else
							carry = false;
					}
					Mantissa = Sum;

					

				}
				BitArray temp1 = new BitArray(4);
				while (!Mantissa.Get(0))
				{
					for (int i = 0; i < Mantissa.Count - 1; i++)
					{
						temp1.Set(i, Mantissa.Get(i + 1));
					}
					exp = exp - 1;
					Mantissa = temp1;
				}

			}

			public double ToDouble(MiniFloat a)
			{
				double sumE = 0;
				for (int i = a.Exponent.Count-1; i >= 0; i--)
				{
					if (a.Exponent.Get(i))
					{
						sumE += Math.Pow(2,a.Exponent.Count - i -1);
					}
				}
				double sumM = 0;
				for (int i = 0; i < a.Mantissa.Count; i++)
				{
					if (a.Mantissa.Get(i))
					{
						if (i == 0 && a.Sign)
						{
							sumM += -1 / Math.Pow(2, i);
						}
						else
						{
							sumM += 1 / Math.Pow(2, i);
						}
					}
				}
				
				 double x = (sumM) * Math.Pow(2, exp);
				
				
				return x;
	
			}

			private BitArray ShiftRight(int x, BitArray A,Boolean carry)
			{
				if (x == 0)
					return A;
				
				BitArray B = new BitArray(A.Count);
				int counter = x;
				while (counter > 0)
				{
					if (A.Get(A.Count - 1))
					{
						System.Console.WriteLine("Digit lost durring ShiftRight");
					}
					for (int i = 0; i < A.Count-1; i++)
						{
							B.Set(i+1, A.Get(i));
						    A.Set(i, B.Get(i));
						}
					if (carry)
						B.Set(0, true);
					
					counter--;
				}

				return B;
			}
			
			public MiniFloat Add(MiniFloat a, MiniFloat b)
			{

				if (b.exp > a.exp)
				{
					MiniFloat temp = a;
					a = b;
					b = temp;
				}
				BitArray A = a.Mantissa;
				BitArray B = b.Mantissa;
				BitArray Sum = new BitArray(A.Count);
				Boolean carry = false;

				B = ShiftRight(a.exp - b.exp, B,false);
				b.exp = a.exp;
				for (int i = A.Count - 1; i >= 0; i--)
				{ // a(!b!c + bc) + !a(b!c + !bc)
					if ((A.Get(i) && ((!B.Get(i) && !carry) || (B.Get(i) && carry)))
						|| (!A.Get(i) && ((B.Get(i) && !carry) || (!B.Get(i) && carry))))
						Sum.Set(i, true);

					if ((A.Get(i) && (B.Get(i) || carry)) || (B.Get(i) && carry))
					{
						carry = true;
					}

					else
						carry = false;
				}
				a.Mantissa = Sum;
				
					if (carry & !a.Sign & !b.Sign)
					{
					    a.exp = a.exp + 1;
						a.Mantissa = ShiftRight(1, a.Mantissa, carry);
					}
				
				
					BitArray temp1 = new BitArray(4);
					 while (!a.Mantissa.Get(0))
					{
						for (int i = 0; i < a.Mantissa.Count-1; i++)
						{
							temp1.Set(i, a.Mantissa.Get(i + 1));
						}
						a.exp = a.exp - 1;
						a.Mantissa = temp1;
					}
					

				
				return a;
			}

			public MiniFloat Multiply(MiniFloat a, MiniFloat b)
			{
				BitArray multiplier = a.Mantissa;
				BitArray multiplicand = b.Mantissa;
				BitArray Product = new BitArray(7);
				BitArray Sum = new BitArray(7);
				for (int i = 3; i >= 0; i--)
				{
					BitArray temp1 = new BitArray(7);
					if (multiplier.Get(i))
					{
						Boolean carry = false;
						for (int k = 3; k <= 0; k--)
						{
							temp1.Set(i + k, multiplicand.Get(k));
						}
						for (int j = temp1.Count - 1; i >= 0; i--)
						{ // a(!b!c + bc) + !a(b!c + !bc)
							if ((temp1.Get(j) && ((!Product.Get(j) && !carry) || (Product.Get(j) && carry)))
								|| (!temp1.Get(i) && ((Product.Get(i) && !carry) || (!Product.Get(j) && carry))))
								Sum.Set(i, true);

							if ((temp1.Get(j) && (Product.Get(j) || carry)) || (Product.Get(j) && carry))
							{
								carry = true;
							}

							else
								carry = false;
						}
						if (carry)
						{
							Sum = ShiftRight(1, Sum, carry);
							exp = exp + 1;
						}
						Product = new BitArray(Sum);
					}

				}

				for (int i = 3; i <= 0; i--)
				{
					a.Mantissa.Set(i, Product.Get(6 - i));
				}
				a.exp = a.exp + b.exp;
				return a;
			}

			public MiniFloat Divide(MiniFloat a, MiniFloat b)
			{
				/// if more bits of percision exp = -exp  mantissa = 1.0101010101010101010101 multiply?
				/// BitArray multiplier = a.Mantissa;
				BitArray Quotient = new BitArray(4);
				BitArray Divisor = new BitArray(9);
				BitArray Remainer = new BitArray(9);
				//gets fucked up cuz i normalized the mantisa when i created the float so the divisor and remander dont get set right
				for (int i = 0; i < 3; i++) 
				{
					Divisor.Set(i, b.Mantissa.Get(i));
					Remainer.Set(4 + i, a.Mantissa.Get(i));
				}

				for (int i = 0; i < 4; i++)
				{
					BitArray CompDivisor = Compliment(new BitArray(Divisor));
					BitArray Sum = new BitArray(9);
					Boolean carry = false;

					// subtract divisor from remainder
					for (int j = Divisor.Count - 1; j >= 0; j--)
					{ // a(!b!c + bc) + !a(b!c + !bc)
						if ((CompDivisor.Get(j) && ((!Remainer.Get(j) && !carry) || (Remainer.Get(j) && carry)))
							|| (!CompDivisor.Get(i) && ((Remainer.Get(i) && !carry) || (!Remainer.Get(j) && carry))))
							Sum.Set(i, true);

						if ((CompDivisor.Get(j) && (Remainer.Get(j) || carry)) || (Remainer.Get(j) && carry))
						{
							carry = true;
						}

						else
							carry = false;
					}

					// test remainder
					if (!Sum.Get(0))
					{
						// R >= 0 shift Quotient left set rightmost to 1;
						for (int k = 0; k <= 2; k++)
						{
							Quotient.Set(k, Quotient.Get(k + 1));
						}
						Quotient.Set(3, true);
						Remainer = new BitArray(Sum);
					}
					else
					{ // restore remainder to initial value and shift left setting rightmost bit to 1
						for (int k = 0; k <= 2; k++)
						{
							Quotient.Set(k, Quotient.Get(k + 1));
						}
						Quotient.Set(3, false);
						
					}

						// shift divisor registar 1 bit;
						Divisor = ShiftRight(1, Divisor, false);
					
				}
				a.Mantissa = new BitArray(Quotient);
				a.exp = a.exp - b.exp;
				return a;

			}
			private BitArray Compliment(BitArray A)
			{

				for (int i = 0; i < A.Count; i++)
				{
					if (A.Get(i))
					{
						A.Set(i, false);
					}
					else if (!A.Get(i))
					{
						A.Set(i, true);
					}
				}
				
				BitArray B = new BitArray(A.Count);
				BitArray Sum = new BitArray(A.Count);
				B.Set(3, true);
				Boolean carry = false;
				for (int i = A.Count - 1; i >= 0; i--)
				{ // a(!b!c + bc) + !a(b!c + !bc)
					if ((A.Get(i) && ((!B.Get(i) && !carry) || (B.Get(i) && carry)))
						|| (!A.Get(i) && ((B.Get(i) && !carry) || (!B.Get(i) && carry))))
						Sum.Set(i, true);

					if ((A.Get(i) && (B.Get(i) || carry)) || (B.Get(i) && carry))
					{
						carry = true;
					}

					else
						carry = false;
				}
				return Sum;



			
			}

			private BitArray addOne(BitArray A)
			{
				BitArray Sum = new BitArray(A.Count);
				Boolean carry = false;
				BitArray B = new BitArray(A.Count);
				B.Set(A.Count - 1, true);
				for (int i = A.Count - 1; i >= 0; i--)
				{ // a(!b!c + bc) + !a(b!c + !bc)
					if ((A.Get(i) && ((!B.Get(i) && !carry) || (B.Get(i) && carry)))
						|| (!A.Get(i) && ((B.Get(i) && !carry) || (!B.Get(i) && carry))))
						Sum.Set(i, true);

					if ((A.Get(i) && (B.Get(i) || carry)) || (B.Get(i) && carry))
					{
						carry = true;
					}

					else
						carry = false;
					
				}
				if (carry)
					System.Console.WriteLine("overflow exponent");
				return Sum;
			}

			// Subtract and add are the same thing just with positive and negative i can add positive and negative
			// i can subtract // and there is no hardware that does subtract
		}

		static void Main(string[] args)
		{
			// addition
			// example 1:
			Console.WriteLine("addition examples");
			Console.WriteLine("0.375 + 0.25 = 0.625");
			MiniFloat a = new MiniFloat(false, 0, 3);
			Console.WriteLine(a.ToDouble(a));
			MiniFloat b = new MiniFloat(false, 0, 2);
			Console.WriteLine(b.ToDouble(b));
			MiniFloat c = a.Add(a, b);
			Console.WriteLine(c.ToDouble(c));
			Console.WriteLine(" ");
			// example 2 
			Console.WriteLine("1.25 + 0.75 = 2");
			a = new MiniFloat(false, 1, 5);
			Console.WriteLine(a.ToDouble(a));
			b = new MiniFloat(false, 0, 6);
			Console.WriteLine(b.ToDouble(b));
			c = a.Add(a, b);
			Console.WriteLine(c.ToDouble(c));
			Console.WriteLine(" ");
			// example 3
			Console.WriteLine("3 + 1 = 4");
			a = new MiniFloat(false, 3, 3);
			Console.WriteLine(a.ToDouble(a));
			b = new MiniFloat(false, 1, 4);
			Console.WriteLine(b.ToDouble(b));
			c = a.Add(a, b);
			Console.WriteLine(c.ToDouble(c));
			Console.WriteLine(" ");
			// Subtraction
			// example 1:
			Console.WriteLine("subtraction examples");
			Console.WriteLine("0.25 -0.375 = -0.125");
			a = new MiniFloat(true, 0, 3);
			Console.WriteLine(a.ToDouble(a));
			b = new MiniFloat(false, 0, 2);
			Console.WriteLine(b.ToDouble(b));
			c = a.Add(a, b);
			Console.WriteLine(c.ToDouble(c));
			Console.WriteLine(" ");
			// example 2 
			Console.WriteLine("0.75-1.25 = -0.5");
			a = new MiniFloat(true, 1, 5);
			Console.WriteLine(a.ToDouble(a));
			b = new MiniFloat(false, 0, 6);
			Console.WriteLine(b.ToDouble(b));
			c = a.Add(a, b);
			Console.WriteLine(c.ToDouble(c));
			Console.WriteLine(" ");
			// example 3
			Console.WriteLine("1-3 = -2");
			a = new MiniFloat(true, 3, 3);
			Console.WriteLine(a.ToDouble(a));
			b = new MiniFloat(false, 1, 4);
			Console.WriteLine(b.ToDouble(b));
			c = a.Add(a, b);
			Console.WriteLine(c.ToDouble(c));
			Console.WriteLine(" ");

			// Multiplication
			// example 1:
			Console.WriteLine("multiplication examples");
			Console.WriteLine("0.25*0.375 = 0.09375");
			a = new MiniFloat(false, 0, 3);
			Console.WriteLine(a.ToDouble(a));
			b = new MiniFloat(false, 0, 2);
			Console.WriteLine(b.ToDouble(b));
			c = a.Multiply(a, b);
			Console.WriteLine(c.ToDouble(c));
			Console.WriteLine(" ");
			// example 2 
			Console.WriteLine("01.5*2 = 3");
			a = new MiniFloat(false, 1, 6);
			Console.WriteLine(a.ToDouble(a));
			b = new MiniFloat(false, 2, 4);
			Console.WriteLine(b.ToDouble(b));
			c = a.Multiply(a, b);
			Console.WriteLine(c.ToDouble(c));
			Console.WriteLine(" ");
			// example 3
			Console.WriteLine("1*-3 = -3");
			a = new MiniFloat(true, 3, 3);
			Console.WriteLine(a.ToDouble(a));
			b = new MiniFloat(false, 1, 4);
			Console.WriteLine(b.ToDouble(b));
			c = a.Multiply(a, b);
			Console.WriteLine(c.ToDouble(c));
			Console.WriteLine(" ");

			// Division
			// example 1:
			Console.WriteLine("Divison examples");
			Console.WriteLine("0.25*0.375 = 0.09375");
			a = new MiniFloat(false, 4, 1);
			Console.WriteLine(a.ToDouble(a));
			b = new MiniFloat(false, 3, 7);
			Console.WriteLine(b.ToDouble(b));
			c = a.Divide(b, a);
			Console.WriteLine(c.ToDouble(c));
			Console.WriteLine(" ");
			// example 2 
			Console.WriteLine("01.5*2 = 3");
			a = new MiniFloat(false, 2, 1);
			Console.WriteLine(a.ToDouble(a));
			b = new MiniFloat(false, 3, 7);
			Console.WriteLine(b.ToDouble(b));
			c = a.Divide(a, b);
			Console.WriteLine(c.ToDouble(c));
			Console.WriteLine(" ");
			// example 3
			Console.WriteLine("1*-3 = -3");
			a = new MiniFloat(false, 3, 3);
			Console.WriteLine(a.ToDouble(a));
			b = new MiniFloat(false, 3, 1);
			Console.WriteLine(b.ToDouble(b));
			c = a.Divide(a, b);
			Console.WriteLine(c.ToDouble(c));
			Console.WriteLine(" ");
			// i had it working then it idk 


			Console.ReadLine();
		}
	}
}
