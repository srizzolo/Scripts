#!/usr/bin/perl

#####################################################################
# Last Modified: 11/8/19                                            #
# Created by: Skylar Rizzolo                                        #
#                                                                   #
# Description: Given a full virus pdb, this script will return the  #
# pdb for only the asymmetric unit of a given virus.                #
#                                                                   #
# Usage: make_au.pl input_filename output_filename                  #
#####################################################################

use File::Copy;
use File::Path;
use File::Basename;

my $filename = $ARGV[0];
my $fileout = $ARGV[1];

open( IN, "<", "$filename" ) or die "$filename not found. $!";
my $i=0;
while(<IN>) {
    if (/ATOM/) {
        $i++;
        chomp($_);
    }
}
close IN;

system("echo Found $i atoms in full pdb");
open( OUT, ">", "$fileout") or die "Can't open $fileout";

my $max = $i / 60;
if ($i % 60 == 0)
{
    my $j=0;
    open( IN, "<", "$filename" ) or die "$filename not found. $!";
    while (<IN>)
    {
        if(/ATOM/)
        {
            $j++;
            print OUT "$_";
            if ($max eq $j)
            {
                last;
            }
        }
    }
    close IN;
}
else
{
    system("Echo error: total # atoms ($i) not divisible by 60. Full icosahedral virus capsid needed.");
}


system("echo Printed $max atoms of AU to $fileout");
close OUT;
