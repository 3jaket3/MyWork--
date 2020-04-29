using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Jake_Tully_A3
{
	class Memory
	{

		// Declaration of variables
		Block[] pages;
		Block[] swaps;
		int max_pages;
		int max_swaps;
		int pages_count;
		int swaps_count;
		Random rand = new Random();

		// constructor
		public Memory(int num_pages, int num_swaps)
		{
			pages = new Block[num_pages];
			swaps = new Block[num_swaps];
			max_pages = num_pages;
			max_swaps = num_swaps;
			pages_count = 0;
			swaps_count = 0;
		}

		// removes application from memory
		public void RemoveApplication(int application)
		{
			for (int i = 0; i < max_pages; i++) // for all pages in physical memory
			{
				if(pages[i] !=null) //null check
				if (pages[i].application == application) // check if applications are same
				{ 
					pages[i] = null; // delete page
					pages_count--; // decrement page count
				}
			}
			for (int i = 0; i < max_swaps; i++) // for all pages in swap
			{
				if (swaps[i] != null) // null check
				if (swaps[i].application == application) // check if applications are same
				{
					swaps[i] = null; // delete page
				    swaps_count--; // decrement page count
				}
			}
		}

		// returns true if block is in pages
		public bool InPages(Block block)
		{
			for (int i = 0; i < max_pages; i++)
			{
				if(pages[i] !=null)
				if (pages[i].page == block.page)
					return true;
			}
			return false;
		}

		// returns trye if block is in swap
		public bool InSwap(Block block)
		{
			for (int i = 0; i < max_swaps; i++)
			{
				if (swaps[i] != null)
					if (swaps[i].page == block.page)
					return true;
			}
			return false;
		}

		// updates last time used for a page
		public void UpdateUsageInPages(Block block, int time)
		{
			for (int i = 0; i < max_pages; i++)
			{
				if(pages[i] != null)
					if (pages[i].page == block.page)
					{
						pages[i].time = i;
					}
			}
		}

		// brings a page from sawp to physical memory
		public void RecallFromSwap(Block block)
		{
			DeletePageFromSwaps(block);
			AddLRU(block);
		}

		// add page to memory according to random policy
		public bool AddRandom(Block block)
		{
			if (!PagesIsFull()) // if pages is not full
			{
				AddToPages(block); // add block to pages
				return true; // add was succesfull
			}
			else if (!SwapsIsFull()) // if swaps is not full
			{
				Block RandomSelection = pages[rand.Next(max_pages)]; // select a random page to move to swap space
				DeletePageFromPages(RandomSelection); // remove page from physical memory
				AddToSwap(RandomSelection); // move the random selection to swap
				AddToPages(block); // add block to pages
				return true; // add was succesfull
			}
			else
			{
				return false; // add wasnt successfull out of memory
			}


		}

		// add page to memory according to LRU policy
		public bool AddLRU(Block block) 
		{
			if (!PagesIsFull()) // if pages is not full
			{
				AddToPages(block); // add to pages
				return true;	// add was successfull
			}
			else if (!SwapsIsFull()) // if swaps is not full
			{
				Block LastUsed = ReturnLastUsedInPages(); // return last used page
				DeletePageFromPages(LastUsed); // delete last used page 
				AddToSwap(LastUsed); // add last used page to swap
				AddToPages(block); // add new block to pages
				return true; // add was successfull
			}
			else
			{
				return false; // add wasnt successfull system out of memory
			}


		}

		// add block to swap
		private void AddToSwap(Block block)
		{
			for (int i = 0; i < max_swaps; i++)
			{
				if (swaps[i] == null)
				{
					swaps[i] = block;
					swaps_count++;
					return;
				}
			}
		}

		// add block to pages
		private void AddToPages(Block block)
		{
			for (int i = 0; i < max_pages; i++)
			{
				if (pages[i] == null)
				{
					pages[i] = block;
					pages_count++;
					return;
				}
			}
		}


		// delete page from pages
		private void DeletePageFromPages(Block block)
		{
			for (int i = 0; i < max_pages; i++)
			{
				if (pages[i].page == block.page)
				{
					pages[i] = null;
					pages_count--;
					return;
				}
			}
		}

		// delete page from swap
		private void DeletePageFromSwaps(Block block)
		{
			for (int i = 0; i < max_swaps; i++)
			{
				if(swaps[i] != null)
				if (swaps[i].page == block.page)
				{
					swaps[i] = null;
					swaps_count--;
					return;
				}
			}
		}

		// returns lastused in pages
		private Block ReturnLastUsedInPages() 
		{
			Block LastUsed = pages[0];

			for (int i = 1; i < max_pages; i++)
			{
				if (pages[i].time < LastUsed.time)
				{
					LastUsed = pages[i];
				}	
			}

			return LastUsed;
		}

		// returns true if pages is full
		private bool PagesIsFull()
		{
			return pages_count == max_pages;
		}

		// returns true if swap is full
		private bool SwapsIsFull()
		{
			return swaps_count == max_swaps;
		}




	}
}
