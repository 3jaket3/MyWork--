
#include <iostream>
#include <vector>
#include <cmath>

#include <TCanvas.h>
#include <TLatex.h>
#include <TRandom.h>
#include <TH2F.h>
#include <TF1.h>
#include <TError.h>
#include <limits>
// Calculates percentage of days where buisness cant function


using namespace std;


void caseOne(double NUM_DAYS,int NUM_SERVERS, double prob, string histname)
{
  double LOST_DAYS = 0;
  // case 1 no back up server if one or more of the ten servers fail on boot-up, the company cannot do the business until the failed server(s) are fixed

  // case1 with probabity of server failure at 1%
   TH1I *h1 = new TH1I("h1", "Server Failures prob 3%", 100,0,10);
    // int num bins, int start, int end
    int i;
    for  (i = 0; i < NUM_DAYS; i++)
	{
	  int NUM_FAILURE = gRandom->Binomial(10,0.03);
	  h1->Fill(NUM_FAILURE);
	  if(NUM_FAILURE > 0)
	    {
	      LOST_DAYS = LOST_DAYS +1;
	    }
	}
    double percentDaysOff = (NUM_DAYS - LOST_DAYS)/NUM_DAYS;

    std::cout << "percentage of days buisness on time " << percentDaysOff << endl;

  TCanvas *c1 = new TCanvas("c1","myhist",1200,400); //int width, int height

  h1->Draw();
  c1->Draw();
  c1->Print("h1.pdf");

  return;
}

void caseTwo(int NUM_DAYS, int NUM_SERVERS, double prob, string histname)
{
    // case 2 on top of the ten servers have one more server as backup if one of the ten servers fail on boot up the back up server can be used so the company still can have its business on time but if more that two servers fail on boot-up business cannot be on time
 double  LOST_DAYS = 0;

    // case 2 with probabity of 1%
 TH1I* h1 = new TH1I("h1", "Server Failures prob 3%", 100,0,10);
    // int num bins, int start, int end
    int i;
    for  (i = 0; i < NUM_DAYS; i++)
	{
	  int NUM_FAILURE = gRandom->Binomial(10,0.03);
	  
	  h1->Fill(NUM_FAILURE);
	    
	  if( NUM_FAILURE == 1 && gRandom->Binomial(1,0.03) == 1)
		{		    
		      LOST_DAYS = LOST_DAYS + 1;   
		}

	      
	    
	}
    double percentOnTime = (NUM_DAYS - LOST_DAYS)/NUM_DAYS;
    std::cout << "percentage of days buisness on time " << percentOnTime<< endl;
      TCanvas *c1 = new TCanvas("c1","myhist",1200,400); //int width, int height
  h1->Draw();
  c1->Draw();
  c1->Print("h1.pdf");
  return;
}

int main() {

  // caseOne(int NUM_DAYS,int NUM_SERVERS,int PROB_FAILURE,string histname)
  // caseTwo(int NUM_DAYS,int NUM_SERVERS,int PROB_FAILURE,string histname)

;
  caseTwo(1000,10,0.01,"prob_3%");
}
