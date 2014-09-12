# Plugin for Foswiki - The Free and Open Source Wiki, http://foswiki.org/
#
# HighchartsPlugin is Copyright (C) 2014 Michael Daum http://michaeldaumconsulting.com
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

package Foswiki::Plugins::HighchartsPlugin;

use strict;
use warnings;

use Foswiki::Func ();
use Foswiki::Plugins::JQueryPlugin ();

our $VERSION = '0.00_001';
our $RELEASE = '0.00_001';
our $SHORTDESCRIPTION = 'Highcharts for Foswiki';
our $NO_PREFS_IN_TOPIC = 1;
our $plugin;

sub initPlugin {

  Foswiki::Func::registerTagHandler('HIGHCHARTS', sub { 
    my $session = shift;
    $plugin = Foswiki::Plugins::JQueryPlugin::createPlugin('Highcharts', $session)
      unless $plugin;

    return $plugin->HIGHCHARTS(@_) if $plugin;
    return '';
  });

  return 1;
}

sub finishPlugin {
  undef $plugin;
}

1;
