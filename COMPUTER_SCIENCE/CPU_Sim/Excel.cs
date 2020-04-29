using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Office.Interop.Excel;
using _Excel = Microsoft.Office.Interop.Excel;

namespace Jake_Tully_A3
{
	class Excel
	{
		string path = "";
		_Application excel = new _Excel.Application();
		Workbook wb;
		Worksheet ws;

		public Excel(string path, int Sheet)
		{
			this.path = path;
			wb = excel.Workbooks.Open(path);
			ws = wb.Worksheets[Sheet];
		}

		public int ReadCell(int i, int j)
		{
			i++;
			j++;
			if (ws.Cells[i, j].Value2 != null)
				return Convert.ToInt32(ws.Cells[i, j].Value2);
			else
				return -1;
		}

		public void Close()
		{
			wb.Close(0);
			excel.Quit();
		}

	}
}

