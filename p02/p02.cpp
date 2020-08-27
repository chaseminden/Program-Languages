//File p01.cpp processes command line arguments and invokes lex (yylex)
//to find tokens in the input file.
//----------------------------------------------------------------------
//Author: 1: Chase Minden
//Student ID: *20469963
//E-mail: caminden@uco.edu
//Author: 2: Tommie Walker
//Student ID: *20422860
//E-mail: twalker38@uco.edu
//Course : CMSC 4023 - Programming Languages
//CRN : 21950
//Project: P01
//Due Date: Febuary 26, 2020
//Project Account number: tt068
//---------------------------------------------------------------------
//C++ include files
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <fstream>
#include <iomanip>
#include <cstdio>
#include <string>

#include "p02lex.h"
#include "p02par.h"

using namespace std;

ofstream opf;
//-----------------------------------------------------------------------
//FileException is thrown when a file whose name is given on the command line
//cannot be opened.
//-----------------------------------------------------------------------
struct FileException
{
    FileException(string fn)
    {
        cout << endl;
        cout << "File " << fn << " cannot be opened.";
        cout << endl;
    }
};
//-----------------------------------------------------------------------
//Commandlineerror is thrown when too many arguments are put on the
//command line
//-----------------------------------------------------------------------
struct CommandLineException
{
    CommandLineException(int m, int a)
    {
        cout << endl;
        cout << "Too many file names on the command line.";
        cout << endl;
        cout << "A maximum of " << m << " file names can appear on the command line.";
        cout << endl;
        cout << a << " file names were entered.";
        cout << endl;
        cout << "p01 (<input file name> (<output file name>))";
    }
};

//--------------------------------------------------------------------
//Function LexMgr processes the input file, calls yylex, the scanner, and
//produces the output file.
//-----------------------------------------------------------------------
void ParMgr(FILE* i)
{   
	Parser P(i); //
	int rc= P.Parse();    

}
//--------------------------------------------------------------------
//pasExtension gives a boolean response to see if the file input is of .pas
//--------------------------------------------------------------------

bool pasExtension(string ifn)
{
    string delimiter = ".";
    string prefix = ifn.substr(0, ifn.find(delimiter));
    string extension = ifn.substr(ifn.find(delimiter), ifn.length());
	if (extension == ".pas")
    {
        return true;
    }
    else
    {
        return false;
    }
}
//--------------------------------------------------------------------
//prefix returns a string of .pas to a string of .trc
//--------------------------------------------------------------------
string prefix(string ifn)
{
    string outputFile;
    string delimiter = ".";
    string extension = ".trc"; 
    string prefix = ifn.substr(0, ifn.find(delimiter));
    if (pasExtension(ifn))
    {
         return outputFile = prefix + extension;
    }
}

//--------------------------------------------------------------------
//Function main processes command line arguments
//--------------------------------------------------------------------
int main(int argc, char* argv[])
{  
   
    try
    {
        char ifn[255];
	string ofn;
        switch (argc)
        {
        case 1: //Prompt for the input file name
            cout << "Enter the input file name. ";
            cin >> ifn;
	    ofn = prefix(ifn);
		break;	    
      	case 2:
		strcpy(ifn, argv[1]);
		ofn = prefix(ifn);
		break;
	case 3:
		strcpy(ifn, argv[1]);
		ofn = argv[2];
		break;
	default:
            throw CommandLineException(2, argc - 1);
            break;
        }
	
      if (pasExtension(ifn))
        {
            FILE *i = fopen(ifn, "r");
            if (!i) throw FileException(ifn);
            opf.open(ofn);
            if (!opf) throw FileException(ofn);
            //Open the input file
            
	    ParMgr(i);
            opf << endl;
	    fclose(i);
            opf.close();
        }
    }
    catch (...)
    {
        cout << endl;
        cout << "Program Terminated!";
        cout << endl;
        cout << "I won't be back!";
        cout << endl;
        exit(EXIT_FAILURE);
    }
    return 0;
}
