# Plugin for Foswiki - The Free and Open Source Wiki, http://foswiki.org/
#
# Copyright (C) 2014 Michael Daum http://michaeldaumconsulting.com
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details, published at
# http://www.gnu.org/copyleft/gpl.html

package Foswiki::Plugins::HighchartsPlugin::Core;

use strict;
use warnings;

use JSON ();

use constant TRACE => 0;    # toggle me

use Foswiki::Plugins::JQueryPlugin::Plugin ();
use Foswiki::Plugins::JQueryPlugin::Plugins ();

our @ISA = qw( Foswiki::Plugins::JQueryPlugin::Plugin );

sub new {
  my $class = shift;
  my $session = shift || $Foswiki::Plugins::SESSION;

  my @javaScripts = ("js/highcharts.js", "js/highcharts-3d.js");

  my $highChartsTheme = Foswiki::Func::getPreferencesValue("HIGHCHARTS_THEME");
  push @javaScripts, "js/themes/".$highChartsTheme.".js" if defined $highChartsTheme && $highChartsTheme ne "";

  my $this = $class->SUPER::new(
    $session,
    name => 'Highcharts',
    version => '4.0.4',
    author => 'Torstein Honsi',
    homepage => 'http://http://www.highcharts.com/',
    puburl => '%PUBURLPATH%/%SYSTEMWEB%/HighchartsPlugin',
    javascript => \@javaScripts
  );

  return $this;
}

sub writeDebug {
  print STDERR "HighchartsPlugin::Core - $_[0]\n" if TRACE;
}

sub HIGHCHARTS {
  my ($this, $params, $topic, $web) = @_;

  my $config = $params->{_DEFAULT};
  return "<span class='foswikiAlert'>no params found</span>" unless $config;

  my $width = $params->{width};
  $width = "100%" unless defined $width;
  $width .= "px" if $width =~ /^\d+$/;

  my $height = $params->{height};
  $height = "400px" unless defined $height;
  $height .= "px" if $height =~ /^\d+$/;

  my $id = $params->{id};
  $id = "highCharts" . Foswiki::Plugins::JQueryPlugin::Plugins::getRandom()
    unless defined $id;

  my $before = $params->{before};
  $before = '' unless defined $before;

  $before .= ';' if $before && $before !~ /;\s*$/;

  my $after = $params->{after};
  $after = '' unless defined $after;

  $after .= ';' if $after && $after !~ /;\s*$/;

  Foswiki::Func::addToZone("script", "HIGHCHARTS::" . $id, <<HERE, "JQUERYPLUGIN::HIGHCHARTS");
<script>
jQuery(function(\$) {
  $before
  \$("#$id").highcharts({$config});
  $after
});
</script>
HERE

  return "<div class='hightChartsContainer' id='$id' style='width:$width;height:$height'></div>";
}

1;

