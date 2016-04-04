#!/usr/bin/perl
use strict;
use warnings;

exit main();

sub main {
  # if no args, print usage
  if (@ARGV != 2) {
    print_usage();
  }
  # -- else get command line args
  my @time;
  my $mileage, my $param;

  foreach $param (@ARGV) {
    if (index($param, ':') != -1) {
      @time = split /:/, $param;
    }
    else {
      $mileage = $param;
    }
  }

  my @pace = calc_pace($mileage, @time);
  printf "$pace[0]:%05.2f min/mile pace\n", $pace[1];
}

## Print Usage if not proper count of command line arguments ##
sub print_usage {
  print "usage:\t\t$0 <[hh:]mm[:ss]> <mileage>\n";
  print "--example:\t$0 1:51 13.1\n";
  exit;
}

## calc_pace() takes the mileage, and the time as parameters & returns
## the minutes & seconds of the pace for that time/distance
sub calc_pace {
  my $miles = shift @_; # shift pops first var off @_ parameters & into $miles
  my @time = @_;        # rest of the parameters
  my $minutes;
  if (@time == 3) {
    $minutes = ($time[0] * 60) + ($time[1]) + ($time[2] / 60);
  }
  elsif (@time == 2) {
    $minutes = $time[0] + ($time[1] / 60);
  }
  my $pace = $minutes/$miles;
  my $pace_min = int($minutes/$miles);
  my $pace_sec = ($pace - $pace_min) * 60;

  return ($pace_min, $pace_sec);
}
