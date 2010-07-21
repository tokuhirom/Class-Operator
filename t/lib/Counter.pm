package t::lib::Counter;
use strict;
use warnings;
use Class::Operator;

sub import {
    my ($class, $opts) = @_;

    my $name = $opts->{name} // die;

    with caller(0) => sub {
        mk_accessors $name;
        method "increment_${name}" => sub {
            $_[0]->$name( $_[0]->$name + 1 );
        };
        method "reset_${name}" => sub {
            $_[0]->$name( 0 );
        };
    };
}

1;
