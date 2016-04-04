#!/usr/bin/perl
use strict;
use warnings;

exit main();

sub main {
  my @time;
  my $distance, my $quiet_mode = 0;
  my $param, my $param_count = 0;
  my $dist_type = "mile";

  # assign command-line args
  foreach $param (@ARGV) {
    if (index($param, ':') != -1) {
      @time = split /:/, $param;
      $param_count += 1;
    }
    elsif ($param eq "-q" || $param eq "--quiet"){
      $quiet_mode = 1;
      $param_count += 1;
    }
    elsif ($param eq "-k" || $param eq "--km") {
      $dist_type = "km";
      $param_count += 1;
    }
    elsif ($param =~ /[0-9\.]+/) {
      $distance = $param;
      $param_count += 1;
    }
  }
  if (@ARGV < 2 || $param_count != @ARGV) {
    print_usage();
    return 1;
  }
  my @pace = calc_pace($distance, @time);
  if ($quiet_mode) {
    printf "$pace[0]:%05.2f\n", $pace[1];
  }
  else {
    printf "$pace[0]:%05.2f min/$dist_type pace\n", $pace[1];
  }
  return 0;
}

## Print Usage if not proper count of command line arguments ##
sub print_usage {
  print "usage: $0 [-qk] h:mm:ss distance\n";
  print "    -q: quiet mode, print pace in time only: [mm:ss]\n";
  print "    -k: km, interprets distance in km, and returns pace in km\n";
  # print "--example:\t$0 1:51 13.1\n";
  exit;
}

## calc_pace() takes the mileage, and the time as parameters & returns
## the minutes & seconds of the pace for that time/distance
sub calc_pace {
  my $dist = shift @_;     # shift pops first var off @_ parameters & into $dist
  my @time = @_;           # rest of the parameters
  my $minutes;
  if (@time == 3) {
    $minutes = ($time[0] * 60) + ($time[1]) + ($time[2] / 60);
  }
  elsif (@time == 2) {
    $minutes = $time[0] + ($time[1] / 60);
  }
  my $pace = $minutes/$dist;
  my $pace_min = int($minutes/$dist);
  my $pace_sec = ($pace - $pace_min) * 60;

  return ($pace_min, $pace_sec);
}
