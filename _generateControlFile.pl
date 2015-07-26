#!/usr/bin/perl
#

$DB_IN=$ARGV[0];
$DB_OUT=$ARGV[1];
$TRACE_FILE=$ARGV[2];

if ($#ARGV != "2") {
	print "Usage: $0 <SOURCE_DB> <DEST_DB> <TRACEFILE>\r\n";
	exit
}

$OUTFILE="/tmp/$0_$$";
open(O,">>$OUTFILE");

$START=0;
$END=0;
open (F,$TRACE_FILE);
while(<F>) {
	$LINE=$_;
	if ($LINE =~ /STARTUP NOMOUNT/) {
		$START=1
	}
	if($START eq "1" && $END == "0") {
		$_ =~ s/REUSE DATABASE/SET DATABASE/g;
		$_ =~ s/NORESETLOGS/RESETLOGS/g;
		$_ =~ s/$DB_IN/$DB_OUT/g;
		print O $_;
	}
	if ($LINE =~ /;/) {
		$END=1;
	}
	if($END eq "1") {
	#	exit;
	}
}

print $OUTFILE;
