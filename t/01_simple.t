use strict;
use warnings;
use Test::More;

package Foo;
use t::lib::Counter {
    name => "yo"
};

sub new {
    my ($class) = shift;
    my %args = @_==1 ? %{$_[0]} : @_;
    bless {%args}, $class;
}

package main;

my $foo = Foo->new(yo => 0);
can_ok $foo, qw/yo increment_yo reset_yo/;
$foo->increment_yo();
$foo->increment_yo();
$foo->increment_yo();
is $foo->yo(), 3;
$foo->reset_yo();
is $foo->yo(), 0;

done_testing;

