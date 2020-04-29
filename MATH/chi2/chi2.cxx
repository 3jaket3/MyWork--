#include <iostream>
#include <fstream>
#include <vector>
#include <cmath>

#include <TCanvas.h>
#include <TString.h>
#include <TH2F.h>
#include <TMath.h>
#include <TFile.h>
#include <TLatex.h>
#include <TRandom3.h>
#include <TF1.h>

using namespace std;

// if something goes wrong, this method will abort the program
void fatal(TString message) {
  cout << endl << "FATAL" << endl << message << endl << endl;
  abort();
}

// access a histogram from a ROOT file
TH1F *getHisto(TFile *f, TString hname) {
  TH1F *h = (TH1F*)f->Get(hname);
  if (h==nullptr) fatal("Cannot access histo "+hname);
  return h;
}

// draw text to the screen
void drawText(double x, double y, TString txt, int col=kBlack,
              double size=0.04) {
  static TLatex *tex = new TLatex();
  tex->SetNDC(); tex->SetTextFont(42); tex->SetTextSize(size);
  tex->SetTextColor(col); tex->DrawLatex(x,y,txt);
}

// calcualte the chi21
double chi2(TH1F *h_data, TH1F *h_pred) {
  int Nbins=h_data->GetNbinsX();
  double chi2=0;
  for (int bin=1;bin<=Nbins;++bin) {
    double n_obs = h_data->GetBinContent(bin);
  }
  return chi2;
}

int main() {
  // open the file
  TFile *f = TFile::Open("Chi2_input.root");
  if (f==nullptr) fatal("cannot open file");
  
  TH1F *h_theory1 = getHisto(f,"theory1");
  TH1F *h_theory2 = getHisto(f,"theory2");
  TH1F *h_data = getHisto(f,"data");
  int Nbins = h_data->GetNbinsX();

  // print out what is in the histogram
  for (int bin=1;bin<=h_data->GetNbinsX();++bin) {
    double Nobs = h_data->GetBinContent(bin);
    printf("Bin %2i has %5.1f observations in data\n",bin,Nobs);
    //cout << "Bin = " << bin << " has " << Nobs << " observations in data." << endl;
  }

  // draw the histograms
  h_theory1->SetStats(0);
  h_theory1->Draw();
  h_data->Draw("same");
  
  double chi2_data_theory1 = chi2(h_data,h_theory1);
  TString text = Form("#chi^{2}(data,theory1) = %.2f, #it{n}_{dof} = %i",chi2_data_theory1,Nbins);
  
  drawText( 0.4, 0.85,text);
  
  TString pdf("chi2.pdf");
  gPad->Print(pdf+"[");
  gPad->Print(pdf);
  
  
  // PART 2
  // construct pseudo experiments
  
  int Ntrials=10000;
  // creat an empty histogram with pseudo dataa
  TH1F *h_pseudodata = (TH1F*)h_data->Clone();
  for (int trial=0;trial<Ntrials;++trial) {

    // Let's construct pseudodata from the null-hypthesis, theory1
    for (int bin=1;bin<=Nbins;++bin) {
      int nobs = 0; // FIX ME!!
      h_pseudodata->SetBinContent(bin,nobs);
    }
  }

  gPad->Print(pdf);
  
  gPad->Print(pdf+"]");
  return 0;
}
